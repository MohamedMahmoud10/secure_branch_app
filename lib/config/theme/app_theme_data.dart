import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_branch_app/config/theme/app_color_scheme.dart';
import 'package:secure_branch_app/config/theme/app_colors.dart';
import 'package:secure_branch_app/config/theme/app_text_theme_data.dart';
import 'package:secure_branch_app/config/theme/app_theme.dart';
import 'package:secure_branch_app/core/extensions/color_extension.dart';

extension AppThemeData on AppTheme {
  ThemeData themeData() {
    const String fontFamily = 'DINNextLTArabic';
    return ThemeData(
      primaryColorLight: AppColors.primaryWhite,
      fontFamily: fontFamily,
      colorScheme: colorScheme,
      textTheme: textThemeData(),
      scaffoldBackgroundColor: AppColors.primaryWhite,
      textSelectionTheme: TextSelectionThemeData(
        selectionHandleColor: colorScheme.secondary,
        selectionColor: colorScheme.secondary,
        cursorColor: colorScheme.shadow,
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.r),
        ),
      ),
      tabBarTheme: TabBarThemeData(
        indicator: BoxDecoration(
          color: colorScheme.onSecondary,
          borderRadius: BorderRadius.circular(8.r),
        ),
        labelStyle: textTheme.bodySmall?.copyWith(
          color: colorScheme.secondary,
        ),
        unselectedLabelStyle: textTheme.bodySmall,
      ),
    );
  }
}extension AppDarkThemeData on AppTheme {
  ThemeData darkThemeData() {
    const String fontFamily = 'DINNextLTArabic';
    return ThemeData(
      primaryColorLight: colorScheme.primary,
      fontFamily: fontFamily,
      colorScheme: colorScheme,
      textTheme: textThemeData(),
      scaffoldBackgroundColor: colorScheme.primary,
      textSelectionTheme: TextSelectionThemeData(
        selectionHandleColor: colorScheme.secondary,
        selectionColor: AppColors.primary.withValueOpacity(0.5),
        cursorColor: colorScheme.shadow,
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.r),
        ),
      ),
      tabBarTheme: TabBarThemeData(
        indicator: BoxDecoration(
          color: colorScheme.onSecondary,
          borderRadius: BorderRadius.circular(8.r),
        ),
        labelStyle: textTheme.bodySmall?.copyWith(
          color: colorScheme.secondary,
        ),
        unselectedLabelStyle: textTheme.bodySmall,
      ),
    );
  }
}
