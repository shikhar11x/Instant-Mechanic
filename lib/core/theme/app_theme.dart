import 'package:flutter/material.dart';
import 'package:instant_mechanic/core/constants/app_colors.dart';
import 'package:instant_mechanic/core/constants/app_spacing.dart';
import 'package:instant_mechanic/core/theme/app_text_styles.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      
      // Primary Color
      primaryColor: AppColors.primaryOrange,
      
      // Color Scheme
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryOrange,
        secondary: AppColors.primaryOrange,
        surface: AppColors.bgWhite,
        error: AppColors.errorRed,
        tertiary: AppColors.warningYellow,
      ),

      // Scaffold Background
      scaffoldBackgroundColor: AppColors.bgWarmWhite,

      // AppBar Theme
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.bgWarmWhite,
        surfaceTintColor: AppColors.bgWarmWhite,
        centerTitle: false,
        titleTextStyle: AppTextStyles.headingLarge,
        iconTheme: const IconThemeData(
          color: AppColors.textDark,
          size: AppSpacing.iconMedium,
        ),
      ),

      // Text Theme
      textTheme: TextTheme(
        displayLarge: AppTextStyles.displayLarge,
        displayMedium: AppTextStyles.displayMedium,
        displaySmall: AppTextStyles.displaySmall,
        headlineLarge: AppTextStyles.headingXL,
        headlineMedium: AppTextStyles.headingLarge,
        headlineSmall: AppTextStyles.headingMedium,
        titleLarge: AppTextStyles.headingSmall,
        titleMedium: AppTextStyles.bodyLarge,
        titleSmall: AppTextStyles.bodyMedium,
        bodyLarge: AppTextStyles.bodyLarge,
        bodyMedium: AppTextStyles.bodyMedium,
        bodySmall: AppTextStyles.bodySmall,
        labelLarge: AppTextStyles.labelLarge,
        labelMedium: AppTextStyles.labelMedium,
        labelSmall: AppTextStyles.labelSmall,
      ),

      // Card Theme
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
          side: const BorderSide(
            color: AppColors.borderColor,
            width: 1,
          ),
        ),
        color: AppColors.bgWhite,
        margin: EdgeInsets.zero,
      ),

      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryOrange,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md24,
            vertical: AppSpacing.sm12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusButton),
          ),
          textStyle: AppTextStyles.buttonLarge,
          minimumSize: const Size(double.infinity, AppSpacing.buttonHeight),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryOrange,
          side: const BorderSide(color: AppColors.borderColor),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md24,
            vertical: AppSpacing.sm12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusButton),
          ),
          textStyle: AppTextStyles.buttonLarge,
          minimumSize: const Size(double.infinity, AppSpacing.buttonHeight),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryOrange,
          textStyle: AppTextStyles.buttonMedium,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm16,
            vertical: AppSpacing.sm12,
          ),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.bgWhite,
        hintStyle: AppTextStyles.inputHint,
        labelStyle: AppTextStyles.inputText,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm16,
          vertical: AppSpacing.sm14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
          borderSide: const BorderSide(
            color: AppColors.borderColor,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
          borderSide: const BorderSide(
            color: AppColors.borderColor,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
          borderSide: const BorderSide(
            color: AppColors.primaryOrange,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
          borderSide: const BorderSide(
            color: AppColors.errorRed,
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
          borderSide: const BorderSide(
            color: AppColors.errorRed,
            width: 2,
          ),
        ),
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: AppColors.dividerColor,
        thickness: 1,
      ),

      // Bottom Sheet Theme
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.bgWhite,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppSpacing.radiusLarge),
          ),
        ),
      ),

      // Icon Theme
      iconTheme: const IconThemeData(
        color: AppColors.textDark,
        size: AppSpacing.iconMedium,
      ),
    );
  }
}