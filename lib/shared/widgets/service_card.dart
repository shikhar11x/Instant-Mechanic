import 'package:flutter/material.dart';
import 'package:instant_mechanic/core/constants/app_colors.dart';
import 'package:instant_mechanic/core/constants/app_spacing.dart';
import 'package:instant_mechanic/core/theme/app_text_styles.dart';
import 'package:instant_mechanic/models/service_model.dart';

class ServiceCard extends StatelessWidget {
  final ServiceModel service;
  final VoidCallback? onTap;
  final bool isSelected;
  final bool isCompact;

  const ServiceCard({
    super.key,
    required this.service,
    this.onTap,
    this.isSelected = false,
    this.isCompact = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: isCompact ? _buildCompactCard() : _buildExpandedCard(),
    );
  }

  Widget _buildCompactCard() {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.bgLightOrange : AppColors.bgWhite,
        borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
        border: Border.all(
          color: isSelected ? AppColors.primaryOrange : AppColors.borderColor,
          width: isSelected ? 2 : 1,
        ),
      ),
      padding: const EdgeInsets.all(AppSpacing.sm12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.bgLightOrange,
              borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
            ),
            child: Center(
              child: Icon(
                service.icon,
                size: 28,
                color: AppColors.primaryOrange,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xs8),
          Text(
            service.name,
            style: AppTextStyles.captionMedium,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildExpandedCard() {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? AppColors.bgLightOrange : AppColors.bgWhite,
        borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
        border: Border.all(
          color: isSelected ? AppColors.primaryOrange : AppColors.borderColor,
          width: isSelected ? 2 : 1,
        ),
      ),
      padding: const EdgeInsets.all(AppSpacing.md16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.bgLightOrange,
              borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
            ),
            child: Center(
              child: Icon(
                service.icon,
                size: 24,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm12),
          Text(
            service.name,
            style: AppTextStyles.headingSmall,
          ),
          const SizedBox(height: AppSpacing.xs4),
          Text(
            service.description,
            style: AppTextStyles.captionMedium,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSpacing.sm12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '₹${service.estimatedCost.toStringAsFixed(0)}',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.primaryOrange,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '~${service.estimatedTimeInMinutes}m',
                style: AppTextStyles.captionMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}