import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:secure_branch_app/config/navigation/route_names.dart';
import 'package:secure_branch_app/core/common_widgets/toast_manager.dart';
import 'package:secure_branch_app/features/authentication/register/presentation/cubits/register_cubit/register_cubit.dart';
import 'package:secure_branch_app/generated/locale_keys.g.dart';

class RegisterListenerWidget extends StatelessWidget {
  const RegisterListenerWidget({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (BuildContext context, RegisterState state) {
        final RegisterCubit cubit = context.read<RegisterCubit>();
        if (state.isLoaded) {
          ToastManager().success(
            context: context,
            message: LocaleKeys.successMessage.tr(),
            description: LocaleKeys.welcomeMessage.tr(
              namedArgs: <String, String>{'email': cubit.emailController.text},
            ),
          );
          context.go(RouteNames.home);
        } else if (state.isError) {
          ToastManager().error(
            context: context,
            message: LocaleKeys.errorMessage.tr(),
            description: state.errorMsg ?? LocaleKeys.errorDescription.tr(),
          );
        }
      },
      child: child,
    );
  }
}
