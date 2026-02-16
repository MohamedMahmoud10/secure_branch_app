import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:secure_branch_app/core/helpers/enums.dart';
import 'package:secure_branch_app/core/helpers/validators.dart';
import 'package:secure_branch_app/core/services/biometric_auth_service.dart';
import 'package:secure_branch_app/core/services/biometric_crypto_service.dart';
import 'package:secure_branch_app/core/services/device_id_service.dart';
import 'package:secure_branch_app/core/utilities/generic_classes/generic.dart';
import 'package:secure_branch_app/features/authentication/biometric_login/data/repo/biometric_login_repo.dart';
import 'package:secure_branch_app/features/authentication/login/data/repo/get_user_data_repo.dart';
import 'package:secure_branch_app/features/authentication/store_user_data/data/models/user_data_model.dart';
import 'package:secure_branch_app/generated/locale_keys.g.dart';
import 'package:secure_branch_app/utils/app_logger.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final FirebaseAuth _auth;
  final GetUserDataRepo _repo;
  final BiometricAuthService _biometricAuthService;
  final BiometricCryptoService _biometricCryptoService;
  final DeviceIdService _deviceIdService;
  final BiometricLoginRepo _biometricLoginRepo;

  LoginCubit(
    this._repo,
    this._auth,
    this._biometricAuthService,
    this._biometricCryptoService,
    this._deviceIdService,
    this._biometricLoginRepo,
  ) : super(const LoginState(status: GenericStateStatus.initial)) {
    emailController.addListener(validateLoginFields);
    passwordController.addListener(validateLoginFields);
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> form = GlobalKey<FormState>();

  Future<void> login() async {
    if (form.currentState!.validate()) {
      emit(state.copyWith(status: GenericStateStatus.loading));

      try {
        final UserCredential userData = await _auth.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        if (userData.user?.uid != null) {
          AppLogger().info('The User Id Is ${userData.user?.uid}');
          final Result<UserDataModel, FirebaseException> result = await _repo
              .getUserData(userData.user!.uid);
          result.when(
            (UserDataModel success) => emit(
              state.copyWith(
                status: GenericStateStatus.loaded,
                userDataModel: success,
              ),
            ),
            (FirebaseException error) => emit(
              state.copyWith(
                status: GenericStateStatus.error,
                errorMsg: error.message.toString(),
              ),
            ),
          );
        }
      } on FirebaseException catch (e) {
        AppLogger().error('Error From Firebase Auth $e');
        emit(
          state.copyWith(
            status: GenericStateStatus.error,
            errorMsg: e.message.toString(),
          ),
        );
      }
    }
  }

  // ─────────────── biometric re-enrollment after login ──────────────────

  /// Call this **after** successful email/password login to re-enroll
  /// biometric credentials so the user can use biometric next time.
  ///
  /// Flow:
  /// 1. Check hardware availability.
  /// 2. Generate hardware-backed key pair (prompts biometric).
  /// 3. Encrypt password → store in flutter_secure_storage.
  /// 4. Store public key + device ID in Firestore.
  Future<void> enrollBiometric() async {
    emit(state.copyWith(
      biometricEnrollmentStatus: BiometricEnrollmentStatus.enrolling,
    ));

    try {
      // 1. Check biometric hardware
      final bool available =
          await _biometricAuthService.isBiometricAvailable();
      if (!available) {
        AppLogger().info('Login biometric enrollment: hardware not available');
        emit(state.copyWith(
          biometricEnrollmentStatus: BiometricEnrollmentStatus.unavailable,
        ));
        return;
      }

      // 2. Create hardware-backed keys (prompts biometric)
      final String? publicKey = await _biometricAuthService.createKeys();
      if (publicKey == null) {
        AppLogger().warning(
          'Login biometric enrollment: key creation failed / cancelled',
        );
        emit(state.copyWith(
          biometricEnrollmentStatus: BiometricEnrollmentStatus.failed,
        ));
        return;
      }

      // 3. Encrypt & store password in secure storage
      await _biometricCryptoService.storeCredentials(
        email: emailController.text,
        password: passwordController.text,
      );

      // 4. Store public key + device ID in Firestore
      final String deviceId = await _deviceIdService.getDeviceId();
      final String userId = state.userDataModel!.uId!;

      await _biometricLoginRepo.storeBiometricEnrollment(
        userId: userId,
        publicKey: publicKey,
        deviceId: deviceId,
      );

      AppLogger().info(
        'Login biometric enrollment completed for $userId',
      );
      emit(state.copyWith(
        biometricEnrollmentStatus: BiometricEnrollmentStatus.enrolled,
      ));
    } catch (e, st) {
      AppLogger().error('Login biometric enrollment failed: $e\n$st');
      emit(state.copyWith(
        biometricEnrollmentStatus: BiometricEnrollmentStatus.failed,
      ));
    }
  }

  void validateLoginFields() {
    final Map<String, String> errors = <String, String>{};

    if (emailController.text.trim().isEmpty) {
      errors['email'] = LocaleKeys.validationEmailRequired.tr();
    } else if (!Validators.isValidEmail(emailController.text)) {
      errors['email'] = LocaleKeys.validationEmailInvalid.tr();
    }

    if (passwordController.text.trim().isEmpty) {
      errors['password'] = LocaleKeys.validationPasswordRequired.tr();
    }

    final bool isValidForm = errors.isEmpty;

    emit(
      state.copyWith(
        status: GenericStateStatus.validationError,
        validationErrors: errors,
        isValidForm: isValidForm,
      ),
    );
  }

  @override
  Future<void> close() {
    emailController.removeListener(validateLoginFields);
    passwordController.removeListener(validateLoginFields);

    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
