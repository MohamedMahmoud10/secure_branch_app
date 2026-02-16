import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_branch_app/core/common_widgets/custom_text_form_field.dart';
import 'package:secure_branch_app/core/helpers/validators.dart';
import 'package:secure_branch_app/features/authentication/register/presentation/cubits/register_cubit/register_cubit.dart';
import 'package:secure_branch_app/generated/locale_keys.g.dart';

class RegisterFields extends HookWidget {
  const RegisterFields({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isVisiblePassword = useState(true);
    final ValueNotifier<bool> isVisibleConfirmPassword = useState(true);
    final RegisterCubit cubit = context.read<RegisterCubit>();
    return Column(
      children: <Widget>[
        CustomTextFormField(
          textEditingController: cubit.nameController,
          hintText: LocaleKeys.fullName.tr(),
          keyboardType: TextInputType.name,
          validator: (String? value) =>
              Validators.validateEmptyField(value, LocaleKeys.fullName.tr()),
          keyboardAction: TextInputAction.next,

        ),
        SizedBox(height: 10.h),
        CustomTextFormField(
          textEditingController: cubit.emailController,
          hintText: LocaleKeys.email.tr(),
          keyboardType: TextInputType.emailAddress,
          validator: Validators.validateEmail,
          keyboardAction: TextInputAction.next,

        ),
        SizedBox(height: 10.h),
        SizedBox(height: 10.h),
        CustomTextFormField(
          textEditingController: cubit.passwordController,
          hintText: LocaleKeys.password.tr(),
          obscureText: isVisiblePassword.value,
          keyboardType: TextInputType.visiblePassword,
          keyboardAction: TextInputAction.next,

          suffixIcon: IconButton(
            onPressed: () => isVisiblePassword.value = !isVisiblePassword.value,
            icon: Icon(
              isVisiblePassword.value ? Icons.visibility_off : Icons.visibility,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
          validator: Validators.validatePassword,
        ),
        SizedBox(height: 10.h),
        CustomTextFormField(
          textEditingController: cubit.confirmPasswordController,
          hintText: LocaleKeys.confirmPassword.tr(),
          obscureText: isVisibleConfirmPassword.value,
          keyboardType: TextInputType.visiblePassword,
          keyboardAction: TextInputAction.done,

          suffixIcon: IconButton(
            onPressed: () => isVisibleConfirmPassword.value =
                !isVisibleConfirmPassword.value,
            icon: Icon(
              isVisibleConfirmPassword.value
                  ? Icons.visibility_off
                  : Icons.visibility,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
          validator: (String? value) => Validators.validateConfirmPassword(
            value,
            cubit.passwordController.text,
          ),
        ),
      ],
    );
  }
}
