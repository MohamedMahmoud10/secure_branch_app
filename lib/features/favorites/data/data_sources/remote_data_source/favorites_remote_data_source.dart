import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:secure_branch_app/core/infrastructure/local_data_base/base_local_data_base.dart';
import 'package:secure_branch_app/core/utilities/constants/database_constants.dart';
import 'package:secure_branch_app/features/authentication/store_user_data/data/models/user_data_model.dart';
import 'package:secure_branch_app/features/branch/data/models/branches_response_model.dart';
import 'package:secure_branch_app/utils/app_logger.dart';

@lazySingleton
class FavoritesRemoteDataSource {
  FavoritesRemoteDataSource(this._client, this._database,);

  final FirebaseFirestore _client;
  final BaseDatabase _database;

  CollectionReference<Map<String, dynamic>> _favoritesRef() {
    final UserDataModel? userData = _database.get<UserDataModel>(
      tableName: DatabaseConstants.userDataTable,
      key: DatabaseConstants.userDataKey,
    );

    final String? userDocumentId = userData?.documentId;
    return _client

        .collection(DatabaseConstants.usersDataCollection)
        .doc(userDocumentId)
        .collection(DatabaseConstants.userFavoritesCollection);
  }

  Future<List<BranchesResponseModel>> getAll() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot = await _favoritesRef()
          .get();
      return snapshot.docs
          .map(
            (QueryDocumentSnapshot<Map<String, dynamic>> doc) =>
                BranchesResponseModel.fromJson(doc.data()),
          )
          .toList();
    } catch (e) {
      AppLogger().error('FavoritesRemoteDataSource.getAll: $e');
      rethrow;
    }
  }

  Future<void> add(BranchesResponseModel favorite) async {
    try {
      await _favoritesRef().doc(favorite.id).set(favorite.toJson());
    } catch (e) {
      AppLogger().error('FavoritesRemoteDataSource.add: $e');
      rethrow;
    }
  }

  Future<void> remove(String branchId) async {
    try {
      await _favoritesRef().doc(branchId).delete();
    } catch (e) {
      AppLogger().error('FavoritesRemoteDataSource.remove: $e');
      rethrow;
    }
  }
}
