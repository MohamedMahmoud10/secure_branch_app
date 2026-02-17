import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_branch_app/config/theme/app_colors.dart';
import 'package:secure_branch_app/core/common_widgets/animations/app_animated_shimmer_widget.dart';
import 'package:secure_branch_app/core/extensions/color_extension.dart';

class BranchShimmerView extends StatelessWidget {
  const BranchShimmerView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: 10,
      separatorBuilder: (_, __) => Divider(height: 16.h),
      itemBuilder: (BuildContext context, int index) => Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.border),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: AppColors.primaryBlack.withValueOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: AppShimmerWidget(
                    width: 75.w,
                    height: 10.h,
                    borderRadius: BorderRadiusDirectional.circular(12.r),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: AppColors.error.withValueOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: AppShimmerWidget(
                    width: 65.w,
                    height: 10.h,
                    borderRadius: BorderRadiusDirectional.circular(12.r),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h),

            Row(
              children: <Widget>[
                Icon(
                  Icons.location_on_outlined,
                  size: 14.sp,
                  color: AppColors.textSecondary,
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: AppShimmerWidget(
                    width: 85.w,
                    height: 10.h,
                    borderRadius: BorderRadiusDirectional.circular(12.r),
                  ),
                ),
              ],
            ),

            Divider(height: 24.h, color: AppColors.divider),

            Row(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.location_on_outlined,
                      size: 14.sp,
                      color: AppColors.primary,
                    ),
                    SizedBox(width: 6.w),
                    AppShimmerWidget(
                      width: 85.w,
                      height: 10.h,
                      borderRadius: BorderRadiusDirectional.circular(12.r),
                    ),
                  ],
                ),
                SizedBox(width: 16.w),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.phone_outlined,
                      size: 14.sp,
                      color: AppColors.primary,
                    ),
                    SizedBox(width: 6.w),
                    AppShimmerWidget(
                      width: 85.w,
                      height: 10.h,
                      borderRadius: BorderRadiusDirectional.circular(12.r),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 16.h),
            AppShimmerWidget(
              width: 343.w,
              height: 48.h,
              borderRadius: BorderRadiusDirectional.circular(8.r),
            ),
          ],
        ),
      ),
    );
  }
}
