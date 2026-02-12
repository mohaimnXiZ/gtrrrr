import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      surface: AppColors.backgroundLight,
      onSurface: AppColors.textPrimaryLight,
      primary: AppColors.primaryLight,
      onPrimary: AppColors.backgroundLight,
      secondary: AppColors.secondaryLight,
      onSecondary: AppColors.backgroundLight,
      tertiary: AppColors.successLight,
      error: AppColors.errorLight,
      outline: AppColors.outlineLight,
      onPrimaryContainer: AppColors.cardLight
    ),
    dividerColor: AppColors.dividerLight,
    canvasColor: AppColors.backgroundLight,
    hintColor: AppColors.textSecondaryLight,
    primaryColor: AppColors.primaryLight,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    splashColor: AppColors.primaryLight.withAlpha(26),
    appBarTheme: const AppBarTheme(backgroundColor: AppColors.backgroundLight, foregroundColor: AppColors.textPrimaryLight, elevation: 0),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.backgroundLight,
      selectedItemColor: AppColors.primaryLight,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      surface: AppColors.backgroundDark,
      onSurface: AppColors.textPrimaryDark,
      primary: AppColors.primaryDark,
      onPrimary: AppColors.backgroundDark,
      secondary: AppColors.secondaryDark,
      onSecondary: AppColors.backgroundDark,
      tertiary: AppColors.successDark,
      error: AppColors.errorDark,
      outline: AppColors.outlineDark,
      onPrimaryContainer: AppColors.cardDark
    ),
    dividerColor: AppColors.dividerDark,
    canvasColor: AppColors.backgroundDark,
    hintColor: AppColors.textSecondaryDark,
    primaryColor: AppColors.primaryDark,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    splashColor: AppColors.primaryDark.withAlpha(26),
    appBarTheme: const AppBarTheme(backgroundColor: AppColors.backgroundDark, foregroundColor: AppColors.textPrimaryDark, elevation: 0),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.backgroundDark,
      selectedItemColor: AppColors.primaryDark,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
  );
}
