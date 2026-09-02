import 'package:flutter/material.dart';
import 'package:instant_mechanic/core/constants/app_colors.dart';

class AppTextStyles {
  // Display / Hero Heading
  static const TextStyle displayLarge = TextStyle(
    fontSize: 48.0,
    fontWeight: FontWeight.w800,
    color: AppColors.textDark,
    height: 1.2,
    letterSpacing: -0.5,
  );

  static const TextStyle displayMedium = TextStyle(
    fontSize: 36.0,
    fontWeight: FontWeight.w700,
    color: AppColors.textDark,
    height: 1.3,
  );

  static const TextStyle displaySmall = TextStyle(
    fontSize: 28.0,
    fontWeight: FontWeight.w700,
    color: AppColors.textDark,
    height: 1.4,
  );

  // Heading Styles
  static const TextStyle headingXL = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.w700,
    color: AppColors.textDark,
    height: 1.3,
  );

  static const TextStyle headingLarge = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w700,
    color: AppColors.textDark,
    height: 1.4,
  );

  static const TextStyle headingMedium = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    color: AppColors.textDark,
    height: 1.4,
  );

  static const TextStyle headingSmall = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    color: AppColors.textDark,
    height: 1.5,
  );

  // Body Styles
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    color: AppColors.textDark,
    height: 1.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    color: AppColors.textDark,
    height: 1.5,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    height: 1.6,
  );

  // Caption Styles
  static const TextStyle captionLarge = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  static const TextStyle captionMedium = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  static const TextStyle captionSmall = TextStyle(
    fontSize: 10.0,
    fontWeight: FontWeight.w400,
    color: AppColors.textLight,
    height: 1.6,
  );

  // Label Styles
  static const TextStyle labelLarge = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w700,
    color: AppColors.textDark,
    height: 1.5,
    letterSpacing: 0.5,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w700,
    color: AppColors.textDark,
    height: 1.5,
    letterSpacing: 0.5,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 10.0,
    fontWeight: FontWeight.w700,
    color: AppColors.textDark,
    height: 1.6,
    letterSpacing: 0.5,
  );

  // Button Text
  static const TextStyle buttonLarge = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    height: 1.5,
    letterSpacing: 0.3,
  );

  static const TextStyle buttonMedium = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    height: 1.5,
    letterSpacing: 0.3,
  );

  // Badge Text
  static const TextStyle badge = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    height: 1.5,
    letterSpacing: 0.5,
  );

  // Input Field Text
  static const TextStyle inputText = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    color: AppColors.textDark,
    height: 1.5,
  );

  static const TextStyle inputHint = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    color: AppColors.placeholder,
    height: 1.5,
  );

  // Special
  static const TextStyle tagline = TextStyle(
    fontSize: 11.0,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryOrange,
    letterSpacing: 1.5,
  );

  static const TextStyle heroTagline = TextStyle(
    fontSize: 13.0,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryOrange,
    letterSpacing: 1.0,
  );
}