import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_branch_app/config/theme/app_colors.dart';
import 'package:secure_branch_app/core/assets/app_images.dart';
import 'package:secure_branch_app/core/extensions/color_extension.dart';
import 'package:secure_branch_app/generated/locale_keys.g.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 320.h,
      decoration: BoxDecoration(
        color: AppColors.primaryDark,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60.r)),
        gradient: const LinearGradient(
          colors: <Color>[AppColors.primaryDark, AppColors.primary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: <Widget>[
          PositionedDirectional(
            start: -50,
            top: -50,
            child: CircleAvatar(
              radius: 100,
              backgroundColor: AppColors.primaryLight.withValueOpacity(0.1),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(AppImages.appIcon, width: 100.w)
                    .animate(
                      onPlay: (AnimationController controller) =>
                          controller.repeat(),
                    )
                    .shimmer(
                      duration: 3.seconds,
                      color: AppColors.biometric.withValueOpacity(0.3),
                    ),
                SizedBox(height: 16.h),
                Text(
                  LocaleKeys.cubicSecure.tr(),
                  style: TextStyle(
                    color: AppColors.primaryWhite,
                    fontSize: 26.sp,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                Text(
                  LocaleKeys.enterpriseGradeProtection.tr(),
                  style: TextStyle(color: AppColors.textHint, fontSize: 14.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
