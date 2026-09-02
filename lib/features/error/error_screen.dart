import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:instant_mechanic/core/constants/app_colors.dart';
import 'package:instant_mechanic/core/constants/app_spacing.dart';
import 'package:instant_mechanic/core/constants/app_strings.dart';
import 'package:instant_mechanic/core/theme/app_text_styles.dart';
import 'package:instant_mechanic/shared/widgets/custom_button.dart';

class ErrorScreen extends StatelessWidget {
  final String? title;
  final String? description;
  final VoidCallback? onRetry;
  final bool showBackButton;

  const ErrorScreen({
    super.key,
    this.title = AppStrings.error,
    this.description = AppStrings.errorDesc,
    this.onRetry,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgWarmWhite,
      appBar: showBackButton
          ? AppBar(
              backgroundColor: AppColors.bgWarmWhite,
              elevation: 0,
              surfaceTintColor: AppColors.bgWarmWhite,
              leading: GestureDetector(
                onTap: () => context.pop(),
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.textDark,
                ),
              ),
            )
          : null,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Error Icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.errorRed.withValues(alpha: 0.1),
                ),
                child: Center(
                  child: Icon(
                    Icons.error_outline,
                    color: AppColors.errorRed,
                    size: 60,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg32),

              // Title
              Text(
                title ?? AppStrings.error,
                style: AppTextStyles.displaySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.md16),

              // Description
              Text(
                description ?? AppStrings.errorDesc,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xl56),

              // Retry Button
              SizedBox(
                width: 200,
                child: CustomButton(
                  text: AppStrings.retry,
                  onPressed: onRetry ?? () => context.go('/'),
                  isFullWidth: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}