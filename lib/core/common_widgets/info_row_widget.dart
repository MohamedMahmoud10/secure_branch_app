import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_branch_app/config/theme/app_colors.dart';

class InfoRowWidget extends StatelessWidget {
  const InfoRowWidget({required this.title, super.key, this.trailing});

  final String title;

  final String? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        if (trailing != null)
          Text(
            trailing!,
            style: TextStyle(color: AppColors.primaryLight, fontSize: 12.sp),
          ),
      ],
    );
  }
}
