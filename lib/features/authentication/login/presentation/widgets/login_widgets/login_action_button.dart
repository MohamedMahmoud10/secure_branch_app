import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_branch_app/core/common_widgets/custom_loading_button.dart';
import 'package:secure_branch_app/core/common_widgets/toast_manager.dart';
import 'package:secure_branch_app/core/extensions/widgets_extensions.dart';
import 'package:secure_branch_app/core/helpers/enums.dart';
import 'package:secure_branch_app/features/authentication/login/presentation/cubits/login_cubit/login_cubit.dart';
import 'package:secure_branch_app/generated/locale_keys.g.dart';

class LoginActionButton extends StatelessWidget {
  const LoginActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, String>? validationErrors = context
        .watch<LoginCubit>()
        .state
        .validationErrors;

    return CustomLoadingButton<LoginCubit, LoginState>(
      errorCallBack: () {
        final String errorMessage = validationErrors != null
            ? validationErrors.values.first
            : LocaleKeys.validationGenericError.tr();

        ToastManager().error(
          context: context,
          description: errorMessage,
          message: LocaleKeys.validationGenericError.tr(),
        );
      },

      isClickable: context.select<LoginCubit, bool>(
        (LoginCubit cubit) => !cubit.state.isFormEmpty!,
      ),
      loadingState: const LoginState(status: GenericStateStatus.loading),
      cubit: context.read<LoginCubit>(),
      onTap: context.read<LoginCubit>().login,
      text: LocaleKeys.signIn.tr(),
    ).paddingHorizontal(20.w).paddingVertical(10.h);
  }
}
