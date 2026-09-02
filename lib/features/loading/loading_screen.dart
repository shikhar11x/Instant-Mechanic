import 'package:flutter/material.dart';
import 'package:instant_mechanic/core/constants/app_colors.dart';
import 'package:instant_mechanic/core/constants/app_spacing.dart';
import 'package:instant_mechanic/shared/widgets/skeleton_loader.dart';

class LoadingScreen extends StatelessWidget {
  final String? message;

  const LoadingScreen({
    super.key,
    this.message = 'Finding mechanics near you...',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgWarmWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // AppBar Skeleton
              Padding(
                padding: const EdgeInsets.all(AppSpacing.horizontalPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SkeletonLoader(
                      width: 150,
                      height: 24,
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusSmall),
                    ),
                    SkeletonLoader(
                      width: 40,
                      height: 40,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md20),

              // Hero Section Skeleton
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.horizontalPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SkeletonLoader(
                      width: 100,
                      height: 16,
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusSmall),
                    ),
                    const SizedBox(height: AppSpacing.md16),
                    SkeletonLoader(
                      width: double.infinity,
                      height: 100,
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusCard),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md24),

              // Location Card Skeleton
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

              // Search Bar Skeleton
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

              // Section Title Skeleton
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.horizontalPadding,
                ),
                child: SkeletonLoader(
                  width: 150,
                  height: 24,
                  borderRadius:
                      BorderRadius.circular(AppSpacing.radiusSmall),
                ),
              ),
              const SizedBox(height: AppSpacing.md16),

              // Services Skeleton
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.horizontalPadding,
                  ),
                  itemCount: 5,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(
                      right: index == 4 ? 0 : AppSpacing.sm12,
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

              // Mechanics List Skeleton
              ...List.generate(
                3,
                (index) => const Padding(
                  padding: EdgeInsets.only(bottom: AppSpacing.md12),
                  child: MechanicCardSkeleton(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}