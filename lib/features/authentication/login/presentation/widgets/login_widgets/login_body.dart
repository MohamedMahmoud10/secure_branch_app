import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:secure_branch_app/config/navigation/route_names.dart';
import 'package:secure_branch_app/config/theme/app_colors.dart';
import 'package:secure_branch_app/features/authentication/login/presentation/cubits/login_cubit/login_cubit.dart';
import 'package:secure_branch_app/features/authentication/login/presentation/widgets/login_widgets/index.dart';
import 'package:secure_branch_app/generated/locale_keys.g.dart';

class LoginBody extends HookWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return LoginListenerWidget(
      child: FormBuilder(
        key: context.read<LoginCubit>().form,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const HeaderWidget()
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .slideY(begin: -0.2),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                child: const Column(
                  children: <Widget>[
                    LoginFields(),

                    BiometricLoginButton(),
                  ],
                ).animate().fadeIn(delay: 400.ms).moveY(begin: 30, end: 0),
              ),

              Text.rich(
                TextSpan(
                  children: <InlineSpan>[
                    TextSpan(
                      text: '${LocaleKeys.dontHaveAccount.tr()} ? ',
                      style: theme.textTheme.labelSmall,
                    ),
                    WidgetSpan(child: SizedBox(width: 2.w)),
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => context.go(RouteNames.register),
                      text: LocaleKeys.signIn.tr(),
                      style: theme.textTheme.labelMedium?.copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.primaryLight,
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: 800.ms),
            ],
          ),
        ),
      ),
    );
  }
}
