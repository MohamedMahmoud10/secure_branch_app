import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:secure_branch_app/config/theme/app_colors.dart';
import 'package:secure_branch_app/core/extensions/color_extension.dart';

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
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SvgPicture.asset(
                  icon,
                  height: 24.h,
                  colorFilter: ColorFilter.mode(
                    active
                        ? AppColors.accent
                        : AppColors.textHint.withValueOpacity(0.5),
                    BlendMode.srcIn,
                  ),
                )
                .animate(target: active ? 1 : 0)
                .scale(begin: const Offset(1, 1), end: const Offset(1.2, 1.2)),
            SizedBox(height: 6.h),
            Text(
              label!,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: active ? FontWeight.bold : FontWeight.normal,
                color: active ? AppColors.accent : AppColors.textHint,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
