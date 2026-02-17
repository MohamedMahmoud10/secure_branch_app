import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_branch_app/core/common_widgets/custom_text_form_field.dart';
import 'package:secure_branch_app/core/helpers/validators.dart';
import 'package:secure_branch_app/features/authentication/login/presentation/cubits/login_cubit/login_cubit.dart';
import 'package:secure_branch_app/generated/locale_keys.g.dart';

class LoginFields extends HookWidget {
  const LoginFields({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isVisiblePassword = useState(true);
    final LoginCubit cubit = context.read<LoginCubit>();

    return Column(
      spacing: 10.h,
      children: <Widget>[
        CustomTextFormField(
          textEditingController: cubit.emailController,
          hintText: LocaleKeys.email.tr(),
          keyboardType: TextInputType.emailAddress,
          validator: Validators.validateEmail,
          keyboardAction: TextInputAction.next,
        ),
        CustomTextFormField(
          textEditingController: cubit.passwordController,
          hintText: LocaleKeys.password.tr(),
          obscureText: isVisiblePassword.value,
          keyboardType: TextInputType.visiblePassword,
          keyboardAction: TextInputAction.done,

          suffixIcon: IconButton(
            onPressed: () => isVisiblePassword.value = !isVisiblePassword.value,
            icon: Icon(
              isVisiblePassword.value ? Icons.visibility_off : Icons.visibility,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
