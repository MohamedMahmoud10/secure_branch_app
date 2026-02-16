import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_branch_app/core/common_widgets/custom_loading_button.dart';
import 'package:secure_branch_app/core/common_widgets/toast_manager.dart';
import 'package:secure_branch_app/core/extensions/widgets_extensions.dart';
import 'package:secure_branch_app/core/helpers/enums.dart';
import 'package:secure_branch_app/features/authentication/register/presentation/cubits/register_cubit/register_cubit.dart';
import 'package:secure_branch_app/generated/locale_keys.g.dart';

class RegisterActionButton extends StatelessWidget {
  const RegisterActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, String>? validationErrors = context
        .watch<RegisterCubit>()
        .state
        .validationErrors;

    return CustomLoadingButton<RegisterCubit, RegisterState>(
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

      loadingState: const RegisterState(status: GenericStateStatus.loading),
      cubit: context.read<RegisterCubit>(),
      onTap: context.read<RegisterCubit>().registerUser,
      isClickable: context.select<RegisterCubit, bool>(
        (RegisterCubit cubit) => !cubit.state.isFormEmpty!,
      ),
      text: LocaleKeys.signUp.tr(),
    ).paddingHorizontal(20.w).paddingVertical(10.h);
  }
}
