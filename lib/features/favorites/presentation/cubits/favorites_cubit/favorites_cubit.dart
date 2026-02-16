import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_branch_app/core/helpers/enums.dart';
import 'package:secure_branch_app/features/branch/data/models/branches_response_model.dart';
import 'package:secure_branch_app/features/favorites/data/repo/favorites_repo.dart';
import 'package:secure_branch_app/utils/app_logger.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit(this._repo)
      : super(const FavoritesState(status: GenericStateStatus.initial));

  final FavoritesRepo _repo;

  Future<void> loadFavorites() async {
    emit(state.copyWith(status: GenericStateStatus.loading));

    final List<BranchesResponseModel> cached = _repo.getCachedFavorites();
    if (cached.isNotEmpty) {
      emit(_buildLoaded(cached));
    }

    try {
      final List<BranchesResponseModel> synced = await _repo.syncFavorites();
      emit(_buildLoaded(synced));
    } catch (e) {
      AppLogger().error('FavoritesCubit.loadFavorites sync error: $e');
      if (cached.isEmpty) {
        emit(
          state.copyWith(
            status: GenericStateStatus.error,
            errorMsg: e.toString(),
          ),
        );
      }
    }
  }

  Future<void> toggleFavorite(BranchesResponseModel branch) async {
    final bool wasFavorite = state.isFavorite(branch.id);

    if (wasFavorite) {
      final List<BranchesResponseModel> updated = state.favorites
          .where((BranchesResponseModel f) => f.id != branch.id)
          .toList();
      emit(_buildLoaded(updated));

      await _repo.removeFavorite(branch.id);
    } else {
      final BranchesResponseModel model = BranchesResponseModel(
        id: branch.id,
        name: branch.name,
        address: branch.address,
        type: branch.type,
        lat: branch.lat,
        lng: branch.lng,
        phone: branch.phone,
        workingHours: branch.workingHours,
        isActive: branch.isActive,
      );
      final List<BranchesResponseModel> updated = <BranchesResponseModel>[
        ...state.favorites,
        model,
      ];
      emit(_buildLoaded(updated));

      await _repo.addFavorite(branch);
    }
  }

  FavoritesState _buildLoaded(List<BranchesResponseModel> list) {
    return FavoritesState(
      status: GenericStateStatus.loaded,
      favorites: list,
      favoriteIds: list
          .map((BranchesResponseModel f) => f.id)
          .toSet(),
    );
  }
}
