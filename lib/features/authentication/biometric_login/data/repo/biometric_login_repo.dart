import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:secure_branch_app/features/authentication/biometric_login/data/remote_data_source/biometric_remote_data_source.dart';
import 'package:secure_branch_app/features/authentication/store_user_data/data/data_sources/local_data_source/save_user_data_local_data_source.dart';
import 'package:secure_branch_app/features/authentication/store_user_data/data/models/user_data_model.dart';
import 'package:secure_branch_app/utils/app_logger.dart';

@lazySingleton
class BiometricLoginRepo {
  BiometricLoginRepo(this._remoteDataSource, this._localDataSource);

  final BiometricRemoteDataSource _remoteDataSource;
  final SaveUserDataLocalDataSource _localDataSource;

  Future<Result<UserDataModel, Exception>> getUserByDeviceId(
    String deviceId,
  ) async {
    try {
      final UserDataModel? user = await _remoteDataSource.getUserByDeviceId(
        deviceId,
      );
      if (user == null) {
        return Error<UserDataModel, Exception>(
          Exception('No biometric enrollment found for this device.'),
        );
      }
      return Success<UserDataModel, Exception>(user);
    } on FirebaseException catch (e) {
      AppLogger().error('BiometricLoginRepo.getUserByDeviceId: $e');
      return Error<UserDataModel, Exception>(e);
    }
  }

  Future<Result<void, Exception>> storeBiometricEnrollment({
    required String userId,
    required String publicKey,
    required String deviceId,
  }) async {
    try {
      await _remoteDataSource.storeBiometricEnrollment(
        userId: userId,
        publicKey: publicKey,
        deviceId: deviceId,
      );
      return const Success<void, Exception>(null);
    } on FirebaseException catch (e) {
      AppLogger().error('BiometricLoginRepo.storeBiometricEnrollment: $e');
      return Error<void, Exception>(e);
    }
  }

  Future<void> cacheUserData(UserDataModel userDataModel) async {
    await _localDataSource.saveUserData(userDataModel);
  }
}
