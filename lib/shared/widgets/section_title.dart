import 'package:flutter/material.dart';
import 'package:instant_mechanic/core/constants/app_colors.dart';
import 'package:instant_mechanic/core/constants/app_spacing.dart';
import 'package:instant_mechanic/core/theme/app_text_styles.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String? actionText;
  final VoidCallback? onActionPressed;
  final EdgeInsets? padding;

  const SectionTitle({
    super.key,
    required this.title,
    this.actionText,
    this.onActionPressed,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ??
          const EdgeInsets.symmetric(
            horizontal: AppSpacing.horizontalPadding,
            vertical: AppSpacing.sm12,
          ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyles.headingLarge,
          ),
          if (actionText != null && onActionPressed != null)
            GestureDetector(
              onTap: onActionPressed,
              child: Text(
                actionText!,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.primaryOrange,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }
}