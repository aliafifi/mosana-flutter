import '../core/services/api_service.dart';
import '../core/utils/logger.dart';
import '../data/models/notification_model.dart';

/// Result type for repository operations
sealed class Result<T> {
  const Result();
}

class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}

class Failure<T> extends Result<T> {
  final String error;
  const Failure(this.error);
}

/// Repository for notification operations
class NotificationRepository {
  final ApiService _apiService;
  
  NotificationRepository({required ApiService apiService})
      : _apiService = apiService;
  
  /// Get notifications with pagination
  Future<Result<List<NotificationModel>>> getNotifications({
    int page = 1,
    int limit = 20,
    bool? unreadOnly,
  }) async {
    try {
      AppLogger.logInfo('Fetching notifications (page: $page, limit: $limit, unreadOnly: $unreadOnly)');
      
      final response = await _apiService.getNotifications(
        page: page,
        limit: limit,
        unreadOnly: unreadOnly,
      );
      
      if (response.isSuccess && response.data != null) {
        final notifications = response.data!
            .map((json) => NotificationModel.fromJson(json))
            .toList();
        
        AppLogger.logInfo('✅ Fetched ${notifications.length} notifications');
        return Success(notifications);
      } else {
        final error = response.error ?? 'Failed to fetch notifications';
        AppLogger.logError('❌ Failed to fetch notifications: $error');
        return Failure(error);
      }
    } catch (e, stackTrace) {
      AppLogger.logError('Error fetching notifications: $e', e, stackTrace);
      return Failure(e.toString());
    }
  }
  
  /// Mark a notification as read
  Future<Result<void>> markAsRead(String notificationId) async {
    try {
      AppLogger.logInfo('Marking notification as read: $notificationId');
      
      final response = await _apiService.markNotificationRead(notificationId);
      
      if (response.isSuccess) {
        AppLogger.logInfo('✅ Notification marked as read');
        return const Success(null);
      } else {
        final error = response.error ?? 'Failed to mark notification as read';
        AppLogger.logError('❌ Failed to mark as read: $error');
        return Failure(error);
      }
    } catch (e, stackTrace) {
      AppLogger.logError('Error marking notification as read: $e', e, stackTrace);
      return Failure(e.toString());
    }
  }
  
  /// Mark all notifications as read
  Future<Result<void>> markAllAsRead() async {
    try {
      AppLogger.logInfo('Marking all notifications as read');
      
      final response = await _apiService.markAllNotificationsRead();
      
      if (response.isSuccess) {
        AppLogger.logInfo('✅ All notifications marked as read');
        return const Success(null);
      } else {
        final error = response.error ?? 'Failed to mark all notifications as read';
        AppLogger.logError('❌ Failed to mark all as read: $error');
        return Failure(error);
      }
    } catch (e, stackTrace) {
      AppLogger.logError('Error marking all notifications as read: $e', e, stackTrace);
      return Failure(e.toString());
    }
  }
  
  /// Delete a notification
  Future<Result<void>> deleteNotification(String notificationId) async {
    try {
      AppLogger.logInfo('Deleting notification: $notificationId');
      
      // TODO: Implement when backend endpoint is available
      // final response = await _apiService.deleteNotification(notificationId);
      
      AppLogger.logWarning('Delete notification endpoint not implemented yet');
      return const Failure('Not implemented');
      
    } catch (e, stackTrace) {
      AppLogger.logError('Error deleting notification: $e', e, stackTrace);
      return Failure(e.toString());
    }
  }
  
  /// Get unread notification count
  Future<Result<int>> getUnreadCount() async {
    try {
      AppLogger.logInfo('Fetching unread notification count');
      
      final response = await _apiService.getNotifications(
        page: 1,
        limit: 1,
        unreadOnly: true,
      );
      
      if (response.isSuccess && response.meta != null) {
        final count = response.meta!['unreadCount'] as int? ?? 0;
        AppLogger.logInfo('✅ Unread count: $count');
        return Success(count);
      } else {
        final error = response.error ?? 'Failed to fetch unread count';
        AppLogger.logError('❌ Failed to fetch unread count: $error');
        return Failure(error);
      }
    } catch (e, stackTrace) {
      AppLogger.logError('Error fetching unread count: $e', e, stackTrace);
      return Failure(e.toString());
    }
  }
}
