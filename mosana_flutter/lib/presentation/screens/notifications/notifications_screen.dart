import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../core/config/colors.dart';
// import '../../../data/mock_data.dart'; // REMOVED: Using real API now
import '../../widgets/common/glass_card.dart';
import '../../widgets/common/user_avatar.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  // TODO: Connect to NotificationRepository
  final List<Map<String, dynamic>> _notifications = [];
  
  void _markAllAsRead() {
    // TODO: Mark all as read via API
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final unreadCount = _notifications.where((n) => !n['read']).length;

    return Scaffold(
      backgroundColor: AppColors.pureBlack,
      appBar: AppBar(
        backgroundColor: AppColors.deepPurpleBlack,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          if (unreadCount > 0)
            TextButton(
              onPressed: _markAllAsRead,
              child: Text(
                'Mark all read',
                style: TextStyle(color: AppColors.mosanaBlue),
              ),
            ),
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.white),
            onPressed: () {
              // TODO: Open settings
            },
          ),
        ],
      ),
      body: _notifications.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                final notification = _notifications[index];
                return _NotificationCard(
                  notification: notification,
                  onTap: () {
                    // TODO: Handle notification tap
                    print('Tapped notification ${notification['_id']}');
                  },
                );
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_none,
            size: 80,
            color: AppColors.textSecondary.withOpacity(0.5),
          ),
          const SizedBox(height: 24),
          const Text(
            'No notifications yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'When you get notifications, they\'ll appear here',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(horizontal: 40),
            decoration: BoxDecoration(
              color: AppColors.cardSurface.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.mosanaPurple.withOpacity(0.2),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.info_outline,
                  color: AppColors.mosanaPurple,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Notifications are coming soon! WebSocket real-time integration in progress.',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final Map<String, dynamic> notification;
  final VoidCallback? onTap;

  const _NotificationCard({
    required this.notification,
    this.onTap,
  });

  IconData _getIcon() {
    switch (notification['type'] as String) {
      case 'TIP_RECEIVED':
        return Icons.account_balance_wallet;
      case 'FOLLOW_NEW':
        return Icons.person_add;
      case 'POST_LIKED':
        return Icons.favorite;
      case 'POST_COMMENTED':
        return Icons.chat_bubble;
      case 'REPUTATION_MILESTONE':
        return Icons.emoji_events;
      default:
        return Icons.notifications;
    }
  }

  Color _getIconColor() {
    switch (notification['type'] as String) {
      case 'TIP_RECEIVED':
        return AppColors.gold;
      case 'FOLLOW_NEW':
        return AppColors.mosanaBlue;
      case 'POST_LIKED':
        return Colors.red;
      case 'POST_COMMENTED':
        return AppColors.mosanaBlue;
      case 'REPUTATION_MILESTONE':
        return AppColors.gold;
      default:
        return AppColors.textSecondary;
    }
  }

  bool _isHighPriority() {
    return notification['priority'] == 'high' || notification['priority'] == 'urgent';
  }

  @override
  Widget build(BuildContext context) {
    final isRead = notification['read'] as bool;
    final actor = notification['actor'] as Map<String, dynamic>?;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: GlassCard(
        variant: _isHighPriority()
            ? GlassCardVariant.highlighted
            : GlassCardVariant.standard,
        onTap: onTap,
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar or icon
            if (actor != null)
              UserAvatar.small(
                imageUrl: notification['imageUrl'] as String?,
                username: actor['username'] as String,
                isVerified: actor['verified'] as bool? ?? false,
              )
            else
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _getIconColor().withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _getIcon(),
                  color: _getIconColor(),
                  size: 20,
                ),
              ),

            const SizedBox(width: 12),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notification['title'] as String,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: isRead
                                ? AppColors.textSecondary
                                : Colors.white,
                          ),
                        ),
                      ),
                      if (!isRead)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.mosanaBlue,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification['message'] as String,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    timeago.format(notification['createdAt'] as DateTime),
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary.withOpacity(0.7),
                    ),
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
