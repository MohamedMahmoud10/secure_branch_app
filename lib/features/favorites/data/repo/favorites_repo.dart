import 'package:injectable/injectable.dart';
import 'package:secure_branch_app/features/branch/data/models/branches_response_model.dart';
import 'package:secure_branch_app/features/favorites/data/data_sources/local_data_source/favorites_local_data_source.dart';
import 'package:secure_branch_app/features/favorites/data/data_sources/remote_data_source/favorites_remote_data_source.dart';
import 'package:secure_branch_app/utils/app_logger.dart';

@lazySingleton
class FavoritesRepo {
  FavoritesRepo(this._remoteDataSource, this._localDataSource);

  final FavoritesRemoteDataSource _remoteDataSource;
  final FavoritesLocalDataSource _localDataSource;

  List<BranchesResponseModel> getCachedFavorites() {
    return _localDataSource.getCachedFavorites();
  }

  Future<List<BranchesResponseModel>> syncFavorites() async {
    try {
      final List<BranchesResponseModel> remote = await _remoteDataSource.getAll();
      await _localDataSource.replaceAll(remote);
      return remote;
    } catch (e) {
      AppLogger().warning('FavoritesRepo.syncFavorites failed, using cache: $e');
      return _localDataSource.getCachedFavorites();
    }
  }

  Future<void> addFavorite(BranchesResponseModel branch) async {

    await _localDataSource.add(branch);

    try {
      await _remoteDataSource.add(branch);
    } catch (e) {
      AppLogger().error('FavoritesRepo.addFavorite remote failed: $e');
    }
  }

  Future<void> removeFavorite(String branchId) async {
    await _localDataSource.remove(branchId);

    try {
      await _remoteDataSource.remove(branchId);
    } catch (e) {
      AppLogger().error('FavoritesRepo.removeFavorite remote failed: $e');
    }
  }
}
