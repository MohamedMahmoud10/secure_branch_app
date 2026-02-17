import 'package:injectable/injectable.dart';
import 'package:secure_branch_app/core/infrastructure/local_data_base/base_local_data_base.dart';
import 'package:secure_branch_app/core/utilities/constants/index.dart';
import 'package:secure_branch_app/features/branch/data/models/branches_response_model.dart';

@lazySingleton
class FavoritesLocalDataSource {
  FavoritesLocalDataSource(this._db);

  final BaseDatabase _db;

  List<BranchesResponseModel> getCachedFavorites() {
    return _db.getAll<BranchesResponseModel>(
          tableName: DatabaseConstants.favoritesTable,
        ) ??
        <BranchesResponseModel>[];
  }

  Future<void> replaceAll(List<BranchesResponseModel> favorites) async {
    await _db.clear<BranchesResponseModel>(
      tableName: DatabaseConstants.favoritesTable,
    );
    if (favorites.isEmpty) return;
    await _db.saveAll<BranchesResponseModel>(
      tableName: DatabaseConstants.favoritesTable,
      list: favorites,
      keys: favorites
          .map((BranchesResponseModel f) => f.id)
          .toList(),
    );
  }

  Future<void> add(BranchesResponseModel favorite) async {
    await _db.save<BranchesResponseModel>(
      tableName: DatabaseConstants.favoritesTable,
      key: favorite.id,
      value: favorite,
    );
  }

  Future<void> remove(String branchId) async {
    await _db.delete<BranchesResponseModel>(
      tableName: DatabaseConstants.favoritesTable,
      key: branchId,
    );
  }
}
