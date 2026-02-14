import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_branch_app/config/theme/app_colors.dart';
import 'package:secure_branch_app/core/extensions/widgets_extensions.dart';

class AppAnimatedButton extends StatelessWidget {
  const AppAnimatedButton({
    required this.onTap,
    super.key,
    this.unClickableFallBack,
    this.text,
    this.height,
    this.width,
    this.backGroundColor,
    this.borderColor,
    this.textColor,
    this.unClickableButtonColor,
    this.borderRadius,
    this.child,
    this.isClickable = true,
    this.hasGradientColor = false,
  });

  final String? text;
  final VoidCallback onTap;
  final VoidCallback? unClickableFallBack;

  final double? height;
  final double? width;
  final Color? backGroundColor;
  final Color? borderColor;
  final Color? textColor;
  final Color? unClickableButtonColor;
  final bool isClickable;
  final double? borderRadius;
  final Widget? child;
  final bool hasGradientColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isClickable
            ? backGroundColor ?? Theme.of(context).colorScheme.onTertiary
            : unClickableButtonColor,
        maximumSize: Size(width ?? 343.w, height ?? 48.h),
        minimumSize: Size(width ?? 343.w, height ?? 48.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
        ),
        padding: EdgeInsets.zero,
        elevation: 0,
        side: BorderSide(
          color: borderColor ?? AppColors.transparent,
        ),
      ),
      onPressed: isClickable ? onTap : unClickableFallBack,
      child: AnimatedContainer(
        width: width ?? 343.w,
        height: height ?? 48.h,
        decoration: BoxDecoration(
          gradient: hasGradientColor
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    Theme.of(context).colorScheme.primaryContainer,
                    Theme.of(context).colorScheme.onSecondary,
                  ],
                )
              : null,
          borderRadius: BorderRadius.circular(8.r),
          color: isClickable
              ? backGroundColor ?? Theme.of(context).colorScheme.onTertiary
              : unClickableButtonColor,
        ),
        duration: const Duration(milliseconds: 300),
        child: text != null
            ? AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 300),
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: textColor ?? AppColors.primaryWhite,
                    ),
                child: Text(text!).wrapCenter(),
              )
            : child,
      ),
    );
  }
}
