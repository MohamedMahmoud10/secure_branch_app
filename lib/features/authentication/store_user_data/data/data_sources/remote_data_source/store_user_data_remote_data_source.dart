import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:secure_branch_app/core/utilities/constants/index.dart';
import 'package:secure_branch_app/features/authentication/store_user_data/data/models/user_data_model.dart';
import 'package:secure_branch_app/generated/locale_keys.g.dart';
import 'package:secure_branch_app/utils/app_logger.dart';

@lazySingleton
class StoreUserDataRemoteDataSource {
  final FirebaseFirestore _client;

  StoreUserDataRemoteDataSource(this._client);

  Future<UserDataModel> storeUserData({
    required UserDataModel requestModel,
  }) async {
    try {
      final String? uid = requestModel.uId;
      if (uid == null || uid.isEmpty) {
        throw FirebaseException(
          plugin: 'store_user_data',
          code: 'invalid-uid',
          message: LocaleKeys.userIdRequired.tr(),
        );
      }
      final DocumentReference<Map<String, dynamic>> docRef = _client
          .collection(DatabaseConstants.usersDataCollection)
          .doc(uid);

      final String documentId = docRef.id;

      final UserDataModel enrichedUser = requestModel.copyWith(
        createdAt: DateTime.now(),
        documentId: documentId,
        email: requestModel.email,
        uId: requestModel.uId,
        name: requestModel.name,
      );

      await docRef.set(enrichedUser.toJson());

      return enrichedUser;
    } on FirebaseException catch (e) {
      AppLogger().error('Error From Add User To FireStore $e');
      rethrow;
    }
  }
}
