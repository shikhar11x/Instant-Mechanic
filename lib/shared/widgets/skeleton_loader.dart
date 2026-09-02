import 'package:flutter/material.dart';
import 'package:instant_mechanic/core/constants/app_colors.dart';
import 'package:instant_mechanic/core/constants/app_spacing.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonLoader extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius? borderRadius;
  final EdgeInsets? margin;

  const SkeletonLoader({
    super.key,
    this.width = double.infinity,
    this.height = 100,
    this.borderRadius,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.placeholder.withValues(alpha: 0.3),
      highlightColor: AppColors.bgWhite,
      child: Container(
        margin: margin,
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.placeholder.withValues(alpha: 0.2),
          borderRadius: borderRadius ??
              BorderRadius.circular(AppSpacing.radiusCard),
        ),
      ),
    );
  }
}

class MechanicCardSkeleton extends StatelessWidget {
  const MechanicCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.horizontalPadding,
        vertical: AppSpacing.sm12,
      ),
      decoration: BoxDecoration(
        color: AppColors.bgWhite,
        borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
        border: Border.all(
          color: AppColors.borderColor,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image skeleton
          SkeletonLoader(
            width: double.infinity,
            height: 160,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(AppSpacing.radiusCard),
            ),
          ),
          // Content skeleton
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SkeletonLoader(
                      width: 150,
                      height: 20,
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusSmall),
                    ),
                    SkeletonLoader(
                      width: 60,
                      height: 20,
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusSmall),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm12),
                SkeletonLoader(
                  width: double.infinity,
                  height: 16,
                  borderRadius:
                      BorderRadius.circular(AppSpacing.radiusSmall),
                ),
                const SizedBox(height: AppSpacing.sm12),
                SkeletonLoader(
                  width: double.infinity,
                  height: 16,
                  borderRadius:
                      BorderRadius.circular(AppSpacing.radiusSmall),
                ),
                const SizedBox(height: AppSpacing.md16),
                Row(
                  children: [
                    SkeletonLoader(
                      width: 80,
                      height: 24,
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusSmall),
                    ),
                    const SizedBox(width: AppSpacing.xs8),
                    SkeletonLoader(
                      width: 80,
                      height: 24,
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusSmall),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomeScreenSkeleton extends StatelessWidget {
  const HomeScreenSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Hero section skeleton
          Padding(
            padding: const EdgeInsets.all(AppSpacing.horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonLoader(
                  width: 200,
                  height: 24,
                  borderRadius:
                      BorderRadius.circular(AppSpacing.radiusSmall),
                ),
                const SizedBox(height: AppSpacing.md16),
                SkeletonLoader(
                  width: double.infinity,
                  height: 120,
                  borderRadius:
                      BorderRadius.circular(AppSpacing.radiusCard),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md24),

          // Location card skeleton
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.horizontalPadding,
            ),
            child: SkeletonLoader(
              width: double.infinity,
              height: 80,
              borderRadius:
                  BorderRadius.circular(AppSpacing.radiusCard),
            ),
          ),
          const SizedBox(height: AppSpacing.md20),

          // Search bar skeleton
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.horizontalPadding,
            ),
            child: SkeletonLoader(
              width: double.infinity,
              height: 48,
              borderRadius:
                  BorderRadius.circular(AppSpacing.radiusMedium),
            ),
          ),
          const SizedBox(height: AppSpacing.md24),

          // Services skeleton
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.horizontalPadding,
            ),
            child: SkeletonLoader(
              width: double.infinity,
              height: 24,
              borderRadius:
                  BorderRadius.circular(AppSpacing.radiusSmall),
            ),
          ),
          const SizedBox(height: AppSpacing.md16),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(
                  left: index == 0 ? AppSpacing.horizontalPadding : 0,
                  right: AppSpacing.sm12,
                ),
                child: SkeletonLoader(
                  width: 100,
                  height: 120,
                  borderRadius:
                      BorderRadius.circular(AppSpacing.radiusCard),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md24),

          // Mechanics skeleton
          ...List.generate(
            3,
            (index) => const MechanicCardSkeleton(),
          ),
        ],
      ),
    );
  }
}