import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:secure_branch_app/core/error_handling/index.dart';
import 'package:secure_branch_app/core/infrastructure/network/exc_handler.dart';
import 'package:secure_branch_app/features/branch/data/data_sources/local_data_source/branches_local_data_source.dart';
import 'package:secure_branch_app/features/branch/data/data_sources/remote_data_source/branches_remote_data_source.dart';
import 'package:secure_branch_app/features/branch/data/models/branches_response_model.dart';
import 'package:secure_branch_app/utils/app_logger.dart';

@lazySingleton
class BranchesRepo {
  final BranchesRemoteDataSource _remoteDataSource;
  final BranchesLocalDataSource _localDataSource;

  BranchesRepo(this._remoteDataSource, this._localDataSource);

  /// Returns the locally cached branches (encrypted at rest).
  Future<List<BranchesResponseModel>> getCachedBranches() async {
    return _localDataSource.getCachedBranches();
  }

  /// Fetches from remote (parsing in isolate), then caches to local.
  Future<Result<List<BranchesResponseModel>, Failure>>
  fetchAndCacheBranches() async {
    try {
      final List<BranchesResponseModel> result = await _remoteDataSource
          .getBranches();
      await _localDataSource.cacheBranches(result);
      return Success<List<BranchesResponseModel>, Failure>(result);
    } catch (e) {
      AppLogger().error('Error From Fetching Big Data $e');
      return Error<List<BranchesResponseModel>, Failure>(
        DioHandlerExc.handle(e).failure,
      );
    }
  }
}
