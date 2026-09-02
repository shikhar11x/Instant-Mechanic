import 'package:flutter/material.dart';
import 'package:instant_mechanic/core/constants/app_colors.dart';
import 'package:instant_mechanic/core/constants/app_spacing.dart';
import 'package:instant_mechanic/core/theme/app_text_styles.dart';

class StepIndicator extends StatelessWidget {
  final int currentStep;
  final List<String> steps;
  final EdgeInsets? padding;

  const StepIndicator({
    super.key,
    required this.currentStep,
    required this.steps,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ??
          const EdgeInsets.symmetric(
            horizontal: AppSpacing.horizontalPadding,
            vertical: AppSpacing.md20,
          ),
      child: Row(
        children: List.generate(
          steps.length,
          (index) => Expanded(
            child: Row(
              children: [
                // Step circle
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: index < currentStep
                        ? AppColors.successGreen
                        : index == currentStep - 1
                            ? AppColors.primaryOrange
                            : AppColors.bgLightOrange,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: index < currentStep
                          ? AppColors.successGreen
                          : index == currentStep - 1
                              ? AppColors.primaryOrange
                              : AppColors.borderColor,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: index < currentStep
                        ? const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 20,
                          )
                        : Text(
                            '${index + 1}',
                            style: AppTextStyles.labelMedium.copyWith(
                              color: index == currentStep - 1
                                  ? Colors.white
                                  : AppColors.textSecondary,
                            ),
                          ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm12),
                // Step label
                Expanded(
                  child: Text(
                    steps[index],
                    style: AppTextStyles.captionMedium.copyWith(
                      color: index <= currentStep - 1
                          ? AppColors.textDark
                          : AppColors.textSecondary,
                      fontWeight: index == currentStep - 1
                          ? FontWeight.w700
                          : FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // Connector line
                if (index < steps.length - 1)
                  Padding(
                    padding: const EdgeInsets.only(left: AppSpacing.sm12),
                    child: Container(
                      height: 2,
                      color: index < currentStep - 1
                          ? AppColors.successGreen
                          : AppColors.borderColor,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}