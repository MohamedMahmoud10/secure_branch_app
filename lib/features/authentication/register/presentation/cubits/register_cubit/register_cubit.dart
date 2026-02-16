import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:secure_branch_app/core/helpers/enums.dart';
import 'package:secure_branch_app/core/helpers/validators.dart';
import 'package:secure_branch_app/core/utilities/generic_classes/generic.dart';
import 'package:secure_branch_app/features/authentication/store_user_data/data/models/user_data_model.dart';
import 'package:secure_branch_app/features/authentication/store_user_data/data/repo/store_user_data_repo.dart';
import 'package:secure_branch_app/generated/locale_keys.g.dart';
import 'package:secure_branch_app/utils/app_logger.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final StoreUserDataRepo _repo;
  final FirebaseAuth _auth;

  RegisterCubit(this._repo, this._auth)
    : super(const RegisterState(status: GenericStateStatus.initial)) {
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

        final Result<void, FirebaseException> result = await _repo
            .storeUserData(
              requestModel: UserDataModel(
                email: emailController.text,
                uId: userData.user!.uid,
              ),
            );
        result.when(
          (void success) => emit(
            state.copyWith(
              status: GenericStateStatus.loaded,
              userId: userData.user!.uid,
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
        status:  GenericStateStatus.validationError,
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
