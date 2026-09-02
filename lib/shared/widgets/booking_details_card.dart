import 'package:flutter/material.dart';
import 'package:instant_mechanic/core/constants/app_colors.dart';
import 'package:instant_mechanic/core/constants/app_spacing.dart';
import 'package:instant_mechanic/core/theme/app_text_styles.dart';

class BookingDetailsCard extends StatelessWidget {
  final String title;
  final List<BookingDetailRow> details;
  final EdgeInsets? padding;

  const BookingDetailsCard({
    super.key,
    required this.title,
    required this.details,
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
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.bgWhite,
          borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
          border: Border.all(
            color: AppColors.borderColor,
            width: 1,
          ),
        ),
        padding: const EdgeInsets.all(AppSpacing.md16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTextStyles.headingSmall,
            ),
            const SizedBox(height: AppSpacing.md16),
            ...List.generate(
              details.length,
              (index) => Column(
                children: [
                  _buildDetailRow(details[index]),
                  if (index < details.length - 1)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.sm12,
                      ),
                      child: Divider(
                        color: AppColors.dividerColor,
                        height: 1,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(BookingDetailRow detail) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            detail.label,
            style: AppTextStyles.captionMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          Expanded(
            child: Text(
              detail.value,
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.end,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class BookingDetailRow {
  final String label;
  final String value;

  BookingDetailRow({
    required this.label,
    required this.value,
  });
}