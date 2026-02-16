import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:secure_branch_app/core/utilities/constants/index.dart';
import 'package:secure_branch_app/features/authentication/store_user_data/data/models/user_data_model.dart';
import 'package:secure_branch_app/utils/app_logger.dart';

@lazySingleton
class StoreUserDataRemoteDataSource {
  final FirebaseFirestore _client;

  StoreUserDataRemoteDataSource(this._client);

  Future<void> storeUserData({required UserDataModel requestModel}) async {
    try {
      final DocumentReference<Map<String, dynamic>> dataBase = _client
          .collection(DatabaseConstants.usersDataCollection)
          .doc();
      final String documentId = dataBase.id;
      await dataBase.set(
        requestModel.copyWith(documentId: documentId).toJson(),
      );
    } on FirebaseException catch (e) {
      AppLogger().error('Error From Add User To FireStore $e');
      rethrow;
    }
  }
}
