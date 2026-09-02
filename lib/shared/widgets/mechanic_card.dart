import 'package:flutter/material.dart';
import 'package:instant_mechanic/core/constants/app_colors.dart';
import 'package:instant_mechanic/core/constants/app_spacing.dart';
import 'package:instant_mechanic/core/theme/app_text_styles.dart';
import 'package:instant_mechanic/models/mechanic_model.dart';
import 'package:instant_mechanic/shared/enums/badge_status.dart';
import 'package:instant_mechanic/shared/widgets/status_badge.dart';

class MechanicCard extends StatelessWidget {
  final MechanicModel mechanic;
  final VoidCallback? onTap;
  final VoidCallback? onArrowTap;

  const MechanicCard({
    super.key,
    required this.mechanic,
    this.onTap,
    this.onArrowTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: AppSpacing.horizontalPadding,
          vertical: AppSpacing.sm12,
        ),
        decoration: BoxDecoration(
          color: AppColors.bgWhite,
          borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
          border: Border.all(color: AppColors.borderColor, width: 1),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Garage Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppSpacing.radiusCard),
              ),
              child: Image.network(
                mechanic.imageUrl,
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 160,
                    color: AppColors.bgLightOrange,
                    child: const Center(
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        color: AppColors.primaryOrange,
                      ),
                    ),
                  );
                },
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with name and status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          mechanic.garageName,
                          style: AppTextStyles.headingSmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      StatusBadge(
                        text: mechanic.isOpen ? 'OPEN' : 'CLOSED',
                        status: mechanic.isOpen
                            ? BadgeStatus.open
                            : BadgeStatus.closed,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs8),

                  // Rating and Reviews
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: AppColors.starYellow,
                        size: 18,
                      ),
                      const SizedBox(width: AppSpacing.xs4),
                      Text(
                        '${mechanic.rating}',
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.xs4),
                      Text(
                        '(${mechanic.reviewCount})',
                        style: AppTextStyles.captionMedium,
                      ),
                      const Spacer(),
                      Icon(
                        Icons.location_on_outlined,
                        color: AppColors.textSecondary,
                        size: 16,
                      ),
                      const SizedBox(width: AppSpacing.xs4),
                      Text(
                        '${mechanic.distanceKm} km',
                        style: AppTextStyles.captionMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm12),

                  // Location
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: AppColors.textSecondary,
                        size: 16,
                      ),
                      const SizedBox(width: AppSpacing.xs4),
                      Expanded(
                        child: Text(
                          mechanic.location,
                          style: AppTextStyles.captionMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm12),

                  // Services
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...mechanic.services.take(2).map((service) {
                          return Padding(
                            padding: const EdgeInsets.only(
                              right: AppSpacing.xs8,
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.sm12,
                                vertical: AppSpacing.xs4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.bgLightOrange,
                                borderRadius: BorderRadius.circular(
                                  AppSpacing.radiusSmall,
                                ),
                              ),
                              child: Text(
                                service.name,
                                style: AppTextStyles.captionMedium.copyWith(
                                  color: AppColors.primaryOrange,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          );
                        }),
                        if (mechanic.services.length > 2)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.sm12,
                              vertical: AppSpacing.xs4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.bgLightOrange,
                              borderRadius: BorderRadius.circular(
                                AppSpacing.radiusSmall,
                              ),
                            ),
                            child: Text(
                              '+${mechanic.services.length - 2}',
                              style: AppTextStyles.captionMedium.copyWith(
                                color: AppColors.primaryOrange,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm12),

                  // Bottom action
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 40),
                      GestureDetector(
                        onTap: onArrowTap ?? onTap,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.bgLightOrange,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.primaryOrange,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
