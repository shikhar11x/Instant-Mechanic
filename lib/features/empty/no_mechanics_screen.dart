import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:instant_mechanic/core/constants/app_colors.dart';
import 'package:instant_mechanic/core/constants/app_spacing.dart';
import 'package:instant_mechanic/core/constants/app_strings.dart';
import 'package:instant_mechanic/core/theme/app_text_styles.dart';
import 'package:instant_mechanic/shared/widgets/custom_button.dart';

class NoMechanicsScreen extends StatelessWidget {
  const NoMechanicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgWarmWhite,
      appBar: AppBar(
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
        title: Text(
          AppStrings.noMechanicsFound,
          style: AppTextStyles.headingLarge,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Illustration/Emoji
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.bgLightOrange,
                ),
                child: const Center(
                  child: Text(
                    '📍🔍',
                    style: TextStyle(fontSize: 60),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg32),

              // Title
              Text(
                AppStrings.noMechanicsFound,
                style: AppTextStyles.displaySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.md16),

              // Description
              Text(
                AppStrings.noMechanicsDesc,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xs8),

              // Sub Description
              Text(
                AppStrings.noMechanicsSubDesc,
                style: AppTextStyles.captionMedium.copyWith(
                  color: AppColors.textLight,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xl56),

              // Try Again Button
              SizedBox(
                width: 200,
                child: CustomButton(
                  text: AppStrings.tryAgain,
                  onPressed: () {
                    context.go('/');
                  },
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