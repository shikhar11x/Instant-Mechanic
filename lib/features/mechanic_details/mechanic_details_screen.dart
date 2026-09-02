import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:instant_mechanic/core/constants/app_colors.dart';
import 'package:instant_mechanic/core/constants/app_spacing.dart';
import 'package:instant_mechanic/core/constants/app_strings.dart';
import 'package:instant_mechanic/core/theme/app_text_styles.dart';
import 'package:instant_mechanic/data/mock_data.dart';
import 'package:instant_mechanic/models/mechanic_model.dart';
import 'package:instant_mechanic/shared/widgets/custom_button.dart';
import 'package:instant_mechanic/shared/widgets/service_card.dart';
import 'package:instant_mechanic/shared/widgets/status_badge.dart';
import 'package:instant_mechanic/shared/enums/badge_status.dart';

class MechanicDetailsScreen extends StatefulWidget {
  final String mechanicId;

  const MechanicDetailsScreen({
    super.key,
    required this.mechanicId,
  });

  @override
  State<MechanicDetailsScreen> createState() => _MechanicDetailsScreenState();
}

class _MechanicDetailsScreenState extends State<MechanicDetailsScreen> {
  late MechanicModel mechanic;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMechanicData();
  }

  void _loadMechanicData() {
    Future.delayed(const Duration(milliseconds: 500), () {
      final data = MockData.getMechanicById(widget.mechanicId);
      if (data != null) {
        setState(() {
          mechanic = data;
          _isLoading = false;
        });
      } else {
        context.pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: AppColors.bgWarmWhite,
        body: Center(
          child: CircularProgressIndicator(
            color: AppColors.primaryOrange,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.bgWarmWhite,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero Image
                _buildHeroImage(),

                // Garage Info Card
                _buildGarageInfoCard(),

                // Location Section
                _buildLocationSection(),

                const SizedBox(height: AppSpacing.md24),

                // Services Section
                _buildServicesSection(),

                const SizedBox(height: AppSpacing.md24),

                // Working Hours Card
                _buildWorkingHoursCard(),

                const SizedBox(height: AppSpacing.md16),

                // Contact Card
                _buildContactCard(),

                const SizedBox(height: AppSpacing.md16),

                // About Garage
                _buildAboutCard(),

                const SizedBox(height:100),

                
              ],
            ),
          ),
          // Sticky Button at Bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildStickyButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroImage() {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 250,
          color: AppColors.bgLightOrange,
          child: Image.network(
            mechanic.imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Center(
                child: Icon(
                  Icons.image_not_supported_outlined,
                  size: 60,
                  color: AppColors.primaryOrange,
                ),
              );
            },
          ),
        ),
        // Back Button
        Positioned(
          top: 20,
          left: AppSpacing.horizontalPadding,
          child: GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.bgWhite,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 8,
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.textDark,
                  size: 18,
                ),
              ),
            ),
          ),
        ),
        // Share Button
        Positioned(
          top: 20,
          right: AppSpacing.horizontalPadding,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.bgWhite,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 8,
                ),
              ],
            ),
            child: const Center(
              child: Icon(
                Icons.share_outlined,
                color: AppColors.textDark,
                size: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGarageInfoCard() {
    return Transform.translate(
      offset: const Offset(0, -30),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.horizontalPadding,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.bgWhite,
            borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
            border: Border.all(
              color: AppColors.borderColor,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(AppSpacing.md16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          mechanic.garageName,
                          style: AppTextStyles.headingLarge,
                        ),
                        const SizedBox(height: AppSpacing.xs8),
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
                              '(${mechanic.reviewCount} reviews)',
                              style: AppTextStyles.captionMedium,
                            ),
                          ],
                        ),
                      ],
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
              const SizedBox(height: AppSpacing.sm12),
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: AppColors.textSecondary,
                    size: 16,
                  ),
                  const SizedBox(width: AppSpacing.xs4),
                  Text(
                    '${mechanic.distanceKm} km away',
                    style: AppTextStyles.captionMedium,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(
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
              AppStrings.address,
              style: AppTextStyles.headingSmall,
            ),
            const SizedBox(height: AppSpacing.sm12),
            Text(
              mechanic.fullAddress,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.md16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.directions_outlined),
                label: Text(AppStrings.directions),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.bgLightOrange,
                  foregroundColor: AppColors.primaryOrange,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServicesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.horizontalPadding,
          ),
          child: Text(
            'Services',
            style: AppTextStyles.headingLarge,
          ),
        ),
        const SizedBox(height: AppSpacing.md16),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.horizontalPadding,
          ),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: AppSpacing.md16,
              crossAxisSpacing: AppSpacing.md16,
              childAspectRatio: 1.0,
            ),
            itemCount: mechanic.services.length,
            itemBuilder: (context, index) {
              final service = mechanic.services[index];
              return ServiceCard(
                service: service,
                isCompact: false,
                onTap: () {},
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildWorkingHoursCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.horizontalPadding,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.workingHours,
                  style: AppTextStyles.headingSmall,
                ),
                const SizedBox(height: AppSpacing.xs8),
                Text(
                  mechanic.workingDays,
                  style: AppTextStyles.bodyMedium,
                ),
                const SizedBox(height: AppSpacing.xs4),
                Text(
                  '${mechanic.workingHoursStart} - ${mechanic.workingHoursEnd}',
                  style: AppTextStyles.captionMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            Icon(
              Icons.expand_more,
              color: AppColors.textSecondary,
              size: AppSpacing.iconMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.horizontalPadding,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.contact,
                  style: AppTextStyles.headingSmall,
                ),
                const SizedBox(height: AppSpacing.sm12),
                Text(
                  mechanic.phoneNumber,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.bgLightOrange,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Icons.phone_outlined,
                  color: AppColors.primaryOrange,
                  size: AppSpacing.iconMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.horizontalPadding,
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
              AppStrings.aboutGarage,
              style: AppTextStyles.headingSmall,
            ),
            const SizedBox(height: AppSpacing.sm12),
            Text(
              mechanic.description,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStickyButton() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bgWhite,
        border: Border(
          top: BorderSide(
            color: AppColors.borderColor,
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md16),
          child: CustomButton(
            text: AppStrings.requestService,
            onPressed: () {
              context.push('/request-service/${mechanic.id}');
            },
          ),
        ),
      ),
    );
  }
}