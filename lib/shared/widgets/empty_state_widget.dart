import 'package:flutter/material.dart';
import 'package:instant_mechanic/core/constants/app_colors.dart';
import 'package:instant_mechanic/core/constants/app_spacing.dart';
import 'package:instant_mechanic/core/theme/app_text_styles.dart';
import 'package:instant_mechanic/shared/widgets/custom_button.dart';

class EmptyStateWidget extends StatelessWidget {
  final String title;
  final String description;
  final String? subtitle;
  final String? buttonText;
  final VoidCallback? onButtonPressed;
  final IconData? icon;
  final String? emoji;
  final Color? iconColor;

  const EmptyStateWidget({
    super.key,
    required this.title,
    required this.description,
    this.subtitle,
    this.buttonText,
    this.onButtonPressed,
    this.icon,
    this.emoji,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon/Emoji
            if (emoji != null)
              Text(
                emoji!,
                style: const TextStyle(fontSize: 80),
              )
            else if (icon != null)
              Icon(
                icon,
                size: 80,
                color: iconColor ?? AppColors.primaryOrange,
              ),
            const SizedBox(height: AppSpacing.lg32),

            // Title
            Text(
              title,
              style: AppTextStyles.displaySmall.copyWith(
                color: AppColors.textDark,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm12),

            // Description
            Text(
              description,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),

            // Subtitle (optional)
            if (subtitle != null) ...[
              const SizedBox(height: AppSpacing.xs8),
              Text(
                subtitle!,
                style: AppTextStyles.captionMedium.copyWith(
                  color: AppColors.textLight,
                ),
                textAlign: TextAlign.center,
              ),
            ],

            // Button (optional)
            if (buttonText != null && onButtonPressed != null) ...[
              const SizedBox(height: AppSpacing.lg32),
              SizedBox(
                width: 200,
                child: CustomButton(
                  text: buttonText!,
                  onPressed: onButtonPressed!,
                  isFullWidth: false,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}