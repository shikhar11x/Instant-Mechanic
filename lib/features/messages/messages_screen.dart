import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:instant_mechanic/core/constants/app_colors.dart';
import 'package:instant_mechanic/core/constants/app_spacing.dart';
import 'package:instant_mechanic/core/constants/app_strings.dart';
import 'package:instant_mechanic/core/theme/app_text_styles.dart';
import 'package:instant_mechanic/shared/widgets/bottom_navigation.dart';

class Message {
  final String id;
  final String senderName;
  final String senderImage;
  final String lastMessage;
  final String timestamp;
  final int unreadCount;
  final bool isOnline;

  Message({
    required this.id,
    required this.senderName,
    required this.senderImage,
    required this.lastMessage,
    required this.timestamp,
    required this.unreadCount,
    required this.isOnline,
  });
}

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  int _currentNavIndex = 2;

  final List<Message> _messages = [
    Message(
      id: '1',
      senderName: 'Sharma Auto Garage',
      senderImage: '🔧',
      lastMessage: 'Your service is ready for pickup!',
      timestamp: '2 min ago',
      unreadCount: 2,
      isOnline: true,
    ),
    Message(
      id: '2',
      senderName: 'Royal Motors',
      senderImage: '🚗',
      lastMessage: 'Confirming your appointment for tomorrow',
      timestamp: '1 hour ago',
      unreadCount: 0,
      isOnline: true,
    ),
    Message(
      id: '3',
      senderName: 'Speedy Wheels',
      senderImage: '⚡',
      lastMessage: 'Thank you for booking with us',
      timestamp: '3 hours ago',
      unreadCount: 0,
      isOnline: false,
    ),
    Message(
      id: '4',
      senderName: 'Auto Care Point',
      senderImage: '🔩',
      lastMessage: 'We are currently closed',
      timestamp: 'Yesterday',
      unreadCount: 0,
      isOnline: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgWarmWhite,
      appBar: AppBar(
        backgroundColor: AppColors.bgWarmWhite,
        elevation: 0,
        surfaceTintColor: AppColors.bgWarmWhite,
        title: Text(
          'Messages',
          style: AppTextStyles.headingLarge,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.horizontalPadding),
            child: Icon(
              Icons.search_outlined,
              color: AppColors.textDark,
              size: AppSpacing.iconMedium,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _messages.length,
        itemBuilder: (context, index) {
          final message = _messages[index];
          return _buildMessageTile(message);
        },
      ),
      bottomNavigationBar: CustomBottomNavigation(
  currentIndex: 2,
  onTap: (index) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.push('/bookings');
        break;
      case 2:
        break;
      case 3:
        context.push('/profile');
        break;
    }
  },
  items: [
    BottomNavItem(icon: Icons.home_rounded, label: AppStrings.navHome),
    BottomNavItem(icon: Icons.bookmark_rounded, label: AppStrings.navBookings),
    BottomNavItem(icon: Icons.message_rounded, label: AppStrings.navMessages),
    BottomNavItem(icon: Icons.person_rounded, label: AppStrings.navProfile),
  ],
),
    );
  }

  Widget _buildMessageTile(Message message) {
    return GestureDetector(
      onTap: () {
        // Navigate to chat screen
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.horizontalPadding,
          vertical: AppSpacing.md16,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.borderColor,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            // Avatar
            Stack(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.bgLightOrange,
                  ),
                  child: Center(
                    child: Text(
                      message.senderImage,
                      style: const TextStyle(fontSize: 32),
                    ),
                  ),
                ),
                if (message.isOnline)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.successGreen,
                        border: Border.all(
                          color: AppColors.bgWhite,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: AppSpacing.md16),

            // Message content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        message.senderName,
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        message.timestamp,
                        style: AppTextStyles.captionSmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          message.lastMessage,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (message.unreadCount > 0)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.xs8,
                            vertical: AppSpacing.xs4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryOrange,
                            borderRadius: BorderRadius.circular(
                              AppSpacing.radiusSmall,
                            ),
                          ),
                          child: Text(
                            '${message.unreadCount}',
                            style: AppTextStyles.labelSmall.copyWith(
                              color: Colors.white,
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
}