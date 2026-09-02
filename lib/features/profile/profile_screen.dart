import 'package:flutter/material.dart';
import 'package:instant_mechanic/core/constants/app_colors.dart';
import 'package:instant_mechanic/core/constants/app_spacing.dart';
import 'package:instant_mechanic/core/constants/app_strings.dart';
import 'package:instant_mechanic/core/theme/app_text_styles.dart';
import 'package:instant_mechanic/shared/widgets/bottom_navigation.dart';
import 'package:instant_mechanic/shared/widgets/custom_button.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Map<String, dynamic>> vehicles = [
    {
      'name': 'Maruti Swift',
      'number': 'DL01AB0001',
      'year': 2022,
      'health': 'Good',
      'mileage': 45000,
    },
    {
      'name': 'Hyundai Creta',
      'number': 'DL02CD1234',
      'year': 2020,
      'health': 'Excellent',
      'mileage': 38000,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgWarmWhite,
      appBar: AppBar(
        backgroundColor: AppColors.bgWarmWhite,
        elevation: 0,
        surfaceTintColor: AppColors.bgWarmWhite,
        title: Text('Profile', style: AppTextStyles.headingLarge),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.horizontalPadding),
            child: Icon(
              Icons.settings_outlined,
              color: AppColors.textDark,
              size: AppSpacing.iconMedium,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Premium Profile Card with Edit Button
            _buildPremiumProfileCard(),
            const SizedBox(height: AppSpacing.lg32),

            // Quick Stats
            _buildQuickStats(),
            const SizedBox(height: AppSpacing.lg32),

            // Vehicle Report Section
            _buildVehicleReportSection(),
            const SizedBox(height: AppSpacing.lg32),

            // Membership Info
            _buildMembershipCard(),
            const SizedBox(height: AppSpacing.lg32),

            // Menu Section
            _buildMenuSection(),
            const SizedBox(height: AppSpacing.xl56),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigation(
        currentIndex: 3,
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/');
              break;
            case 1:
              context.push('/bookings');
              break;
            case 2:
              context.push('/messages');
              break;
            case 3:
              break;
          }
        },
        items: [
          BottomNavItem(icon: Icons.home_rounded, label: AppStrings.navHome),
          BottomNavItem(
            icon: Icons.bookmark_rounded,
            label: AppStrings.navBookings,
          ),
          BottomNavItem(
            icon: Icons.message_rounded,
            label: AppStrings.navMessages,
          ),
          BottomNavItem(
            icon: Icons.person_rounded,
            label: AppStrings.navProfile,
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumProfileCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.horizontalPadding,
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.bgWhite,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: AppColors.borderColor.withValues(alpha: 0.55),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.045),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 72,
                  height: 72,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryOrange,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryOrange.withValues(alpha: 0.22),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.network(
                      'https://avatars.githubusercontent.com/u/142872564?v=4',
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) {
                        return Container(
                          color: AppColors.bgLightOrange,
                          child: Icon(
                            Icons.person_rounded,
                            color: AppColors.primaryOrange,
                            size: 34,
                          ),
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Shikhar Bajpal',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.headingMedium.copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppColors.textDark,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        '${vehicles.length} vehicles registered',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.bgLightOrange,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'GOLD MEMBER',
                          style: AppTextStyles.captionSmall.copyWith(
                            color: AppColors.primaryOrange,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.7,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: _showEditProfileDialog,
                    borderRadius: BorderRadius.circular(14),
                    child: Ink(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.bgLightOrange,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        Icons.edit_outlined,
                        color: AppColors.primaryOrange,
                        size: 21,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Container(
              height: 1,
              color: AppColors.borderColor.withValues(alpha: 0.5),
            ),

            const SizedBox(height: 18),

            Row(
              children: [
                Expanded(
                  child: _buildPremiumProfileStat(
                    value: '4.9',
                    label: 'Rating',
                    icon: Icons.star_rounded,
                  ),
                ),

                Container(
                  height: 42,
                  width: 1,
                  color: AppColors.borderColor.withValues(alpha: 0.5),
                ),

                Expanded(
                  child: _buildPremiumProfileStat(
                    value: '128',
                    label: 'Services',
                    icon: Icons.build_outlined,
                  ),
                ),

                Container(
                  height: 42,
                  width: 1,
                  color: AppColors.borderColor.withValues(alpha: 0.5),
                ),

                Expanded(
                  child: _buildPremiumProfileStat(
                    value: '₹28K',
                    label: 'Spent',
                    icon: Icons.account_balance_wallet_outlined,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPremiumProfileStat({
    required String value,
    required String label,
    required IconData icon,
  }) {
    return Column(
      children: [
        Icon(icon, size: 19, color: AppColors.primaryOrange),

        const SizedBox(height: 6),

        Text(
          value,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w800,
            color: AppColors.textDark,
          ),
        ),

        const SizedBox(height: 2),

        Text(
          label,
          style: AppTextStyles.captionSmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  void _showEditProfileDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.radiusLarge),
        ),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: AppSpacing.md16,
          right: AppSpacing.md16,
          top: AppSpacing.md16,
          bottom: AppSpacing.md16 + MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Edit Profile', style: AppTextStyles.headingMedium),
              const SizedBox(height: AppSpacing.md24),

              // Edit Profile Option
              _buildDialogOption(
                icon: Icons.person_outline,
                title: 'Edit Personal Info',
                subtitle: 'Update name, email, phone',
                onTap: () {
                  Navigator.pop(context);
                  // Edit logic
                },
              ),

              const SizedBox(height: AppSpacing.md12),

              // Add Vehicle Option
              _buildDialogOption(
                icon: Icons.add_circle_outline,
                title: 'Add Vehicle',
                subtitle: 'Register a new vehicle',
                onTap: () {
                  Navigator.pop(context);
                  _showAddVehicleDialog();
                },
              ),

              const SizedBox(height: AppSpacing.md12),

              // Change Password Option
              _buildDialogOption(
                icon: Icons.lock_outline,
                title: 'Change Password',
                subtitle: 'Update your password',
                onTap: () {
                  Navigator.pop(context);
                },
              ),

              const SizedBox(height: AppSpacing.md24),

              CustomButton(
                text: 'Close',
                onPressed: () => Navigator.pop(context),
                variant: ButtonVariant.outline,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddVehicleDialog() {
    final nameController = TextEditingController();
    final numberController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
        ),
        title: Text('Add New Vehicle', style: AppTextStyles.headingSmall),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Vehicle Name (e.g., Maruti Swift)',
                  hintStyle: AppTextStyles.inputHint,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm16,
                    vertical: AppSpacing.sm14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      AppSpacing.radiusMedium,
                    ),
                    borderSide: const BorderSide(color: AppColors.borderColor),
                  ),
                ),
                style: AppTextStyles.inputText,
              ),
              const SizedBox(height: AppSpacing.md16),
              TextField(
                controller: numberController,
                decoration: InputDecoration(
                  hintText: 'Vehicle Number (e.g., DL01AB0001)',
                  hintStyle: AppTextStyles.inputHint,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm16,
                    vertical: AppSpacing.sm14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      AppSpacing.radiusMedium,
                    ),
                    borderSide: const BorderSide(color: AppColors.borderColor),
                  ),
                ),
                style: AppTextStyles.inputText,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              if (nameController.text.isNotEmpty &&
                  numberController.text.isNotEmpty) {
                setState(() {
                  vehicles.add({
                    'name': nameController.text,
                    'number': numberController.text,
                    'year': 2024,
                    'health': 'Good',
                    'mileage': 0,
                  });
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Vehicle added successfully!'),
                    backgroundColor: AppColors.successGreen,
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
            child: Text(
              'Add',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.primaryOrange,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDialogOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md16),
        decoration: BoxDecoration(
          color: AppColors.bgLightOrange,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
          border: Border.all(
            color: AppColors.primaryOrange.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.primaryOrange,
              size: AppSpacing.iconMedium,
            ),
            const SizedBox(width: AppSpacing.md16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs4),
                  Text(
                    subtitle,
                    style: AppTextStyles.captionSmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.textSecondary,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyles.displaySmall.copyWith(
            color: AppColors.primaryOrange,
            fontSize: 22,
          ),
        ),
        const SizedBox(height: AppSpacing.xs4),
        Text(
          label,
          style: AppTextStyles.captionSmall.copyWith(
            color: Colors.white.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickStats() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.horizontalPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Quick Stats', style: AppTextStyles.headingMedium),
          const SizedBox(height: AppSpacing.md16),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  icon: Icons.bookmark_outlined,
                  value: '12',
                  label: 'Bookings',
                  color: AppColors.successGreen,
                ),
              ),
              const SizedBox(width: AppSpacing.md16),
              Expanded(
                child: _buildStatCard(
                  icon: Icons.star_outline,
                  value: '4.8',
                  label: 'Avg Rating',
                  color: AppColors.warningYellow,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.bgWhite,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: AppColors.borderColor.withValues(alpha: 0.45),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.025),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color, size: 22),
          ),

          const SizedBox(height: 18),

          Text(
            value,
            style: AppTextStyles.headingMedium.copyWith(
              fontWeight: FontWeight.w800,
              color: AppColors.textDark,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            label,
            style: AppTextStyles.captionMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleReportSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.horizontalPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Your Vehicles', style: AppTextStyles.headingMedium),
              GestureDetector(
                onTap: () {
                  // View all vehicles report
                },
                child: Text(
                  'See report →',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.primaryOrange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: vehicles.length,
            itemBuilder: (context, index) {
              final vehicle = vehicles[index];
              return _buildVehicleCard(vehicle, index);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleCard(Map<String, dynamic> vehicle, int index) {
    final healthColor = vehicle['health'] == 'Excellent'
        ? AppColors.successGreen
        : AppColors.warningYellow;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: AppColors.bgWhite,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.025),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(17),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: AppColors.bgLightOrange,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    Icons.directions_car_filled_rounded,
                    color: AppColors.primaryOrange,
                    size: 26,
                  ),
                ),

                const SizedBox(width: 13),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        vehicle['name'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppColors.textDark,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        vehicle['number'],
                        style: AppTextStyles.captionMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: healthColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    vehicle['health'],
                    style: AppTextStyles.captionSmall.copyWith(
                      color: healthColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.bgWarmWhite,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _buildVehicleInfo(
                      icon: Icons.calendar_today_outlined,
                      label: 'Year',
                      value: '${vehicle['year']}',
                    ),
                  ),

                  Container(height: 30, width: 1, color: AppColors.borderColor),

                  Expanded(
                    child: _buildVehicleInfo(
                      icon: Icons.speed_outlined,
                      label: 'Mileage',
                      value: '${vehicle['mileage']} km',
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 11,
                    horizontal: 14,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.bgLightOrange,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'View Vehicle Details',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.primaryOrange,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const SizedBox(width: 6),

                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 17,
                        color: AppColors.primaryOrange,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVehicleInfo({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 16, color: AppColors.primaryOrange),

        const SizedBox(width: 7),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: AppTextStyles.captionSmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),

            const SizedBox(height: 2),

            Text(
              value,
              style: AppTextStyles.captionSmall.copyWith(
                color: AppColors.textDark,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    );
  }
  // Widget _buildVehicleCard(Map<String, dynamic> vehicle, int index) {}

  Widget _buildMembershipCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.horizontalPadding,
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.primaryOrange,
          borderRadius: BorderRadius.circular(26),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryOrange.withValues(alpha: 0.18),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.16),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(
                    Icons.workspace_premium_rounded,
                    color: Colors.white,
                    size: 25,
                  ),
                ),

                const SizedBox(width: 13),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Gold Membership',
                        style: AppTextStyles.headingSmall.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),

                      const SizedBox(height: 3),

                      Text(
                        'Your premium benefits',
                        style: AppTextStyles.captionMedium.copyWith(
                          color: Colors.white.withValues(alpha: 0.75),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            _buildPremiumBenefit(
              Icons.percent_rounded,
              '20% off on all services',
            ),

            _buildPremiumBenefit(Icons.bolt_rounded, 'Priority booking'),

            _buildPremiumBenefit(
              Icons.health_and_safety_outlined,
              'Free annual vehicle checkup',
            ),

            _buildPremiumBenefit(
              Icons.support_agent_rounded,
              '24/7 customer support',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPremiumBenefit(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.16),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 15, color: Colors.white),
          ),

          const SizedBox(width: 11),

          Expanded(
            child: Text(
              text,
              style: AppTextStyles.bodySmall.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildBenefitRow(String text) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs8),
  //     child: Text(
  //       text,
  //       style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
  //     ),
  //   );
  // }

  Widget _buildMenuSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.horizontalPadding,
          ),
          child: Text('Account', style: AppTextStyles.headingMedium),
        ),
        const SizedBox(height: AppSpacing.md16),
        _buildMenuItem(
          icon: Icons.person_outline,
          label: 'Edit Profile',
          onTap: () => _showEditProfileDialog(),
        ),
        _buildMenuItem(
          icon: Icons.location_on_outlined,
          label: 'Saved Locations',
          onTap: () {},
        ),
        _buildMenuItem(
          icon: Icons.payment_outlined,
          label: 'Payment Methods',
          onTap: () {},
        ),
        _buildMenuItem(
          icon: Icons.car_rental_outlined,
          label: 'My Vehicles',
          onTap: () {},
        ),
        const SizedBox(height: AppSpacing.md24),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.horizontalPadding,
          ),
          child: Text('Support', style: AppTextStyles.headingMedium),
        ),
        const SizedBox(height: AppSpacing.md16),
        _buildMenuItem(
          icon: Icons.help_outline,
          label: 'Help & Support',
          onTap: () {},
        ),
        _buildMenuItem(
          icon: Icons.privacy_tip_outlined,
          label: 'Privacy Policy',
          onTap: () {},
        ),
        _buildMenuItem(
          icon: Icons.description_outlined,
          label: 'Terms & Conditions',
          onTap: () {},
        ),
        const SizedBox(height: AppSpacing.md24),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.horizontalPadding,
          ),
          child: CustomButton(
            text: 'Logout',
            onPressed: () {},
            variant: ButtonVariant.outline,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppSpacing.horizontalPadding,
        right: AppSpacing.horizontalPadding,
        bottom: 10,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Ink(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.bgWhite,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: AppColors.borderColor.withValues(alpha: 0.4),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: AppColors.bgLightOrange,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Icon(icon, color: AppColors.primaryOrange, size: 21),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: Text(
                    label,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                ),

                Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.textSecondary,
                  size: 22,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
