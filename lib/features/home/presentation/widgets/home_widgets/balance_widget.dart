import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_branch_app/config/theme/app_colors.dart';
import 'package:secure_branch_app/generated/locale_keys.g.dart';

class BalanceWidget extends StatelessWidget {
  const BalanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryDark,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40.r),
          bottomRight: Radius.circular(40.r),
        ),
      ),
      padding: EdgeInsets.fromLTRB(24.w, 60.h, 24.w, 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          SizedBox(height: 20.h),

          Text(
            LocaleKeys.totalBalance.tr(),
            style: TextStyle(color: AppColors.textHint, fontSize: 14.sp),
          ),
          SizedBox(height: 8.h),
          Text(
            r'$128,430.50',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: <Widget>[
              Text(
                'Acc: **** **** 8829',
                style: TextStyle(color: Colors.white54, fontSize: 12.sp),
              ),
              SizedBox(width: 10.w),
              const Icon(Icons.copy, size: 14, color: AppColors.accent),
            ],
          ),
        ],
      ),
    );
  }
}
