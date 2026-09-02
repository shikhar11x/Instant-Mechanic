import 'package:flutter/material.dart';

import 'package:instant_mechanic/core/constants/app_colors.dart';
import 'package:instant_mechanic/core/constants/app_spacing.dart';
import 'package:instant_mechanic/core/theme/app_text_styles.dart';
import 'package:instant_mechanic/shared/widgets/status_badge.dart';
import 'package:instant_mechanic/shared/enums/badge_status.dart';

class AppNotification {
  final String id;
  final String title;
  final String message;
  final String timestamp;
  final String type;
  final bool isRead;
  final String icon;

  const AppNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
    required this.type,
    required this.isRead,
    required this.icon,
  });

  AppNotification copyWith({
    String? id,
    String? title,
    String? message,
    String? timestamp,
    String? type,
    bool? isRead,
    String? icon,
  }) {
    return AppNotification(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
      icon: icon ?? this.icon,
    );
  }
}

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState
    extends State<NotificationsScreen> {
  late List<AppNotification> _notifications;

  @override
  void initState() {
    super.initState();

    _notifications = [
      const AppNotification(
        id: '1',
        title: 'Booking Confirmed!',
        message:
            'Your service booking at Sharma Auto Garage is confirmed for 25 May at 10:30 AM.',
        timestamp: '2 min ago',
        type: 'booking',
        isRead: false,
        icon: '✓',
      ),
      const AppNotification(
        id: '2',
        title: 'Service Completed',
        message:
            'Your oil change service at Royal Motors has been completed. Amount: ₹800',
        timestamp: '1 hour ago',
        type: 'booking',
        isRead: false,
        icon: '🔧',
      ),
      const AppNotification(
        id: '3',
        title: 'New Message',
        message:
            'Speedy Wheels sent you a message about your appointment.',
        timestamp: '3 hours ago',
        type: 'message',
        isRead: true,
        icon: '💬',
      ),
      const AppNotification(
        id: '4',
        title: 'Special Offer!',
        message:
            'Get 20% off on General Service at all partner garages this week!',
        timestamp: 'Yesterday',
        type: 'promo',
        isRead: true,
        icon: '🎉',
      ),
      const AppNotification(
        id: '5',
        title: 'Appointment Reminder',
        message:
            'Your appointment at Auto Care Point is tomorrow at 2:00 PM.',
        timestamp: 'Yesterday',
        type: 'alert',
        isRead: true,
        icon: '⏰',
      ),
    ];
  }

  int get _unreadCount {
    return _notifications
        .where((notification) => !notification.isRead)
        .length;
  }

  void _markAsRead(int index) {
    if (_notifications[index].isRead) return;

    setState(() {
      _notifications[index] =
          _notifications[index].copyWith(isRead: true);
    });
  }

  void _deleteNotification(String id) {
    setState(() {
      _notifications.removeWhere(
        (notification) => notification.id == id,
      );
    });
  }

  void _markAllAsRead() {
    setState(() {
      _notifications = _notifications
          .map(
            (notification) =>
                notification.copyWith(isRead: true),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgWarmWhite,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),

            Expanded(
              child: _notifications.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      physics:
                          const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.horizontalPadding,
                        12,
                        AppSpacing.horizontalPadding,
                        32,
                      ),
                      itemCount: _notifications.length,
                      itemBuilder: (context, index) {
                        final notification =
                            _notifications[index];

                        return _buildNotificationCard(
                          notification,
                          index,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // PREMIUM HEADER
  // ============================================================

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.horizontalPadding,
        12,
        AppSpacing.horizontalPadding,
        10,
      ),
      child: Column(
        children: [
          Row(
            children: [
              _buildBackButton(),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Notifications',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          AppTextStyles.headingLarge.copyWith(
                        color: AppColors.textDark,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _unreadCount > 0
                          ? '$_unreadCount unread notifications'
                          : 'You are all caught up',
                      style:
                          AppTextStyles.captionSmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              if (_unreadCount > 0)
                const SizedBox(width: 8),

              if (_unreadCount > 0)
                _buildMarkAllButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBackButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => Navigator.pop(context),
        borderRadius: BorderRadius.circular(15),
        child: Ink(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: AppColors.bgWhite,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color:
                  AppColors.borderColor.withOpacity(0.55),
            ),
          ),
          child: Icon(
            Icons.arrow_back_rounded,
            color: AppColors.textDark,
            size: 21,
          ),
        ),
      ),
    );
  }

  Widget _buildMarkAllButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _markAllAsRead,
        borderRadius: BorderRadius.circular(14),
        child: Ink(
          height: 42,
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          decoration: BoxDecoration(
            color: AppColors.bgLightOrange,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: AppColors.primaryOrange
                  .withOpacity(0.18),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.done_all_rounded,
                size: 18,
                color: AppColors.primaryOrange,
              ),
              const SizedBox(width: 6),
              Text(
                'Read all',
                style:
                    AppTextStyles.captionSmall.copyWith(
                  color: AppColors.primaryOrange,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // NOTIFICATION CARD
  // ============================================================

  Widget _buildNotificationCard(
    AppNotification notification,
    int index,
  ) {
    final bool isUnread = !notification.isRead;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Dismissible(
        key: ValueKey(notification.id),
        direction: DismissDirection.endToStart,

        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 24),
          decoration: BoxDecoration(
            color: AppColors.errorRed,
            borderRadius: BorderRadius.circular(22),
          ),
          child: const Icon(
            Icons.delete_outline_rounded,
            color: Colors.white,
            size: 25,
          ),
        ),

        onDismissed: (_) {
          _deleteNotification(notification.id);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                'Notification deleted',
              ),
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          );
        },

        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => _markAsRead(index),
            borderRadius: BorderRadius.circular(22),
            child: Ink(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: isUnread
                    ? AppColors.bgLightOrange
                        .withOpacity(0.42)
                    : AppColors.bgWhite,

                borderRadius: BorderRadius.circular(22),

                border: Border.all(
                  color: isUnread
                      ? AppColors.primaryOrange
                          .withOpacity(0.25)
                      : AppColors.borderColor
                          .withOpacity(0.50),
                ),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(
                      isUnread ? 0.035 : 0.02,
                    ),
                    blurRadius: 16,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),

              child: Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  _buildTypeIcon(notification),

                  const SizedBox(width: 13),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        _buildCardTitle(notification),

                        const SizedBox(height: 7),

                        Text(
                          notification.message,
                          maxLines: 2,
                          overflow:
                              TextOverflow.ellipsis,
                          style:
                              AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                            height: 1.35,
                          ),
                        ),

                        const SizedBox(height: 12),

                        Row(
                          children: [
                            Icon(
                              Icons.access_time_rounded,
                              size: 14,
                              color: AppColors.textSecondary
                                  .withOpacity(0.75),
                            ),

                            const SizedBox(width: 5),

                            Expanded(
                              child: Text(
                                notification.timestamp,
                                maxLines: 1,
                                overflow:
                                    TextOverflow.ellipsis,
                                style: AppTextStyles
                                    .captionSmall
                                    .copyWith(
                                  color:
                                      AppColors.textSecondary,
                                ),
                              ),
                            ),

                            const SizedBox(width: 8),

                            _buildNotificationBadge(
                              notification.type,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // CARD TITLE
  // ============================================================

  Widget _buildCardTitle(
    AppNotification notification,
  ) {
    final bool isUnread = !notification.isRead;

    return Row(
      children: [
        Expanded(
          child: Text(
            notification.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: isUnread
                  ? FontWeight.w800
                  : FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),
        ),

        if (isUnread) ...[
          const SizedBox(width: 8),

          Container(
            width: 9,
            height: 9,
            decoration: BoxDecoration(
              color: AppColors.primaryOrange,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryOrange
                      .withOpacity(0.30),
                  blurRadius: 7,
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  // ============================================================
  // NOTIFICATION TYPE ICON
  // ============================================================

  Widget _buildTypeIcon(
    AppNotification notification,
  ) {
    final IconData iconData =
        _getNotificationIcon(notification.type);

    final Color accentColor =
        _getNotificationAccentColor(
      notification.type,
    );

    return Container(
      width: 54,
      height: 54,
      decoration: BoxDecoration(
        color: accentColor.withOpacity(0.12),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: accentColor.withOpacity(0.16),
        ),
      ),
      child: Center(
        child: Icon(
          iconData,
          color: accentColor,
          size: 25,
        ),
      ),
    );
  }

  IconData _getNotificationIcon(String type) {
    switch (type) {
      case 'booking':
        return Icons.calendar_month_rounded;

      case 'message':
        return Icons.chat_bubble_rounded;

      case 'promo':
        return Icons.local_offer_rounded;

      case 'alert':
        return Icons.notifications_active_rounded;

      default:
        return Icons.notifications_rounded;
    }
  }

  Color _getNotificationAccentColor(String type) {
    switch (type) {
      case 'booking':
        return AppColors.primaryOrange;

      case 'message':
        return AppColors.successGreen;

      case 'promo':
        return AppColors.warningYellow;

      case 'alert':
        return AppColors.errorRed;

      default:
        return AppColors.primaryOrange;
    }
  }

  // ============================================================
  // EMPTY STATE
  // ============================================================

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
        ),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: AppColors.bgLightOrange,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.notifications_none_rounded,
                size: 45,
                color: AppColors.primaryOrange,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              'No notifications',
              style: AppTextStyles.headingSmall.copyWith(
                fontWeight: FontWeight.w800,
                color: AppColors.textDark,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'You are all caught up. New updates about your bookings and services will appear here.',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // BADGES
  // ============================================================

  Widget _buildNotificationBadge(String type) {
    switch (type) {
      case 'booking':
        return StatusBadge(
          text: 'Booking',
          status: BadgeStatus.confirmed,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm12,
            vertical: AppSpacing.xs4,
          ),
        );

      case 'message':
        return StatusBadge(
          text: 'Message',
          status: BadgeStatus.open,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm12,
            vertical: AppSpacing.xs4,
          ),
        );

      case 'promo':
        return StatusBadge(
          text: 'Promo',
          status: BadgeStatus.pending,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm12,
            vertical: AppSpacing.xs4,
          ),
        );

      case 'alert':
        return StatusBadge(
          text: 'Alert',
          status: BadgeStatus.closed,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm12,
            vertical: AppSpacing.xs4,
          ),
        );

      default:
        return const SizedBox.shrink();
    }
  }
}