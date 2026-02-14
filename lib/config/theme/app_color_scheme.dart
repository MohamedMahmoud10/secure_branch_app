import 'package:flutter/material.dart';
import 'package:secure_branch_app/config/theme/app_colors.dart';
import 'package:secure_branch_app/config/theme/app_theme.dart';

extension AppColorScheme on AppTheme {
  ColorScheme get colorScheme {
    switch (this) {
      case AppTheme.light:
        return _lightColorScheme;
      case AppTheme.dark:
        return _darkColorScheme;
    }
  }

  ColorScheme get _lightColorScheme => const ColorScheme(
    brightness: Brightness.light,

    primary: AppColors.primary,
    onPrimary: AppColors.primary,
    secondary: AppColors.primary,
    onSecondary: AppColors.primary,
    error: AppColors.primary,
    onError: AppColors.primary,
    surface: AppColors.primary,
    onSurface: AppColors.primary,
    ///////////////////////////////////////

    /////////////////////////////////////////////////////////////////////
  );

  ColorScheme get _darkColorScheme => const ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.primary,
    onPrimary: AppColors.primary,
    secondary: AppColors.primary,
    onSecondary: AppColors.primary,
    error: AppColors.primary,
    onError: AppColors.primary,
    surface: AppColors.primary,
    onSurface: AppColors.primary,

    ///////////////////////////////////////
  );
}
