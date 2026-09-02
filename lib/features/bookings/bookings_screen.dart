import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:instant_mechanic/core/constants/app_colors.dart';
import 'package:instant_mechanic/core/constants/app_spacing.dart';
import 'package:instant_mechanic/core/constants/app_strings.dart';
import 'package:instant_mechanic/core/theme/app_text_styles.dart';
import 'package:instant_mechanic/shared/widgets/bottom_navigation.dart';
import 'package:instant_mechanic/shared/widgets/booking_details_card.dart';
import 'package:instant_mechanic/shared/widgets/status_badge.dart';
import 'package:instant_mechanic/shared/enums/badge_status.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({Key? key}) : super(key: key);

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  int _currentNavIndex = 1;
  String _selectedTab = 'active';

  final List<Map<String, dynamic>> _bookings = [
    {
      'id': 'BK001',
      'garage': 'Sharma Auto Garage',
      'service': 'Engine Repair',
      'date': '25 May 2026',
      'time': '10:30 AM',
      'status': 'confirmed',
      'amount': 5000,
    },
    {
      'id': 'BK002',
      'garage': 'Royal Motors',
      'service': 'Oil Change',
      'date': '20 May 2026',
      'time': '2:00 PM',
      'status': 'completed',
      'amount': 800,
    },
    {
      'id': 'BK003',
      'garage': 'Speedy Wheels',
      'service': 'Battery Service',
      'date': '28 May 2026',
      'time': '11:00 AM',
      'status': 'pending',
      'amount': 2000,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredBookings = _selectedTab == 'active'
        ? _bookings.where((b) => b['status'] != 'completed').toList()
        : _bookings.where((b) => b['status'] == 'completed').toList();

    return Scaffold(
      backgroundColor: AppColors.bgWarmWhite,
      appBar: AppBar(
        backgroundColor: AppColors.bgWarmWhite,
        elevation: 0,
        surfaceTintColor: AppColors.bgWarmWhite,
        title: Text('My Bookings', style: AppTextStyles.headingLarge),
      ),
      body: Column(
        children: [
          // Tab Selector
          Padding(
            padding: const EdgeInsets.all(AppSpacing.horizontalPadding),
            child: Row(
              children: [
                _buildTabButton('Active', 'active'),
                const SizedBox(width: AppSpacing.md16),
                _buildTabButton('Completed', 'completed'),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md16),

          // Bookings List
          Expanded(
            child: filteredBookings.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inbox_outlined,
                          size: 80,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(height: AppSpacing.md16),
                        Text(
                          'No ${_selectedTab} bookings',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.horizontalPadding,
                    ),
                    itemCount: filteredBookings.length,
                    itemBuilder: (context, index) {
                      final booking = filteredBookings[index];
                      return _buildBookingCard(booking);
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigation(
        currentIndex: 1,
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/');
              break;
            case 1:
              break;
            case 2:
              context.push('/messages');
              break;
            case 3:
              context.push('/profile');
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

  Widget _buildTabButton(String label, String value) {
    final isActive = _selectedTab == value;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md16,
          vertical: AppSpacing.sm12,
        ),
        decoration: BoxDecoration(
          color: isActive ? AppColors.bgLightOrange : AppColors.bgWhite,
          border: Border.all(
            color: isActive ? AppColors.primaryOrange : AppColors.borderColor,
            width: isActive ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        ),
        child: Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            color: isActive ? AppColors.primaryOrange : AppColors.textSecondary,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildBookingCard(Map<String, dynamic> booking) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md16),
      decoration: BoxDecoration(
        color: AppColors.bgWhite,
        borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
        border: Border.all(color: AppColors.borderColor, width: 1),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with status
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(booking['garage'], style: AppTextStyles.headingSmall),
                    StatusBadge(
                      text: booking['status'].toString().toUpperCase(),
                      status: booking['status'] == 'completed'
                          ? BadgeStatus.confirmed
                          : booking['status'] == 'pending'
                          ? BadgeStatus.pending
                          : BadgeStatus.open,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md16),

                // Service info
                Row(
                  children: [
                    Icon(
                      Icons.build_outlined,
                      color: AppColors.textSecondary,
                      size: AppSpacing.iconMedium,
                    ),
                    const SizedBox(width: AppSpacing.sm12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Service',
                            style: AppTextStyles.captionMedium.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          Text(
                            booking['service'],
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md12),

                // Date & Time
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      color: AppColors.textSecondary,
                      size: AppSpacing.iconMedium,
                    ),
                    const SizedBox(width: AppSpacing.sm12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${booking['date']} at ${booking['time']}',
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md12),

                // Amount
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Estimated Cost',
                      style: AppTextStyles.captionMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      '₹${booking['amount']}',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.primaryOrange,
                        fontWeight: FontWeight.w700,
                      ),
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
