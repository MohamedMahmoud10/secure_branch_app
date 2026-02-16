import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:secure_branch_app/config/navigation/route_names.dart';
import 'package:secure_branch_app/core/common_widgets/toast_manager.dart';
import 'package:secure_branch_app/core/helpers/enums.dart';
import 'package:secure_branch_app/features/authentication/login/presentation/cubits/login_cubit/login_cubit.dart';
import 'package:secure_branch_app/features/authentication/store_user_data/data/models/user_data_model.dart';
import 'package:secure_branch_app/generated/locale_keys.g.dart';

class LoginListenerWidget extends StatelessWidget {
  const LoginListenerWidget({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (BuildContext context, LoginState state) async {
        if (state.isLoaded &&
            state.biometricEnrollmentStatus == BiometricEnrollmentStatus.idle) {
          final UserDataModel? responseData = state.userDataModel;

          ToastManager().success(
            context: context,
            message: LocaleKeys.successMessage.tr(),
            description: LocaleKeys.welcomeMessage.tr(
              namedArgs: <String, String>{'email': responseData?.email ?? ''},
            ),
          );

          final LoginCubit cubit = context.read<LoginCubit>();
          await cubit.enrollBiometric();

          if (context.mounted) {
            context.go(RouteNames.home);
          }
        } else if (state.isBiometricEnrolled) {
          ToastManager().success(
            context: context,
            message: LocaleKeys.biometricEnrolledSuccess.tr(),
            description: LocaleKeys.biometricEnrolledDescription.tr(),
          );
        } else if (state.isError) {
          ToastManager().error(
            context: context,
            message: LocaleKeys.loginErrorMessage.tr(),
            description:
                state.errorMsg ?? LocaleKeys.loginErrorDescription.tr(),
          );
        }
      },
      child: child,
    );
  }
}
