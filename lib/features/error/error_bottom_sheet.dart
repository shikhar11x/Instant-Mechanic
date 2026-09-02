import 'package:flutter/material.dart';
import 'package:instant_mechanic/core/constants/app_colors.dart';
import 'package:instant_mechanic/core/constants/app_spacing.dart';
import 'package:instant_mechanic/core/theme/app_text_styles.dart';
import 'package:instant_mechanic/shared/widgets/custom_button.dart';

class ErrorBottomSheet extends StatelessWidget {
  final String title;
  final String message;
  final String? actionText;
  final VoidCallback? onAction;
  final VoidCallback? onDismiss;

  const ErrorBottomSheet({
    super.key,
    required this.title,
    required this.message,
    this.actionText = 'Try Again',
    this.onAction,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bgWhite,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppSpacing.radiusLarge),
        ),
      ),
      padding: EdgeInsets.only(
        left: AppSpacing.md16,
        right: AppSpacing.md16,
        top: AppSpacing.md16,
        bottom: AppSpacing.md16 +
            MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Close Button
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: onDismiss ?? () => Navigator.pop(context),
              child: Icon(
                Icons.close_rounded,
                color: AppColors.textSecondary,
                size: AppSpacing.iconMedium,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md12),

          // Error Icon
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.errorRed.withValues(alpha: 0.1),
            ),
            child: Center(
              child: Icon(
                Icons.error_outline,
                color: AppColors.errorRed,
                size: 28,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md16),

          // Title
          Text(
            title,
            style: AppTextStyles.headingSmall,
          ),
          const SizedBox(height: AppSpacing.xs8),

          // Message
          Text(
            message,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.md24),

          // Action Button
          if (actionText != null && onAction != null)
            CustomButton(
              text: actionText!,
              onPressed: () {
                Navigator.pop(context);
                onAction!();
              },
            ),
        ],
      ),
    );
  }

  static void show(
    BuildContext context, {
    required String title,
    required String message,
    String? actionText,
    VoidCallback? onAction,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ErrorBottomSheet(
        title: title,
        message: message,
        actionText: actionText,
        onAction: onAction,
      ),
    );
  }
}