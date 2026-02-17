import 'dart:math' as math;

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:secure_branch_app/core/error_handling/failure.dart';
import 'package:secure_branch_app/core/helpers/enums.dart';
import 'package:secure_branch_app/features/branch/data/models/branches_response_model.dart';
import 'package:secure_branch_app/features/branch/data/repo/branches_repo.dart';
import 'package:secure_branch_app/utils/app_logger.dart';

part 'branches_state.dart';

class BranchesCubit extends Cubit<BranchesState> {
  final BranchesRepo _repo;

  BranchesCubit(this._repo)
    : super(const BranchesState(status: GenericStateStatus.initial));

  Future<void> getBranches() async {
    emit(state.copyWith(status: GenericStateStatus.loading));

    final List<BranchesResponseModel> cached = await _repo.getCachedBranches();
    if (cached.isNotEmpty) {
      emit(
        state.copyWith(
          status: GenericStateStatus.loaded,
          responseModel: cached,
        ),
      );
    }

    final Result<List<BranchesResponseModel>, Failure> result = await _repo
        .fetchAndCacheBranches();

    List<BranchesResponseModel> allBranches = cached;
    result.when(
      (List<BranchesResponseModel> success) {
        allBranches = success;
        emit(
          state.copyWith(
            status: GenericStateStatus.loaded,
            responseModel: success,
          ),
        );
      },
      (Failure error) {
        if (cached.isEmpty) {
          emit(
            state.copyWith(
              status: GenericStateStatus.error,
              errorMsg: error.message,
            ),
          );
        }
      },
    );

    if (allBranches.isNotEmpty) {
      await _computeNearestBranches(allBranches);
    }
  }

  Future<void> _computeNearestBranches(
    List<BranchesResponseModel> allBranches,
  ) async {
    try {
      final Position? position = await _getUserPosition();

      if (position == null) {
        AppLogger().warning('Could not get user location. Showing all.');
        emit(
          state.copyWith(
            hasLocation: false,
            otherBranches: allBranches,
            nearestBranches: <BranchWithDistance>[],
          ),
        );
        return;
      }

      AppLogger().info(
        'User location: ${position.latitude}, ${position.longitude}',
      );

      final FilteredBranchesResult filtered = await compute(
        _filterBranchesInIsolate,
        _FilterPayload(
          branches: allBranches,
          userLat: position.latitude,
          userLng: position.longitude,
          nearestCount: 50,
        ),
      );

      emit(
        state.copyWith(
          hasLocation: true,
          nearestBranches: filtered.nearest,
          otherBranches: filtered.others,
        ),
      );
    } catch (e, st) {
      AppLogger().error('Error computing nearest branches: $e\n$st');
      emit(
        state.copyWith(
          hasLocation: false,
          otherBranches: allBranches,
          nearestBranches: <BranchWithDistance>[],
        ),
      );
    }
  }

  Future<Position?> _getUserPosition() async {
    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return null;

    final LocationPermission permission = await Geolocator.checkPermission();

    if (permission != LocationPermission.always &&
        permission != LocationPermission.whileInUse) {
      return null;
    }

    return Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.medium,
        timeLimit: Duration(seconds: 5),
      ),
    );
  }
}


class _FilterPayload {
  final List<BranchesResponseModel> branches;
  final double userLat;
  final double userLng;
  final int nearestCount;

  const _FilterPayload({
    required this.branches,
    required this.userLat,
    required this.userLng,
    required this.nearestCount,
  });
}

class FilteredBranchesResult {
  final List<BranchWithDistance> nearest;
  final List<BranchesResponseModel> others;

  const FilteredBranchesResult({
    required this.nearest,
    required this.others,
  });
}

FilteredBranchesResult _filterBranchesInIsolate(_FilterPayload payload) {
  final List<BranchWithDistance> withDistance = <BranchWithDistance>[];

  for (final BranchesResponseModel branch in payload.branches) {
    if (branch.lat == null || branch.lng == null) continue;

    final double km = _haversineKm(
      payload.userLat,
      payload.userLng,
      branch.lat!,
      branch.lng!,
    );
    withDistance.add(BranchWithDistance(branch: branch, distanceKm: km));
  }

  withDistance.sort(
    (BranchWithDistance a, BranchWithDistance b) =>
        a.distanceKm.compareTo(b.distanceKm),
  );

  final List<BranchWithDistance> nearest =
      withDistance.take(payload.nearestCount).toList();

  final Set<String> nearestIds =
      nearest.map((BranchWithDistance e) => e.branch.id).toSet();

  final List<BranchesResponseModel> others = payload.branches
      .where((BranchesResponseModel b) => !nearestIds.contains(b.id))
      .toList();

  return FilteredBranchesResult(nearest: nearest, others: others);
}


double _haversineKm(double lat1, double lon1, double lat2, double lon2) {
  const double earthRadiusKm = 6371;

  final double dLat = _degToRad(lat2 - lat1);
  final double dLon = _degToRad(lon2 - lon1);

  final double a =
      math.sin(dLat / 2) * math.sin(dLat / 2) +
      math.cos(_degToRad(lat1)) *
          math.cos(_degToRad(lat2)) *
          math.sin(dLon / 2) *
          math.sin(dLon / 2);

  final double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

  return earthRadiusKm * c;
}

double _degToRad(double deg) => deg * (math.pi / 180.0);
