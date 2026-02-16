import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:secure_branch_app/core/error_handling/failure.dart';
import 'package:secure_branch_app/core/helpers/enums.dart';
import 'package:secure_branch_app/features/branch/data/models/branches_response_model.dart';
import 'package:secure_branch_app/features/branch/data/repo/branches_repo.dart';

part 'branches_state.dart';

class BranchesCubit extends Cubit<BranchesState> {
  final BranchesRepo _repo;

  BranchesCubit(this._repo)
    : super(const BranchesState(status: GenericStateStatus.initial));

  /// Offline-first:
  /// - Load encrypted local cache (if any) first.
  /// - Then refresh from remote (parse in isolate) and sync back to local.
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

    final Result<List<BranchesResponseModel>, Failure> result =
        await _repo.fetchAndCacheBranches();
    result.when(
      (List<BranchesResponseModel> success) => emit(
        state.copyWith(
          status: GenericStateStatus.loaded,
          responseModel: success,
        ),
      ),
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
  }
}
