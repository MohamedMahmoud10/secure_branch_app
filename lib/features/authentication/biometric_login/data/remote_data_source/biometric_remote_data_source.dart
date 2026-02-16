import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:secure_branch_app/core/utilities/constants/index.dart';
import 'package:secure_branch_app/features/authentication/store_user_data/data/models/user_data_model.dart';
import 'package:secure_branch_app/utils/app_logger.dart';

@lazySingleton
class BiometricRemoteDataSource {
  BiometricRemoteDataSource(this._client);

  final FirebaseFirestore _client;

  Future<UserDataModel?> getUserByDeviceId(String deviceId) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot = await _client
          .collection(DatabaseConstants.usersDataCollection)
          .where('deviceId', isEqualTo: deviceId)
          .where('biometricEnabled', isEqualTo: true)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) {
        AppLogger().warning(
          'BiometricRemoteDataSource.getUserByDeviceId: '
          'no user found for deviceId=$deviceId',
        );
        return null;
      }

      return UserDataModel.fromJson(snapshot.docs.first.data());
    } catch (e, st) {
      AppLogger().error('BiometricRemoteDataSource.getUserByDeviceId: $e\n$st');
      rethrow;
    }
  }

  Future<void> storeBiometricEnrollment({
    required String userId,
    required String publicKey,
    required String deviceId,
  }) async {
    try {
      await _client
          .collection(DatabaseConstants.usersDataCollection)
          .doc(userId)
          .set(<String, dynamic>{
            'biometricPublicKey': publicKey,
            'deviceId': deviceId,
            'biometricEnabled': true,
          }, SetOptions(merge: true));
      AppLogger().info(
        'BiometricRemoteDataSource.storeBiometricEnrollment: '
        'success for userId=$userId',
      );
    } catch (e, st) {
      AppLogger().error(
        'BiometricRemoteDataSource.storeBiometricEnrollment: $e\n$st',
      );
      rethrow;
    }
  }
}
