import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_branch_app/config/theme/app_colors.dart';

class InfoTitle extends StatelessWidget {
  const InfoTitle({required this.icon, required this.text, super.key});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(icon, size: 14.sp, color: AppColors.primary),
        SizedBox(width: 6.w),
        Text(
          text,
          style: TextStyle(fontSize: 11.sp, color: AppColors.textPrimary),
        ),
      ],
    );
  }
}
