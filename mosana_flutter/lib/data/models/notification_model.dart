import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel {
  @JsonKey(name: '_id')
  final String id;
  final String recipientWallet;
  final String actorWallet;
  final String type;
  final String title;
  final String message;
  final Map<String, dynamic>? data;
  final bool read;
  final String? actionUrl;
  final String priority;
  final String? imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? readAt;

  NotificationModel({
    required this.id,
    required this.recipientWallet,
    required this.actorWallet,
    required this.type,
    required this.title,
    required this.message,
    this.data,
    required this.read,
    this.actionUrl,
    required this.priority,
    this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
    this.readAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

  /// Helper to get notification icon based on type
  String get iconEmoji {
    switch (type) {
      case 'POST_LIKED':
        return '❤️';
      case 'POST_COMMENTED':
        return '💬';
      case 'TIP_RECEIVED':
        return '💰';
      case 'FOLLOW_NEW':
        return '👤';
      case 'MENTION':
        return '@';
      case 'REPUTATION_MILESTONE':
        return '🏆';
      case 'DAO_PROPOSAL_CREATED':
        return '📜';
      case 'DAO_PROPOSAL_PASSED':
        return '✅';
      case 'VENTURE_INVITATION':
        return '🤝';
      case 'VENTURE_ACCEPTED':
        return '🎉';
      default:
        return '🔔';
    }
  }

  /// Helper to check if high priority
  bool get isHighPriority => priority == 'high' || priority == 'urgent';

  /// Helper to get time ago
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()}y ago';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()}mo ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  /// Copy with method for state updates
  NotificationModel copyWith({
    bool? read,
    DateTime? readAt,
  }) {
    return NotificationModel(
      id: id,
      recipientWallet: recipientWallet,
      actorWallet: actorWallet,
      type: type,
      title: title,
      message: message,
      data: data,
      read: read ?? this.read,
      actionUrl: actionUrl,
      priority: priority,
      imageUrl: imageUrl,
      createdAt: createdAt,
      updatedAt: updatedAt,
      readAt: readAt ?? this.readAt,
    );
  }
}
