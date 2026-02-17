import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_branch_app/config/theme/app_colors.dart';
import 'package:secure_branch_app/core/extensions/color_extension.dart';
import 'package:secure_branch_app/generated/locale_keys.g.dart';

class BranchStatusIndicator extends StatelessWidget {
  const BranchStatusIndicator({required this.isActive, super.key});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.success.withValueOpacity(0.1)
            : AppColors.error.withValueOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        isActive ? LocaleKeys.open.tr() : LocaleKeys.closed.tr(),
        style: TextStyle(
          color: isActive ? AppColors.success : AppColors.error,
          fontSize: 10.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
