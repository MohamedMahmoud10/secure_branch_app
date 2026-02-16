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
import 'package:secure_branch_app/features/authentication/login/data/repo/get_user_data_repo.dart';
import 'package:secure_branch_app/features/authentication/store_user_data/data/models/user_data_model.dart';
import 'package:secure_branch_app/generated/locale_keys.g.dart';
import 'package:secure_branch_app/utils/app_logger.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final FirebaseAuth _auth;
  final GetUserDataRepo _repo;

  LoginCubit(this._repo, this._auth)
    : super(const LoginState(status: GenericStateStatus.initial)) {
    emailController.addListener(validateLoginFields);
    passwordController.addListener(validateLoginFields);
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormBuilderState> form = GlobalKey<FormBuilderState>();

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

    if (errors.isNotEmpty) {
      emit(
        state.copyWith(
          status: GenericStateStatus.validationError,
          validationErrors: errors,
          isFormEmpty: false,
        ),
      );
      return;
    }

    emit(
      state.copyWith(validationErrors: <String, String>{}, isFormEmpty: true),
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
