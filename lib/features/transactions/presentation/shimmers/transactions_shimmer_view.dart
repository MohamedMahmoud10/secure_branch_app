import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_branch_app/config/theme/app_colors.dart';
import 'package:secure_branch_app/core/common_widgets/animations/app_animated_shimmer_widget.dart';
import 'package:secure_branch_app/core/extensions/color_extension.dart';

class TransactionsShimmerView extends StatelessWidget {
  const TransactionsShimmerView({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) => Container(
          margin: EdgeInsets.only(bottom: 8.h),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12.r),
          ),

          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
            leading: CircleAvatar(
              backgroundColor: AppColors.primary.withValueOpacity(0.1),
              child: AppShimmerWidget(
                width: 45.w,
                height: 30.h,
                borderRadius: BorderRadiusDirectional.circular(99.r),
              ),
            ),
            title: AppShimmerWidget(
              width: 75.w,
              height: 10.h,
              borderRadius: BorderRadiusDirectional.circular(12.r),
            ),
            subtitle: AppShimmerWidget(
              width: 55.w,
              height: 10.h,
              borderRadius: BorderRadiusDirectional.circular(12.r),
            ),
            trailing: AppShimmerWidget(
              width: 45.w,
              height: 10.h,
              borderRadius: BorderRadiusDirectional.circular(12.r),
            ),
          ),
        ),
        childCount: 10,
      ),
    );
  }
}
