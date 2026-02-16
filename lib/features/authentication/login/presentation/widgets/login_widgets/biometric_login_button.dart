import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:secure_branch_app/config/navigation/route_names.dart';
import 'package:secure_branch_app/config/theme/app_colors.dart';
import 'package:secure_branch_app/core/common_widgets/toast_manager.dart';
import 'package:secure_branch_app/core/extensions/color_extension.dart';
import 'package:secure_branch_app/core/helpers/enums.dart';
import 'package:secure_branch_app/features/authentication/biometric_login/presentation/cubits/biometric_login_cubit/biometric_login_cubit.dart';
import 'package:secure_branch_app/generated/locale_keys.g.dart';

class BiometricLoginButton extends StatelessWidget {
  const BiometricLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BiometricLoginCubit, BiometricLoginState>(
      listener: (BuildContext context, BiometricLoginState state) {
        if (state.isAuthenticated) {
          ToastManager().success(
            context: context,
            message: LocaleKeys.biometricLoginSuccess.tr(),
            description: LocaleKeys.welcomeMessage.tr(
              namedArgs: <String, String>{
                'email': state.userDataModel?.email ?? '',
              },
            ),
          );
          if (context.mounted) {
            context.go(RouteNames.home);
          }
        } else if (state.isError) {
          ToastManager().error(
            context: context,
            message: LocaleKeys.biometricLoginFailed.tr(),
            description:
                state.errorMsg ??
                LocaleKeys.biometricLoginFailedDescription.tr(),
          );
        }
      },
      builder: (BuildContext context, BiometricLoginState state) {
        if (state.isUnavailable ||
            state.status == BiometricLoginStatus.initial ||
            state.status == BiometricLoginStatus.checking) {
          return const SizedBox.shrink();
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 24.h),

            Row(
              children: <Widget>[
                const Expanded(
                  child: Divider(color: AppColors.border, thickness: 1),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    LocaleKeys.biometricOrDivider.tr(),
                    style: Theme.of(
                      context,
                    ).textTheme.labelSmall?.copyWith(color: AppColors.textHint),
                  ),
                ),
                const Expanded(
                  child: Divider(color: AppColors.border, thickness: 1),
                ),
              ],
            ),

            SizedBox(height: 20.h),

            GestureDetector(
                  onTap: state.isAuthenticating
                      ? null
                      : () => context
                            .read<BiometricLoginCubit>()
                            .loginWithBiometric(),
                  child: AnimatedContainer(
                    duration: 300.ms,
                    width: double.infinity,
                    height: 56.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: AppColors.biometric.withValueOpacity(0.4),
                        width: 1.5,
                      ),
                      gradient: LinearGradient(
                        colors: <Color>[
                          AppColors.primaryDark.withValueOpacity(0.05),
                          AppColors.biometric.withValueOpacity(0.08),
                        ],
                      ),
                    ),
                    child: state.isAuthenticating
                        ? Center(
                            child: SpinKitRing(
                              color: AppColors.biometric,
                              size: 28.sp,
                              lineWidth: 2.w,
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.fingerprint,
                                color: AppColors.biometric,
                                size: 28.sp,
                              ),
                              SizedBox(width: 12.w),
                              Text(
                                LocaleKeys.biometricLoginButton.tr(),
                                style: Theme.of(context).textTheme.labelMedium
                                    ?.copyWith(color: AppColors.primaryLight),
                              ),
                            ],
                          ),
                  ),
                )
                .animate()
                .fadeIn(delay: 600.ms, duration: 500.ms)
                .slideY(begin: 0.2, end: 0),
          ],
        );
      },
    );
  }
}
