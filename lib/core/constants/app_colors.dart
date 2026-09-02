import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primaryOrange = Color(0xFFFF6B00);
  static const Color primaryOrangeDark = Color(0xFFE55A00);

  // Background Colors
  static const Color bgWarmWhite = Color(0xFFFFFDF9);
  static const Color bgWhite = Color(0xFFFFFFFF);
  static const Color bgLightOrange = Color(0xFFFFF3E8);

  // Text Colors
  static const Color textDark = Color(0xFF1F1F1F);
  static const Color textSecondary = Color(0xFF6B6B6B);
  static const Color textLight = Color(0xFF9B9B9B);

  // Border & Divider
  static const Color borderColor = Color(0xFFEAE5DF);
  static const Color dividerColor = Color(0xFFF0F0F0);

  // Status Colors
  static const Color successGreen = Color(0xFF2EAD62);
  static const Color warningYellow = Color(0xFFFFA500);
  static const Color errorRed = Color(0xFFE5484D);

  // Neutral Colors
  static const Color shadow = Color(0x0D000000);
  static const Color disabled = Color(0xFFCCCCCC);
  static const Color placeholder = Color(0xFFD9D9D9);

  // Rating & Stars
  static const Color starYellow = Color(0xFFFFB800);

  // Gradients (Optional)
  static const LinearGradient orangeGradient = LinearGradient(
    colors: [primaryOrange, primaryOrangeDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}