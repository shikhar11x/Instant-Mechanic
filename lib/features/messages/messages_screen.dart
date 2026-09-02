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
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  int _currentNavIndex = 2;

  bool _showSearch = false;

  // Nullable to prevent Flutter Web hot reload JS undefined errors.
  String? _searchQuery = '';

  final TextEditingController _searchController =
      TextEditingController();

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

  List<Message> get _filteredMessages {
    final String query =
        (_searchQuery ?? '').trim().toLowerCase();

    if (query.isEmpty) {
      return _messages;
    }

    return _messages.where((message) {
      final senderName = message.senderName.toLowerCase();
      final lastMessage = message.lastMessage.toLowerCase();

      return senderName.contains(query) ||
          lastMessage.contains(query);
    }).toList();
  }

  int get _totalUnreadMessages {
    return _messages.fold<int>(
      0,
      (total, message) => total + message.unreadCount,
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Message> messages = _filteredMessages;

    return Scaffold(
      backgroundColor: AppColors.bgWarmWhite,

      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),

            AnimatedSize(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutCubic,
              child: _showSearch
                  ? _buildSearchBar()
                  : const SizedBox.shrink(),
            ),

            const SizedBox(height: 8),

            Expanded(
              child: messages.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.horizontalPadding,
                        8,
                        AppSpacing.horizontalPadding,
                        110,
                      ),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        return _buildMessageTile(
                          messages[index],
                        );
                      },
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
              context.go('/bookings');
              break;

            case 2:
              break;

            case 3:
              context.go('/profile');
              break;
          }
        },
        items: [
          BottomNavItem(
            icon: Icons.home_rounded,
            label: AppStrings.navHome,
          ),
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.horizontalPadding,
        14,
        AppSpacing.horizontalPadding,
        8,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Messages',
                  style: AppTextStyles.headingLarge.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppColors.textDark,
                  ),
                ),
              ),

              if (_totalUnreadMessages > 0)
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.bgLightOrange,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '$_totalUnreadMessages unread',
                    style: AppTextStyles.captionSmall.copyWith(
                      color: AppColors.primaryOrange,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _showSearch = !_showSearch;

                      if (!_showSearch) {
                        _searchController.clear();
                        _searchQuery = '';
                      }
                    });
                  },
                  borderRadius: BorderRadius.circular(15),
                  child: Ink(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: _showSearch
                          ? AppColors.primaryOrange
                          : AppColors.bgWhite,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: _showSearch
                            ? AppColors.primaryOrange
                            : AppColors.borderColor.withOpacity(0.55),
                      ),
                    ),
                    child: Icon(
                      _showSearch
                          ? Icons.close_rounded
                          : Icons.search_rounded,
                      color: _showSearch
                          ? Colors.white
                          : AppColors.textDark,
                      size: 22,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Stay connected with your service providers',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SEARCH BAR
  // ============================================================

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.horizontalPadding,
        12,
        AppSpacing.horizontalPadding,
        4,
      ),
      child: Container(
        height: 54,
        decoration: BoxDecoration(
          color: AppColors.bgWhite,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: AppColors.borderColor.withOpacity(0.55),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.025),
              blurRadius: 14,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: TextField(
          controller: _searchController,
          autofocus: true,
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
          style: AppTextStyles.bodyMedium,
          decoration: InputDecoration(
            hintText: 'Search conversations',
            hintStyle: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
            prefixIcon: Icon(
              Icons.search_rounded,
              color: AppColors.primaryOrange,
              size: 21,
            ),
            suffixIcon: (_searchQuery ?? '').isNotEmpty
                ? IconButton(
                    onPressed: () {
                      _searchController.clear();

                      setState(() {
                        _searchQuery = '';
                      });
                    },
                    icon: Icon(
                      Icons.close_rounded,
                      color: AppColors.textSecondary,
                    ),
                  )
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 4,
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // MESSAGE CARD
  // ============================================================

  Widget _buildMessageTile(Message message) {
    final bool isUnread = message.unreadCount > 0;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Navigate to chat screen.
          },
          borderRadius: BorderRadius.circular(22),
          child: Ink(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isUnread
                  ? AppColors.bgLightOrange.withOpacity(0.38)
                  : AppColors.bgWhite,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: isUnread
                    ? AppColors.primaryOrange.withOpacity(0.30)
                    : AppColors.borderColor.withOpacity(0.45),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(
                    isUnread ? 0.035 : 0.02,
                  ),
                  blurRadius: 14,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                _buildAvatar(message),

                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              message.senderName,
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

                          const SizedBox(width: 8),

                          Text(
                            message.timestamp,
                            style: AppTextStyles.captionSmall.copyWith(
                              color: isUnread
                                  ? AppColors.primaryOrange
                                  : AppColors.textSecondary,
                              fontWeight: isUnread
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 7),

                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              message.lastMessage,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.bodySmall.copyWith(
                                color: isUnread
                                    ? AppColors.textDark
                                    : AppColors.textSecondary,
                                fontWeight: isUnread
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                              ),
                            ),
                          ),

                          if (isUnread) ...[
                            const SizedBox(width: 10),

                            Container(
                              constraints: const BoxConstraints(
                                minWidth: 22,
                                minHeight: 22,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 3,
                              ),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColors.primaryOrange,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primaryOrange
                                        .withOpacity(0.25),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Text(
                                '${message.unreadCount}',
                                style:
                                    AppTextStyles.captionSmall.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 6),

                Icon(
                  Icons.chevron_right_rounded,
                  color: isUnread
                      ? AppColors.primaryOrange
                      : AppColors.textSecondary.withOpacity(0.6),
                  size: 21,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // AVATAR
  // ============================================================

  Widget _buildAvatar(Message message) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            color: AppColors.bgLightOrange,
            borderRadius: BorderRadius.circular(19),
            border: Border.all(
              color: AppColors.primaryOrange.withOpacity(0.12),
            ),
          ),
          child: Center(
            child: Text(
              message.senderImage,
              style: const TextStyle(fontSize: 28),
            ),
          ),
        ),

        if (message.isOnline)
          Positioned(
            right: -2,
            bottom: -2,
            child: Container(
              width: 17,
              height: 17,
              decoration: BoxDecoration(
                color: AppColors.successGreen,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.bgWhite,
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 5,
                  ),
                ],
              ),
            ),
          ),
      ],
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
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: AppColors.bgLightOrange,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.chat_bubble_outline_rounded,
                size: 42,
                color: AppColors.primaryOrange,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              'No conversations found',
              style: AppTextStyles.headingSmall.copyWith(
                fontWeight: FontWeight.w800,
                color: AppColors.textDark,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Try searching for another service provider.',
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