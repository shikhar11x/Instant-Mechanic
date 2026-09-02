import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:instant_mechanic/core/constants/app_colors.dart';
import 'package:instant_mechanic/core/constants/app_spacing.dart';
import 'package:instant_mechanic/core/constants/app_strings.dart';
import 'package:instant_mechanic/core/theme/app_text_styles.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: Drawer(
        backgroundColor: AppColors.bgWhite,
        elevation: 0,
        child: Column(
          children: [
            // Premium Header
            _buildPremiumHeader(),

            // Menu Items
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildSectionTitle("Services"),
                    _buildMenuItem(
                      icon: Icons.build_circle_outlined,
                      label: AppStrings.drawerCarServices,
                      subtitle: "Book repair & maintenance",
                      onTap: () => Navigator.pop(context),
                    ),

                    _buildMenuItem(
                      icon: Icons.smart_toy_outlined,
                      label: AppStrings.drawerAIDiagnosis,
                      subtitle: "Scan engine instantly",
                      onTap: () => Navigator.pop(context),
                    ),

                    _buildMenuItem(
                      icon: Icons.card_membership_outlined,
                      label: AppStrings.drawerMembership,
                      subtitle: "Gold plan active",
                      onTap: () => Navigator.pop(context),
                    ),

                    _buildMenuItem(
                      icon: Icons.location_on_outlined,
                      label: AppStrings.drawerCoverage,
                      subtitle: "Available across India",
                      onTap: () => Navigator.pop(context),
                    ),

                    const SizedBox(height: AppSpacing.md20),

                    _buildSectionTitle("Account"),
                    _buildMenuItem(
                      icon: Icons.directions_car_outlined,
                      label: AppStrings.drawerMyVehicles,
                      subtitle: "2 vehicles registered",
                      onTap: () => Navigator.pop(context),
                    ),

                    _buildMenuItem(
                      icon: Icons.emergency_share_outlined,
                      label: AppStrings.drawerRoadsideHelp,
                      subtitle: "24×7 emergency support",
                      onTap: () => Navigator.pop(context),
                    ),

                    _buildMenuItem(
                      icon: Icons.settings_outlined,
                      label: AppStrings.drawerSettings,
                      subtitle: "Preferences & privacy",
                      onTap: () => Navigator.pop(context),
                    ),

                    const SizedBox(height: AppSpacing.md20),

                    _buildSectionTitle("Help"),
                    _buildMenuItem(
                      icon: Icons.help_outline,
                      label: AppStrings.drawerHelp,
                      subtitle: "FAQs & customer support",
                      onTap: () => Navigator.pop(context),
                    ),

                    _buildMenuItem(
                      icon: Icons.info_outline,
                      label: AppStrings.drawerAbout,
                      subtitle: "Version 2.0",
                      onTap: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
            ),

            // Premium Footer
            _buildPremiumFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildPremiumHeader() {
    return Container(
      margin: const EdgeInsets.fromLTRB(
        AppSpacing.md16,
        AppSpacing.xl56,
        AppSpacing.md16,
        0,
      ),
      padding: const EdgeInsets.all(AppSpacing.md20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF18181B), Color(0xFF2C2C30)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 30,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.08),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.15),
                  ),
                ),
                child: const Icon(
                  Icons.person_rounded,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Shikhar Bajpai",
                      style: AppTextStyles.headingSmall.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "2 Vehicles Registered",
                      style: AppTextStyles.bodySmall.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primaryOrange,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              "GOLD MEMBER",
              style: AppTextStyles.labelSmall.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
              ),
            ),
          ),
          const SizedBox(height: 18),
          Divider(color: Colors.white.withValues(alpha: 0.15)),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _statItem("4.9", "Rating")),
              Expanded(child: _statItem("128", "Services")),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statItem(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: AppTextStyles.headingMedium.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(color: Colors.white60),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md20,
        AppSpacing.md20,
        AppSpacing.md20,
        AppSpacing.sm12,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title.toUpperCase(),
          style: AppTextStyles.labelSmall.copyWith(
            color: AppColors.textSecondary,
            letterSpacing: 1.2,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isDestructive = false,
    String? subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md16,
        0,
        AppSpacing.md16,
        AppSpacing.sm12,
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.md16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.withValues(alpha: 0.08)),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: isDestructive
                        ? AppColors.errorRed.withValues(alpha: 0.08)
                        : AppColors.primaryOrange.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    icon,
                    color: isDestructive
                        ? AppColors.errorRed
                        : AppColors.primaryOrange,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: AppTextStyles.bodyLarge.copyWith(
                          fontWeight: FontWeight.w700,
                          color: isDestructive
                              ? AppColors.errorRed
                              : AppColors.textDark,
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          subtitle,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: Colors.grey.shade400,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md16,
        vertical: AppSpacing.md16,
      ),
      child: Container(
        height: 1,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.borderColor.withValues(alpha: 0),
              AppColors.borderColor,
              AppColors.borderColor.withValues(alpha: 0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPremiumFooter() {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md16,
        AppSpacing.sm12,
        AppSpacing.md16,
        AppSpacing.md20,
      ),
      decoration: BoxDecoration(
        color: AppColors.bgWhite,
        border: Border(
          top: BorderSide(color: Colors.grey.withValues(alpha: 0.10)),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _footerButton(
              icon: Icons.chat_rounded,
              title: "WhatsApp",
              color: const Color(0xFF22C55E),
              onTap: () {},
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _footerButton(
              icon: Icons.call_rounded,
              title: "Call Now",
              color: Colors.white,
              textColor: AppColors.textDark,
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _footerButton({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
    Color textColor = Colors.white,
  }) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          height: 56,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: textColor, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: AppTextStyles.buttonMedium.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactButton({
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onTap,
    bool isPrimary = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md12,
            vertical: AppSpacing.sm14,
          ),
          decoration: BoxDecoration(
            color: isPrimary
                ? AppColors.primaryOrange.withValues(alpha: 0.12)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
            border: Border.all(
              color: isPrimary
                  ? AppColors.primaryOrange.withValues(alpha: 0.3)
                  : AppColors.borderColor.withValues(alpha: 0.5),
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: isPrimary
                      ? AppColors.primaryOrange.withValues(alpha: 0.15)
                      : AppColors.textSecondary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
                ),
                child: Center(
                  child: Icon(
                    icon,
                    size: 18,
                    color: isPrimary
                        ? AppColors.primaryOrange
                        : AppColors.textSecondary,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      label,
                      style: AppTextStyles.captionSmall.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      value,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: isPrimary
                            ? AppColors.primaryOrange
                            : AppColors.textDark,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_outward,
                size: 16,
                color: isPrimary
                    ? AppColors.primaryOrange
                    : AppColors.textSecondary.withValues(alpha: 0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddressInfo() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md12,
        vertical: AppSpacing.sm12,
      ),
      decoration: BoxDecoration(
        color: AppColors.bgLightOrange.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
        border: Border.all(
          color: AppColors.primaryOrange.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.primaryOrange.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
            ),
            child: const Center(
              child: Icon(
                Icons.location_on_outlined,
                size: 16,
                color: AppColors.primaryOrange,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Headquarters',
                  style: AppTextStyles.captionSmall.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  AppStrings.addressGurugram,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textDark,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.bgWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
          side: BorderSide(
            color: AppColors.borderColor.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
        title: Text(
          'Logout',
          style: AppTextStyles.headingSmall.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          'Are you sure you want to logout?',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: AppTextStyles.buttonMedium.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.go('/');
            },
            child: Text(
              'Logout',
              style: AppTextStyles.buttonMedium.copyWith(
                color: AppColors.errorRed,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
