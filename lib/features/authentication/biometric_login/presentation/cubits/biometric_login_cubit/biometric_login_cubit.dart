import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:secure_branch_app/core/helpers/enums.dart';
import 'package:secure_branch_app/core/services/biometric_auth_service.dart';
import 'package:secure_branch_app/core/services/biometric_crypto_service.dart';
import 'package:secure_branch_app/core/services/device_id_service.dart';
import 'package:secure_branch_app/features/authentication/login/data/repo/get_user_data_repo.dart';
import 'package:secure_branch_app/features/authentication/store_user_data/data/models/user_data_model.dart';
import 'package:secure_branch_app/generated/locale_keys.g.dart';
import 'package:secure_branch_app/utils/app_logger.dart';

part 'biometric_login_state.dart';

@injectable
class BiometricLoginCubit extends Cubit<BiometricLoginState> {
  BiometricLoginCubit(
    this._biometricAuthService,
    this._biometricCryptoService,
    this._deviceIdService,
    this._getUserDataRepo,
    this._auth,
  ) : super(const BiometricLoginState());

  final BiometricAuthService _biometricAuthService;
  final BiometricCryptoService _biometricCryptoService;
  final DeviceIdService _deviceIdService;
  final GetUserDataRepo _getUserDataRepo;
  final FirebaseAuth _auth;

  Future<void> checkBiometricAvailability() async {
    emit(state.copyWith(status: BiometricLoginStatus.checking));

    final bool hardwareAvailable = await _biometricAuthService
        .isBiometricAvailable();

    AppLogger().info('Is Support BioMetric $hardwareAvailable');
    if (!hardwareAvailable) {
      emit(state.copyWith(status: BiometricLoginStatus.unavailable));
      return;
    }

    final bool enrolled = await _biometricCryptoService.isBiometricEnrolled();
    if (!enrolled) {
      AppLogger().info('Biometric not enrolled in secure storage');
      emit(state.copyWith(status: BiometricLoginStatus.unavailable));
      return;
    }

    final bool keyExists = await _biometricAuthService.doesKeyExist();
    AppLogger().info('Biometric hardware key exists: $keyExists');
    if (!keyExists) {
      emit(state.copyWith(status: BiometricLoginStatus.unavailable));
      return;
    }

    emit(state.copyWith(status: BiometricLoginStatus.available));
  }


  Future<void> loginWithBiometric() async {
    emit(state.copyWith(status: BiometricLoginStatus.authenticating));

    try {
      final String? storedEmail = await _biometricCryptoService.retrieveEmail();
      final String? decryptedPassword = await _biometricCryptoService
          .retrievePassword();

      if (storedEmail == null || decryptedPassword == null) {
        emit(
          state.copyWith(
            status: BiometricLoginStatus.error,
            errorMsg:
                LocaleKeys.storedCredentialsNotFound.tr(),
          ),
        );
        return;
      }

      final String currentDeviceId = await _deviceIdService.getDeviceId();
      final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final String challenge = timestamp;

      AppLogger().info('Biometric login – deviceId: $currentDeviceId');
      AppLogger().info('Biometric login – challenge: $challenge');

      final String? signature = await _biometricAuthService.createSignature(
        payload: challenge,
      );

      if (signature == null) {
        emit(
          state.copyWith(
            status: BiometricLoginStatus.error,
            errorMsg: LocaleKeys.biometricAuthFailedOrCancelled.tr(),
          ),
        );
        return;
      }

      AppLogger().info(
        'Biometric login – signature obtained '
        '(length=${signature.length})',
      );

      final UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: storedEmail,
        password: decryptedPassword,
      );

      if (credential.user?.uid == null) {
        emit(
          state.copyWith(
            status: BiometricLoginStatus.error,
            errorMsg: LocaleKeys.firebaseAuthFailed.tr(),
          ),
        );
        return;
      }

      final Result<UserDataModel, FirebaseException> userResult =
          await _getUserDataRepo.getUserData(credential.user!.uid);

      UserDataModel? userData;
      userResult.when((UserDataModel success) => userData = success, (
        FirebaseException error,
      ) {
        AppLogger().warning(
          'Biometric login – could not fetch user data: ${error.message}',
        );
      });

      AppLogger().info('Biometric login – SUCCESS for $storedEmail');

      emit(
        state.copyWith(
          status: BiometricLoginStatus.authenticated,
          userDataModel: userData,
        ),
      );
    } on FirebaseAuthException catch (e) {
      AppLogger().error('Biometric login – FirebaseAuth error: ${e.message}');
      emit(
        state.copyWith(
          status: BiometricLoginStatus.error,
          errorMsg: e.message ?? LocaleKeys.authenticationFailed.tr(),
        ),
      );
    } catch (e, st) {
      AppLogger().error('Biometric login – unexpected error: $e\n$st');
      emit(
        state.copyWith(
          status: BiometricLoginStatus.error,
          errorMsg: LocaleKeys.unexpectedError.tr(),
        ),
      );
    }
  }
}
