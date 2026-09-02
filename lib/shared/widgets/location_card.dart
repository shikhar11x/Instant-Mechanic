import 'package:flutter/material.dart';
import 'package:instant_mechanic/core/constants/app_colors.dart';
import 'package:instant_mechanic/core/constants/app_spacing.dart';
import 'package:instant_mechanic/core/theme/app_text_styles.dart';

class LocationCard extends StatelessWidget {
  final String location;
  final String? subtitle;
  final VoidCallback? onTap;
  final bool showDropdown;

  const LocationCard({
    super.key,
    required this.location,
    this.subtitle,
    this.onTap,
    this.showDropdown = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.horizontalPadding,
          vertical: AppSpacing.sm12,
        ),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md16),
          decoration: BoxDecoration(
            color: AppColors.bgWhite,
            borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
            border: Border.all(
              color: AppColors.borderColor,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                color: AppColors.primaryOrange,
                size: AppSpacing.iconMedium,
              ),
              const SizedBox(width: AppSpacing.sm16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Delivering to',
                      style: AppTextStyles.captionMedium,
                    ),
                    const SizedBox(height: AppSpacing.xs4),
                    Text(
                      location,
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: AppSpacing.xs4),
                      Text(
                        subtitle!,
                        style: AppTextStyles.captionSmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              if (showDropdown)
                const Icon(
                  Icons.expand_more,
                  color: AppColors.textSecondary,
                  size: AppSpacing.iconMedium,
                ),
            ],
          ),
        ),
      ),
    );
  }
}