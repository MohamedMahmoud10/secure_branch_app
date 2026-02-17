import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:secure_branch_app/config/navigation/route_names.dart';
import 'package:secure_branch_app/config/theme/app_colors.dart';
import 'package:secure_branch_app/core/assets/app_icons.dart';
import 'package:secure_branch_app/core/extensions/color_extension.dart';
import 'package:secure_branch_app/generated/locale_keys.g.dart';

class BranchesActionButton extends StatelessWidget {
  const BranchesActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.go(RouteNames.branches),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: <Color>[AppColors.primary, AppColors.primaryLight],
          ),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: AppColors.primary.withValueOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            SvgPicture.asset(
              AppIcons.mapIcon,
              width: 30.w,
              height: 30.h,
              colorFilter: const ColorFilter.mode(
                AppColors.primaryWhite,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  LocaleKeys.findNearestBranches.tr(),
                  style: TextStyle(
                    color: AppColors.primaryWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
                Text(
                  LocaleKeys.locateCubicSecurePoints.tr(),
                  style: TextStyle(color: Colors.white70, fontSize: 12.sp),
                ),
              ],
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.primaryWhite,
              size: 16,
            ),
          ],
        ),
      ),
    ).animate().slideX(begin: 0.1, end: 0);
  }
}
