import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:secure_branch_app/config/navigation/route_names.dart';
import 'package:secure_branch_app/config/theme/app_colors.dart';
import 'package:secure_branch_app/features/authentication/register/presentation/cubits/register_cubit/register_cubit.dart';
import 'package:secure_branch_app/features/authentication/register/presentation/widgets/signup_widgets/index.dart';
import 'package:secure_branch_app/generated/locale_keys.g.dart';

class RegisterBody extends HookWidget {
  const RegisterBody({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return RegisterListenerWidget(
      child: Form(
        key: context.read<RegisterCubit>().form,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const RegisterHeaderWidget()
                  .animate()
                  .fadeIn(duration: 500.ms)
                  .slideY(begin: -0.1),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                child: Column(
                  children: <Widget>[
                    const RegisterFields(),
                    SizedBox(height: 20.h),
                    Text.rich(
                      TextSpan(
                        children: <InlineSpan>[
                          TextSpan(
                            text: LocaleKeys.alreadyPartOfTheNetwork.tr(),
                            style: theme.textTheme.labelSmall,
                          ),
                          WidgetSpan(child: SizedBox(width: 2.w)),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => context.go(RouteNames.login),
                            text: LocaleKeys.logIn.tr(),
                            style: theme.textTheme.labelMedium?.copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.primaryLight,
                            ),
                          ),
                        ],
                      ),
                    ).animate().fadeIn(delay: 300.ms).moveY(begin: 20, end: 0),
                  ],
                ).animate().fadeIn(delay: 300.ms).moveY(begin: 20, end: 0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
