import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppStyles {
  static const TextStyle displayLarge = TextStyle(
      fontSize: 25, fontWeight: FontWeight.bold, color: AppColors.primaryColor);
  static const TextStyle displayMedium = TextStyle(
      fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.greyColor);
  static const TextStyle displaySmall = TextStyle(
      fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.primaryColor);
  static const TextStyle headlineLarge = TextStyle(
      fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.primaryColor);
  static const TextStyle headlineMedium = TextStyle(
      fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primaryColor);
  static const TextStyle titleMedium = TextStyle(
      fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.primaryColor);
  static const TextStyle labelLarge = TextStyle(
      fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primaryColor);
  static const TextStyle bodyMedium = TextStyle(
      fontSize: 11, fontWeight: FontWeight.w400, color: AppColors.greyColor);
  static const TextStyle onboardingTitle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle onboardingDescription = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.greyTextColor,
  );
}
