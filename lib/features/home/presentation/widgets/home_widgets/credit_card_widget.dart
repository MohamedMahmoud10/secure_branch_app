import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:secure_branch_app/config/theme/app_colors.dart';
import 'package:secure_branch_app/core/assets/app_icons.dart';
import 'package:secure_branch_app/core/extensions/color_extension.dart';

class CreditCardWidget extends StatelessWidget {
  const CreditCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            AppColors.primary,
            AppColors.biometric.withValueOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Icon(
                Icons.wifi_rounded,
                color: AppColors.primaryWhite.withValueOpacity(0.7),
              ),
              Text(
                'VISA',
                style: TextStyle(
                  color: AppColors.primaryWhite,
                  fontWeight: FontWeight.w900,
                  fontSize: 20.sp,
                ),
              ),
            ],
          ),
          SvgPicture.asset(AppIcons.simCardChipIcon, width: 40.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '**** **** **** 4290',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'CUBIC HOLDER',
                    style: TextStyle(color: Colors.white70, fontSize: 12.sp),
                  ),
                  Text(
                    '12/28',
                    style: TextStyle(color: Colors.white70, fontSize: 12.sp),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ).animate().shimmer(delay: 1.seconds, duration: 2.seconds);
  }
}
