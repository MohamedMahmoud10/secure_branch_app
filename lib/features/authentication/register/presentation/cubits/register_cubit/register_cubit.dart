import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:secure_branch_app/core/helpers/enums.dart';
import 'package:secure_branch_app/core/helpers/validators.dart';
import 'package:secure_branch_app/core/services/biometric_auth_service.dart';
import 'package:secure_branch_app/core/services/biometric_crypto_service.dart';
import 'package:secure_branch_app/core/services/device_id_service.dart';
import 'package:secure_branch_app/core/utilities/generic_classes/generic.dart';
import 'package:secure_branch_app/features/authentication/biometric_login/data/repo/biometric_login_repo.dart';
import 'package:secure_branch_app/features/authentication/store_user_data/data/models/user_data_model.dart';
import 'package:secure_branch_app/features/authentication/store_user_data/data/repo/store_user_data_repo.dart';
import 'package:secure_branch_app/generated/locale_keys.g.dart';
import 'package:secure_branch_app/utils/app_logger.dart';

part 'register_state.dart';
@injectable
class RegisterCubit extends Cubit<RegisterState> {
  final StoreUserDataRepo _repo;
  final FirebaseAuth _auth;
  final DeviceIdService _deviceIdService;
  final BiometricAuthService _biometricAuthService;
  final BiometricCryptoService _biometricCryptoService;
  final BiometricLoginRepo _biometricLoginRepo;

  RegisterCubit(
    this._repo,
    this._auth,
    this._deviceIdService,
    this._biometricAuthService,
    this._biometricCryptoService,
    this._biometricLoginRepo,
  ) : super(const RegisterState(status: GenericStateStatus.initial)) {
    emailController.addListener(validateFormFields);
    passwordController.addListener(validateFormFields);
    confirmPasswordController.addListener(validateFormFields);
  }

  final GlobalKey<FormBuilderState> form = GlobalKey<FormBuilderState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  Future<void> registerUser() async {
    if (form.currentState!.validate()) {
      emit(state.copyWith(status: GenericStateStatus.loading));

      try {
        final UserCredential userData = await _auth
            .createUserWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );

        final String deviceId = await _deviceIdService.getDeviceId();
        final Result<UserDataModel, FirebaseException> result = await _repo
            .storeUserData(
              requestModel: UserDataModel(
                email: emailController.text,
                uId: userData.user!.uid,
                name: nameController.text.trim().isEmpty
                    ? null
                    : nameController.text.trim(),
                deviceId: deviceId,
              ),
            );
        result.when(
          (UserDataModel success) => emit(
            state.copyWith(
              status: GenericStateStatus.loaded,
              userId: userData.user!.uid,
              responseModel: success,
            ),
          ),
          (FirebaseException error) => emit(
            state.copyWith(
              status: GenericStateStatus.error,
              errorMsg: error.message.toString(),
            ),
          ),
        );
      } on FirebaseAuthException catch (e) {
        AppLogger().error('Error From Firebase Auth ${e.message}');
        emit(
          state.copyWith(
            status: GenericStateStatus.error,
            errorMsg: e.message.toString(),
          ),
        );
      }
    }
  }

  Future<void> enrollBiometric() async {
    emit(
      state.copyWith(
        biometricEnrollmentStatus: BiometricEnrollmentStatus.enrolling,
      ),
    );

    try {
      /// Check biometric hardware
      final bool available = await _biometricAuthService.isBiometricAvailable();
      if (!available) {
        final BiometricStatus status = await _biometricAuthService
            .getBiometricStatus();
        switch (status) {
          case BiometricStatus.noHardware:
            emit(
              state.copyWith(
                biometricEnrollmentStatus:
                    BiometricEnrollmentStatus.unavailable,
                errorMsg: LocaleKeys.biometricNotSupported.tr(),
              ),
            );

          case BiometricStatus.notEnrolled:
            emit(
              state.copyWith(
                biometricEnrollmentStatus:
                    BiometricEnrollmentStatus.unavailable,
                errorMsg: LocaleKeys.biometricNotEnrolled.tr(),
              ),
            );
          case BiometricStatus.failure:
            emit(
              state.copyWith(
                biometricEnrollmentStatus:
                    BiometricEnrollmentStatus.unavailable,
                errorMsg: LocaleKeys.biometricNotEnrolled.tr(),
              ),
            );
            return;
        }
      }

      final String? publicKey = await _biometricAuthService.createKeys();
      if (publicKey == null) {
        emit(
          state.copyWith(
            biometricEnrollmentStatus: BiometricEnrollmentStatus.failed,
          ),
        );
        return;
      }

      await _biometricCryptoService.storeCredentials(
        email: emailController.text,
        password: passwordController.text,
      );

      final String deviceId = await _deviceIdService.getDeviceId();
      final String userId = state.userId!;

      await _biometricLoginRepo.storeBiometricEnrollment(
        userId: userId,
        publicKey: publicKey,
        deviceId: deviceId,
      );

      AppLogger().info('Biometric enrollment completed for $userId');
      emit(
        state.copyWith(
          biometricEnrollmentStatus: BiometricEnrollmentStatus.enrolled,
        ),
      );
    } catch (e, st) {
      AppLogger().error('Biometric enrollment failed: $e\n$st');
      emit(
        state.copyWith(
          biometricEnrollmentStatus: BiometricEnrollmentStatus.failed,
        ),
      );
    }
  }

  void validateFormFields() {
    final Map<String, String> errors = <String, String>{};

    if (nameController.text.trim().isEmpty) {
      errors['name'] = LocaleKeys.validationNameRequired.tr();
    }

    if (emailController.text.trim().isEmpty) {
      errors['email'] = LocaleKeys.validationEmailRequired.tr();
    } else if (!Validators.isValidEmail(emailController.text)) {
      errors['email'] = LocaleKeys.validationEmailInvalid.tr();
    }

    if (passwordController.text.trim().isEmpty) {
      errors['password'] = LocaleKeys.validationPasswordRequired.tr();
    }

    if (confirmPasswordController.text.trim().isEmpty) {
      errors['confirmPassword'] = LocaleKeys.validationConfirmPasswordRequired
          .tr();
    } else if (passwordController.text != confirmPasswordController.text) {
      errors['confirmPassword'] = LocaleKeys.validationPasswordNotMatch.tr();
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
    emailController.removeListener(validateFormFields);
    passwordController.removeListener(validateFormFields);
    confirmPasswordController.removeListener(validateFormFields);
    return super.close();
  }
}
