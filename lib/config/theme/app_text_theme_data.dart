import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_branch_app/config/theme/app_color_scheme.dart';
import 'package:secure_branch_app/config/theme/app_colors.dart';
import 'package:secure_branch_app/config/theme/app_theme.dart';
import 'package:secure_branch_app/core/const/dimension/dimensions.dart';

extension AppTextThemeData on AppTheme {
  static const String fontFamily = 'DINNextLTArabic';

  TextTheme get textTheme {
    return textThemeData();
  }

  TextTheme textThemeData() {
    return TextTheme(
      displayLarge: TextStyle(
        fontSize: 28.sp,
        fontWeight: AppDimensions.medium,
        fontFamily: fontFamily,
        color: colorScheme.secondary,
      ),

      displayMedium: TextStyle(
        fontSize: 16.sp,
        fontWeight: AppDimensions.bold,
        fontFamily: fontFamily,
        color: colorScheme.onTertiary,
      ),

      displaySmall: TextStyle(
        fontSize: 12.sp,
        fontWeight: AppDimensions.regular,
        fontFamily: fontFamily,
        color: colorScheme.surfaceContainer,
      ),
      headlineLarge: TextStyle(
        fontSize: 28.sp,
        fontWeight: AppDimensions.medium,
        fontFamily: fontFamily,
        color: colorScheme.primary,
      ),

      headlineMedium: TextStyle(
        fontSize: 16.sp,
        fontWeight: AppDimensions.regular,
        fontFamily: fontFamily,
        color: colorScheme.shadow,
      ),

      headlineSmall: TextStyle(
        fontSize: 14.sp,
        fontWeight: AppDimensions.regular,
        fontFamily: fontFamily,
        color: colorScheme.surfaceContainer,
      ),
      titleLarge: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        fontFamily: fontFamily,
        color: colorScheme.onSurface,
        letterSpacing: 0,
      ),

      titleMedium: TextStyle(
        fontSize: 18.sp,
        fontWeight: AppDimensions.medium,
        fontFamily: fontFamily,
        color: colorScheme.surface,
        letterSpacing: 0,
      ),

      titleSmall: TextStyle(
        fontSize: 14.sp,
        fontWeight: AppDimensions.semiBold,
        fontFamily: fontFamily,
        color: colorScheme.error,
      ),
      labelLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        fontFamily: fontFamily,
        color: colorScheme.onSurface,
        letterSpacing: 0,
      ),

      labelMedium: TextStyle(
        fontSize: 16.sp,
        fontWeight: AppDimensions.medium,
        fontFamily: fontFamily,
        color: colorScheme.primary,
      ),

      labelSmall: TextStyle(
        fontSize: 14.sp,
        fontWeight: AppDimensions.medium,
        fontFamily: fontFamily,
        color: colorScheme.shadow,
        letterSpacing: 0,
      ),

      bodyLarge: TextStyle(
        fontSize: 18.sp,
        fontFamily: fontFamily,
        fontWeight: AppDimensions.bold,
        color: colorScheme.shadow,
        letterSpacing: 0,
      ),

      ///USED
      bodyMedium: TextStyle(
        fontSize: 22.sp,
        fontWeight: AppDimensions.bold,
        fontFamily: fontFamily,
        color: AppColors.textOnPrimary,
      ),

      ///USED
      bodySmall: TextStyle(
        fontSize: 10.sp,
        fontWeight: AppDimensions.regular,
        fontFamily: fontFamily,
        color: AppColors.biometric,
      ),
    );
  }
}
