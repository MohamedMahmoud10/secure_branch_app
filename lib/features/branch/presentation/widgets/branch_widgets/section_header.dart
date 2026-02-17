import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_branch_app/config/theme/app_colors.dart';
import 'package:secure_branch_app/core/extensions/color_extension.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    required this.badgeColor,
    required this.badgeText,
    required this.icon,
    required this.iconColor,
    required this.subtitle,
    required this.title,
    super.key,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String badgeText;
  final Color badgeColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 12.h),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: iconColor.withValueOpacity(0.12),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, color: iconColor, size: 20.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: badgeColor.withValueOpacity(0.12),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              badgeText,
              style: TextStyle(
                color: badgeColor,
                fontSize: 9.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
