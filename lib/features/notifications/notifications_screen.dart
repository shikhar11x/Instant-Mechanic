import 'package:flutter/material.dart';
import 'package:instant_mechanic/core/constants/app_colors.dart';
import 'package:instant_mechanic/core/constants/app_spacing.dart';
import 'package:instant_mechanic/core/theme/app_text_styles.dart';
import 'package:instant_mechanic/shared/widgets/status_badge.dart';
import 'package:instant_mechanic/shared/enums/badge_status.dart';

class Notification {
  final String id;
  final String title;
  final String message;
  final String timestamp;
  final String type; // 'booking', 'message', 'alert', 'promo'
  final bool isRead;
  final String icon;

  Notification({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
    required this.type,
    required this.isRead,
    required this.icon,
  });
}

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late List<Notification> _notifications;

  @override
  void initState() {
    super.initState();
    _notifications = [
      Notification(
        id: '1',
        title: 'Booking Confirmed!',
        message: 'Your service booking at Sharma Auto Garage is confirmed for 25 May at 10:30 AM.',
        timestamp: '2 min ago',
        type: 'booking',
        isRead: false,
        icon: '✓',
      ),
      Notification(
        id: '2',
        title: 'Service Completed',
        message: 'Your oil change service at Royal Motors has been completed. Amount: ₹800',
        timestamp: '1 hour ago',
        type: 'booking',
        isRead: false,
        icon: '🔧',
      ),
      Notification(
        id: '3',
        title: 'New Message',
        message: 'Speedy Wheels sent you a message about your appointment.',
        timestamp: '3 hours ago',
        type: 'message',
        isRead: true,
        icon: '💬',
      ),
      Notification(
        id: '4',
        title: 'Special Offer!',
        message: 'Get 20% off on General Service at all partner garages this week!',
        timestamp: 'Yesterday',
        type: 'promo',
        isRead: true,
        icon: '🎉',
      ),
      Notification(
        id: '5',
        title: 'Appointment Reminder',
        message: 'Your appointment at Auto Care Point is tomorrow at 2:00 PM.',
        timestamp: 'Yesterday',
        type: 'alert',
        isRead: true,
        icon: '⏰',
      ),
    ];
  }

  void _markAsRead(int index) {
    setState(() {
      _notifications[index] = Notification(
        id: _notifications[index].id,
        title: _notifications[index].title,
        message: _notifications[index].message,
        timestamp: _notifications[index].timestamp,
        type: _notifications[index].type,
        isRead: true,
        icon: _notifications[index].icon,
      );
    });
  }

  void _deleteNotification(int index) {
    setState(() {
      _notifications.removeAt(index);
    });
  }

  void _markAllAsRead() {
    setState(() {
      _notifications = _notifications
          .map((n) => Notification(
                id: n.id,
                title: n.title,
                message: n.message,
                timestamp: n.timestamp,
                type: n.type,
                isRead: true,
                icon: n.icon,
              ))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final unreadCount = _notifications.where((n) => !n.isRead).length;

    return Scaffold(
      backgroundColor: AppColors.bgWarmWhite,
      appBar: AppBar(
        backgroundColor: AppColors.bgWarmWhite,
        elevation: 0,
        surfaceTintColor: AppColors.bgWarmWhite,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.textDark,
          ),
        ),
        title: Text(
          'Notifications',
          style: AppTextStyles.headingLarge,
        ),
        actions: [
          if (unreadCount > 0)
            Padding(
              padding:
                  const EdgeInsets.only(right: AppSpacing.horizontalPadding),
              child: GestureDetector(
                onTap: _markAllAsRead,
                child: Text(
                  'Mark all as read',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.primaryOrange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
      body: _notifications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_none_outlined,
                    size: 80,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(height: AppSpacing.md16),
                  Text(
                    'No notifications',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                final notification = _notifications[index];
                return _buildNotificationTile(notification, index);
              },
            ),
    );
  }

  Widget _buildNotificationTile(Notification notification, int index) {
    return Dismissible(
      key: Key(notification.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        _deleteNotification(index);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Notification deleted'),
            duration: Duration(seconds: 2),
          ),
        );
      },
      background: Container(
        color: AppColors.errorRed,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: AppSpacing.md16),
        child: const Icon(
          Icons.delete_outline,
          color: Colors.white,
        ),
      ),
      child: GestureDetector(
        onTap: () {
          if (!notification.isRead) {
            _markAsRead(index);
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.horizontalPadding,
            vertical: AppSpacing.md16,
          ),
          decoration: BoxDecoration(
            color: notification.isRead ? AppColors.bgWhite : AppColors.bgLightOrange,
            border: Border(
              bottom: BorderSide(
                color: AppColors.borderColor,
                width: 1,
              ),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon/Avatar
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _getNotificationColor(notification.type),
                ),
                child: Center(
                  child: Text(
                    notification.icon,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md16),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            notification.title,
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontWeight: notification.isRead
                                  ? FontWeight.w500
                                  : FontWeight.w700,
                              color: AppColors.textDark,
                            ),
                          ),
                        ),
                        if (!notification.isRead)
                          Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryOrange,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xs4),
                    Text(
                      notification.message,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.sm12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          notification.timestamp,
                          style: AppTextStyles.captionSmall.copyWith(
                            color: AppColors.textLight,
                          ),
                        ),
                        _buildNotificationBadge(notification.type),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getNotificationColor(String type) {
    switch (type) {
      case 'booking':
        return AppColors.primaryOrange.withValues(alpha: 0.15);
      case 'message':
        return AppColors.successGreen.withValues(alpha: 0.15);
      case 'promo':
        return AppColors.warningYellow.withValues(alpha: 0.15);
      case 'alert':
        return AppColors.errorRed.withValues(alpha: 0.15);
      default:
        return AppColors.bgLightOrange;
    }
  }

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