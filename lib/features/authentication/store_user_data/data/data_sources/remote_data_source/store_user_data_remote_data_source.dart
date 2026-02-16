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
      final String? uid = requestModel.uId;
      if (uid == null || uid.isEmpty) {
        throw FirebaseException(
          plugin: 'store_user_data',
          code: 'invalid-uid',
          message: 'User id is required to store user data.',
        );
      }
      final DocumentReference<Map<String, dynamic>> docRef = _client
          .collection(DatabaseConstants.usersDataCollection)
          .doc(uid);
      await docRef.set(
        requestModel.copyWith(documentId: docRef.id).toJson(),
      );
    } on FirebaseException catch (e) {
      AppLogger().error('Error From Add User To FireStore $e');
      rethrow;
    }
  }
}
