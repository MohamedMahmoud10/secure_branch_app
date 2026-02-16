import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_branch_app/config/theme/app_colors.dart';
import 'package:secure_branch_app/core/extensions/color_extension.dart';
import 'package:secure_branch_app/generated/locale_keys.g.dart';

class RegisterHeaderWidget extends StatelessWidget {
  const RegisterHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 220.h,
      decoration: BoxDecoration(
        color: AppColors.primaryDark,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60.r)),
        gradient: const LinearGradient(
          colors: <Color>[AppColors.primaryDark, AppColors.primary],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: SafeArea(
        child: Stack(
          children: <Widget>[
            PositionedDirectional(
              end: -30,
              top: -30,
              child: Icon(
                Icons.shield,
                size: 150,
                color: Colors.white.withValueOpacity(0.05),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    LocaleKeys.createSecureId.tr(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Container(height: 2.h, width: 40.w, color: AppColors.accent),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
