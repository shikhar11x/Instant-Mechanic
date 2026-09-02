import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:instant_mechanic/core/constants/app_colors.dart';
import 'package:instant_mechanic/core/constants/app_strings.dart';
import 'package:instant_mechanic/core/theme/app_text_styles.dart';
import 'package:instant_mechanic/shared/widgets/bottom_navigation.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

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

      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),

            const SizedBox(height: 18),

            _buildSegmentedControl(),

            const SizedBox(height: 18),

            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: filteredBookings.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                        key: ValueKey(_selectedTab),
                        padding: const EdgeInsets.fromLTRB(20, 4, 20, 100),
                        itemCount: filteredBookings.length,
                        itemBuilder: (context, index) {
                          return _buildBookingCard(filteredBookings[index]);
                        },
                      ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: CustomBottomNavigation(
        currentIndex: _currentNavIndex,
        onTap: (index) {
          setState(() {
            _currentNavIndex = index;
          });

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

  // ============================================================
  // HEADER
  // ============================================================

  Widget _buildHeader() {
    final activeCount = _bookings
        .where((booking) => booking['status'] != 'completed')
        .length;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
      child: Column(
        children: [
          Row(
            children: [
              _buildBackButton(),

              const SizedBox(width: 14),

              Expanded(
                child: Text(
                  'My Bookings',
                  style: AppTextStyles.headingLarge.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.bgLightOrange,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.calendar_month_rounded,
                      size: 17,
                      color: AppColors.primaryOrange,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '$activeCount Active',
                      style: AppTextStyles.captionMedium.copyWith(
                        color: AppColors.primaryOrange,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Manage your vehicle service appointments',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          context.pop();
        },
        borderRadius: BorderRadius.circular(14),
        child: Ink(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.bgWhite,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.borderColor.withOpacity(0.6)),
          ),
          child: Icon(
            Icons.arrow_back_rounded,
            color: AppColors.textDark,
            size: 22,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // PREMIUM TABS
  // ============================================================

  Widget _buildSegmentedControl() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 68, // Increased from 54
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: AppColors.bgWhite,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: AppColors.borderColor.withOpacity(0.5)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.035),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: _buildTabButton(
                label: 'Active',
                value: 'active',
                icon: Icons.schedule_rounded,
              ),
            ),

            const SizedBox(width: 6),

            Expanded(
              child: _buildTabButton(
                label: 'Completed',
                value: 'completed',
                icon: Icons.check_circle_outline_rounded,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton({
    required String label,
    required String value,
    required IconData icon,
  }) {
    final isActive = _selectedTab == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = value;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,

        // Takes full available height now
        height: double.infinity,

        decoration: BoxDecoration(
          color: isActive ? AppColors.primaryOrange : Colors.transparent,

          borderRadius: BorderRadius.circular(16),

          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: AppColors.primaryOrange.withOpacity(0.24),
                    blurRadius: 12,
                    offset: const Offset(0, 5),
                  ),
                ]
              : [],
        ),

        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 20,
                color: isActive ? Colors.white : AppColors.textSecondary,
              ),

              const SizedBox(width: 9),

              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: isActive ? Colors.white : AppColors.textSecondary,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // ============================================================
  // BOOKING CARD
  // ============================================================

  Widget _buildBookingCard(Map<String, dynamic> booking) {
    final status = booking['status'].toString();

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.bgWhite,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.borderColor.withOpacity(0.45)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.035),
            blurRadius: 18,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Column(
          children: [
            // Orange accent line
            Container(
              height: 4,
              decoration: BoxDecoration(
                color: status == 'completed'
                    ? Colors.green
                    : status == 'pending'
                    ? Colors.amber
                    : AppColors.primaryOrange,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ------------------------------------------------
                  // GARAGE + STATUS
                  // ------------------------------------------------

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppColors.bgLightOrange,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Icon(
                          Icons.garage_rounded,
                          color: AppColors.primaryOrange,
                          size: 24,
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              booking['garage'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.headingSmall.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                            ),

                            const SizedBox(height: 4),

                            Text(
                              'Booking ID • ${booking['id']}',
                              style: AppTextStyles.captionMedium.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 8),

                      _buildStatusChip(status),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // ------------------------------------------------
                  // SERVICE BOX
                  // ------------------------------------------------
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.bgWarmWhite,
                      borderRadius: BorderRadius.circular(17),
                    ),
                    child: Row(
                      children: [
                        _buildInfoIcon(icon: Icons.build_rounded),

                        const SizedBox(width: 12),

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

                              const SizedBox(height: 3),

                              Text(
                                booking['service'],
                                style: AppTextStyles.bodyMedium.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // ------------------------------------------------
                  // DATE + TIME
                  // ------------------------------------------------
                  Row(
                    children: [
                      Expanded(
                        child: _buildDetailBox(
                          icon: Icons.calendar_today_rounded,
                          title: 'Date',
                          value: booking['date'],
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: _buildDetailBox(
                          icon: Icons.access_time_rounded,
                          title: 'Time',
                          value: booking['time'],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  Divider(
                    color: AppColors.borderColor.withOpacity(0.45),
                    height: 1,
                  ),

                  const SizedBox(height: 14),

                  // ------------------------------------------------
                  // PRICE + CTA
                  // ------------------------------------------------
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Estimated Cost',
                              style: AppTextStyles.captionMedium.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),

                            const SizedBox(height: 4),

                            Text(
                              '₹${booking['amount']}',
                              style: AppTextStyles.headingSmall.copyWith(
                                color: AppColors.primaryOrange,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            // Navigate to booking details
                          },
                          borderRadius: BorderRadius.circular(14),
                          child: Ink(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 11,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.bgLightOrange,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Details',
                                  style: AppTextStyles.captionMedium.copyWith(
                                    color: AppColors.primaryOrange,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),

                                const SizedBox(width: 5),

                                Icon(
                                  Icons.arrow_forward_rounded,
                                  size: 16,
                                  color: AppColors.primaryOrange,
                                ),
                              ],
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

  // ============================================================
  // STATUS CHIP
  // ============================================================

  Widget _buildStatusChip(String status) {
    late Color color;
    late Color background;
    late String text;

    switch (status) {
      case 'completed':
        color = Colors.green.shade700;
        background = Colors.green.withOpacity(0.10);
        text = 'COMPLETED';
        break;

      case 'pending':
        color = Colors.orange.shade800;
        background = Colors.orange.withOpacity(0.10);
        text = 'PENDING';
        break;

      default:
        color = Colors.green.shade700;
        background = Colors.green.withOpacity(0.10);
        text = 'CONFIRMED';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: AppTextStyles.captionMedium.copyWith(
          color: color,
          fontWeight: FontWeight.w800,
          fontSize: 10,
          letterSpacing: 0.7,
        ),
      ),
    );
  }

  // ============================================================
  // INFO ICON
  // ============================================================

  Widget _buildInfoIcon({required IconData icon}) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: AppColors.bgLightOrange,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Icon(icon, color: AppColors.primaryOrange, size: 21),
    );
  }

  // ============================================================
  // DATE / TIME BOX
  // ============================================================

  Widget _buildDetailBox({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.bgWarmWhite,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(icon, size: 17, color: AppColors.primaryOrange),

          const SizedBox(width: 8),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.captionMedium.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 10,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.captionMedium.copyWith(
                    color: AppColors.textDark,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // EMPTY STATE
  // ============================================================

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                color: AppColors.bgLightOrange,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.calendar_month_outlined,
                size: 42,
                color: AppColors.primaryOrange,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              'No ${_selectedTab} bookings',
              style: AppTextStyles.headingSmall.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Your bookings will appear here.',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
