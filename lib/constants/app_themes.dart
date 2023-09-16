import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:flutter/material.dart';

class AppThemes {
  ThemeData lightTheme = ThemeData(
    fontFamily: 'Poppins',
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.whiteColor,
    colorScheme: const ColorScheme.light(
      primaryContainer: AppColors.primaryColor,
      onPrimaryContainer: AppColors.lightTextColor,
      secondaryContainer: AppColors.whiteColor,
      onSecondaryContainer: AppColors.darkTextColor,
      tertiaryContainer: AppColors.primaryColor,
      onTertiaryContainer: AppColors.lightTextColor,
      primary: AppColors.primaryColor,
      secondary: AppColors.primaryColor,
      surface: AppColors.primaryColor,
      background: AppColors.whiteColor,
      error: AppColors.primaryColor,
      onPrimary: AppColors.primaryColor,
      onSecondary: AppColors.primaryColor,
      onSurface: AppColors.primaryColor,
      onBackground: AppColors.primaryColor,
      onError: AppColors.primaryColor,
      brightness: Brightness.light,
    ),
    textTheme: TextTheme(
      headlineLarge:
          AppStyles.headlineLarge.copyWith(color: AppColors.darkTextColor),
      headlineMedium:
          AppStyles.headlineMedium.copyWith(color: AppColors.darkTextColor),
      labelLarge: AppStyles.labelLarge.copyWith(color: AppColors.darkTextColor),
      labelMedium:
          AppStyles.labelMedium.copyWith(color: AppColors.darkTextColor),
      bodyLarge: AppStyles.bodyLarge.copyWith(color: AppColors.darkTextColor),
      bodyMedium: AppStyles.bodyMedium.copyWith(color: AppColors.darkTextColor),
      displayLarge: AppStyles.displayLarge,
      displayMedium: AppStyles.displayMedium,
      displaySmall:
          AppStyles.displaySmall.copyWith(color: AppColors.darkTextColor),
      titleMedium:
          AppStyles.titleMedium.copyWith(color: AppColors.darkTextColor),
      titleSmall: AppStyles.titleSmall.copyWith(color: AppColors.darkTextColor),
    ),
  );

  ThemeData darkTheme = ThemeData(
    fontFamily: 'Poppins',
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.primaryColor,
    textTheme: TextTheme(
      headlineLarge:
          AppStyles.headlineLarge.copyWith(color: AppColors.lightTextColor),
      headlineMedium:
          AppStyles.headlineMedium.copyWith(color: AppColors.lightTextColor),
      labelLarge:
          AppStyles.labelLarge.copyWith(color: AppColors.lightTextColor),
      labelMedium:
          AppStyles.labelMedium.copyWith(color: AppColors.lightTextColor),
      bodyLarge: AppStyles.bodyLarge,
      bodyMedium: AppStyles.bodyMedium,
      displayLarge:
          AppStyles.displayLarge.copyWith(color: AppColors.lightTextColor),
      displayMedium:
          AppStyles.displayMedium.copyWith(color: AppColors.lightTextColor),
      displaySmall:
          AppStyles.displaySmall.copyWith(color: AppColors.lightTextColor),
      titleMedium:
          AppStyles.titleMedium.copyWith(color: AppColors.lightTextColor),
      titleSmall:
          AppStyles.titleSmall.copyWith(color: AppColors.lightTextColor),
    ),
    colorScheme: const ColorScheme.light(
      primaryContainer: AppColors.whiteColor,
      onPrimaryContainer: AppColors.darkTextColor,
      secondaryContainer: AppColors.primaryColor,
      onSecondaryContainer: AppColors.lightTextColor,
      tertiaryContainer: AppColors.greyTextColor,
      onTertiaryContainer: AppColors.lightTextColor,
      primary: AppColors.primaryColor,
      secondary: AppColors.primaryColor,
      surface: AppColors.primaryColor,
      background: AppColors.primaryColor,
      error: AppColors.primaryColor,
      onPrimary: AppColors.primaryColor,
      onSecondary: AppColors.primaryColor,
      onSurface: AppColors.primaryColor,
      onBackground: AppColors.primaryColor,
      onError: AppColors.primaryColor,
      brightness: Brightness.dark,
    ),
  );
}