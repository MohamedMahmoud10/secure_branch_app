import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_branch_app/config/theme/app_colors.dart';
import 'package:secure_branch_app/core/extensions/widgets_extensions.dart';

class AppStaticButton extends StatelessWidget {
  const AppStaticButton({
    required this.onTap,
    this.buttonName = 'Done',
    super.key,
    this.height,
    this.width,
    this.buttonColor,
    this.borderRadius,
    this.textColor,
    this.textStyle,
    this.child,
    this.borderColor,
    this.hasGradientColor = true,
  });

  final String? buttonName;
  final double? height;
  final double? width;
  final VoidCallback? onTap;
  final Color? buttonColor;
  final double? borderRadius;
  final Color? textColor;
  final TextStyle? textStyle;
  final Widget? child;
  final Color? borderColor;
  final bool? hasGradientColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 343.w,
      height: height ?? 48.h,
      decoration: ShapeDecoration(
        color: hasGradientColor!?null:buttonColor ?? Theme.of(context).colorScheme.onTertiary,
        gradient: hasGradientColor!
            ? LinearGradient(
                begin: const Alignment(0.11, 0.99),
                end: const Alignment(-0.11, -0.99),
                colors: <Color>[
                  Theme.of(context).colorScheme.secondary,
                  Theme.of(context).colorScheme.onSecondaryContainer,
                ],
              )
            : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor ?? Theme.of(context).colorScheme.onTertiary,
          maximumSize: Size(width ?? 343.w, height ?? 48.h),
          minimumSize: Size(width ?? 343.w, height ?? 48.h),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: borderColor ?? AppColors.transparent),
            borderRadius: BorderRadius.circular(
              borderRadius ?? 8.r,
            ),
          ),
          padding: EdgeInsets.zero,
          elevation: 0,
        ),
        onPressed: onTap,
        child: child ??
            Text(
              style: textStyle ??
                  Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: textColor ?? AppColors.primaryWhite,
                      ),
              buttonName?? '',
            ).wrapCenter(),
      ),
    );
  }
}
