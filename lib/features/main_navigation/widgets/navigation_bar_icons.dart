import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:secure_branch_app/config/theme/app_colors.dart';

class NavBarIcon extends StatelessWidget {
  final String icon;

  final String? label;
  final bool active;
  final VoidCallback onClick;

  const NavBarIcon({
    required this.icon,
    required this.active,
    required this.onClick,
    super.key,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Column(
        children: <Widget>[
          Center(
            child: SvgPicture.asset(
              icon,
              colorFilter: ColorFilter.mode(
                active ? AppColors.accent : AppColors.textHint,
                BlendMode.srcIn,
              ),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label!,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              fontSize: 14.sp,
              color: active
                  ? Theme.of(context).colorScheme.onTertiary
                  : Theme.of(context).colorScheme.surface,
            ),
          ),
        ],
      ),
    );
  }
}
