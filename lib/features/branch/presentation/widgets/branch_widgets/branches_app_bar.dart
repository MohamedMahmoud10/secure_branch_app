import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_branch_app/config/theme/app_colors.dart';
import 'package:secure_branch_app/core/extensions/color_extension.dart';
import 'package:secure_branch_app/generated/locale_keys.g.dart';

class BranchesAppBar extends StatelessWidget {
  const BranchesAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      centerTitle: true,
      title: Text(
        LocaleKeys.secureBranches.tr(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
      ).animate().fadeIn(delay: 200.ms),
      background: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[AppColors.primaryDark, AppColors.primary],
              ),
            ),
          ),
          PositionedDirectional(
            start: -10,
            top: -10,
            child: Icon(
              Icons.hub_outlined,
              size: 140.r,
              color: AppColors.primaryWhite.withValueOpacity(0.05),
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 30.w),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: AppColors.primaryWhite.withValueOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColors.primaryWhite.withValueOpacity(0.2)),
              ),
              child: Row(
                children: <Widget>[
                  const Icon(Icons.search, color: AppColors.accent, size: 20),
                  SizedBox(width: 12.w),
                  Text(
                    LocaleKeys.searchLocations.tr(),
                    style: TextStyle(color: Colors.white70, fontSize: 13.sp),
                  ),
                ],
              ),
            ),
          ).animate().scale(delay: 400.ms),
        ],
      ),
    );
  }
}
