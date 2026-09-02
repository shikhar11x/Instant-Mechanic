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
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [const Color(0xFF2A2A2A), const Color(0xFF1F1F1F)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            padding: const EdgeInsets.all(AppSpacing.md24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row with Avatar
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avatar
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.bgLightOrange,
                        border: Border.all(
                          color: AppColors.primaryOrange,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: ClipOval(
                          child: Image.network(
                            'https://avatars.githubusercontent.com/u/142872564?v=4',
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Shikhar Bajpal',
                            style: AppTextStyles.headingMedium.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xs4),
                          Text(
                            '${vehicles.length} Vehicles Registered',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: Colors.white.withValues(alpha: 0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md20),

                // Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md16,
                    vertical: AppSpacing.xs6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryOrange,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
                  ),
                  child: Text(
                    '⭐ GOLD MEMBER',
                    style: AppTextStyles.labelSmall.copyWith(
                      color: Colors.white,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md20),

                // Divider
                Container(
                  height: 1,
                  color: Colors.white.withValues(alpha: 0.1),
                ),
                const SizedBox(height: AppSpacing.md20),

                // Stats Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStatItem('4.9', 'Rating'),
                    _buildStatItem('128', 'Services'),
                    _buildStatItem('₹28K', 'Total Spent'),
                  ],
                ),
              ],
            ),
          ),
          // Edit Button (Top Right)
          Positioned(
            top: 16,
            right: 16,
            child: GestureDetector(
              onTap: _showEditProfileDialog,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primaryOrange,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.edit_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
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
      padding: const EdgeInsets.all(AppSpacing.md16),
      decoration: BoxDecoration(
        color: AppColors.bgWhite,
        borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
        border: Border.all(color: AppColors.borderColor, width: 1),
      ),
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(icon, color: color, size: AppSpacing.iconMedium),
            ),
          ),
          const SizedBox(height: AppSpacing.md12),
          Text(value, style: AppTextStyles.headingSmall.copyWith(color: color)),
          const SizedBox(height: AppSpacing.xs4),
          Text(
            label,
            style: AppTextStyles.captionSmall.copyWith(
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
      margin: const EdgeInsets.only(bottom: AppSpacing.md12),
      padding: const EdgeInsets.all(AppSpacing.md16),
      decoration: BoxDecoration(
        color: AppColors.bgWhite,
        borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
        border: Border.all(color: AppColors.borderColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    vehicle['name'],
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs4),
                  Text(
                    vehicle['number'],
                    style: AppTextStyles.captionMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm12,
                  vertical: AppSpacing.xs6,
                ),
                decoration: BoxDecoration(
                  color: healthColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
                ),
                child: Text(
                  vehicle['health'],
                  style: AppTextStyles.captionSmall.copyWith(
                    color: healthColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Year: ${vehicle['year']}',
                style: AppTextStyles.captionMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                'Mileage: ${vehicle['mileage']} km',
                style: AppTextStyles.captionMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md12),
          GestureDetector(
            onTap: () {
              // View vehicle details
            },
            child: Text(
              'View detailed report →',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.primaryOrange,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMembershipCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.horizontalPadding,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.bgLightOrange,
          borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
          border: Border.all(
            color: AppColors.primaryOrange.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        padding: const EdgeInsets.all(AppSpacing.md16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Membership Benefits',
              style: AppTextStyles.headingSmall.copyWith(
                color: AppColors.primaryOrange,
              ),
            ),
            const SizedBox(height: AppSpacing.md16),
            _buildBenefitRow('✓ 20% off on all services'),
            _buildBenefitRow('✓ Priority booking'),
            _buildBenefitRow('✓ Free annual car checkup'),
            _buildBenefitRow('✓ 24/7 customer support'),
            _buildBenefitRow('✓ Service reminders'),
            _buildBenefitRow('✓ Extended warranty options'),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefitRow(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs8),
      child: Text(
        text,
        style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
      ),
    );
  }

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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.horizontalPadding,
          vertical: AppSpacing.md16,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.borderColor, width: 1),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: AppColors.primaryOrange,
                  size: AppSpacing.iconMedium,
                ),
                const SizedBox(width: AppSpacing.md16),
                Text(label, style: AppTextStyles.bodyMedium),
              ],
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
}
