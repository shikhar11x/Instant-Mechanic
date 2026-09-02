import 'package:flutter/material.dart';
import 'package:instant_mechanic/core/constants/app_colors.dart';
import 'package:instant_mechanic/core/constants/app_spacing.dart';
import 'package:instant_mechanic/core/theme/app_text_styles.dart';
import 'package:instant_mechanic/shared/enums/badge_status.dart';

class StatusBadge extends StatelessWidget {
  final String text;
  final BadgeStatus status;
  final EdgeInsets? padding;

  const StatusBadge({
    super.key,
    required this.text,
    required this.status,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final colors = _getStatusColors(status);

    return Container(
      padding: padding ??
          const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm12,
            vertical: AppSpacing.xs4,
          ),
      decoration: BoxDecoration(
        color: colors['bg'],
        borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
      ),
      child: Text(
        text,
        style: AppTextStyles.badge.copyWith(
          color: colors['text'],
          fontSize: 11,
        ),
      ),
    );
  }

  Map<String, Color> _getStatusColors(BadgeStatus status) {
    switch (status) {
      case BadgeStatus.open:
        return {
          'bg': AppColors.successGreen.withValues(alpha: 0.15),
          'text': AppColors.successGreen,
        };
      case BadgeStatus.closed:
        return {
          'bg': AppColors.errorRed.withValues(alpha: 0.15),
          'text': AppColors.errorRed,
        };
      case BadgeStatus.pending:
        return {
          'bg': AppColors.warningYellow.withValues(alpha: 0.15),
          'text': AppColors.warningYellow,
        };
      case BadgeStatus.confirmed:
        return {
          'bg': AppColors.successGreen.withValues(alpha: 0.15),
          'text': AppColors.successGreen,
        };
    }
  }
}