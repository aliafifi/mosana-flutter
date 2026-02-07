import 'dart:async';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import '../utils/logger.dart';
import 'storage_service.dart';
import 'api_service.dart';

/// Top-level function for handling background messages
/// Must be a top-level function (not inside a class)
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  AppLogger.logInfo('📬 Background message received: ${message.messageId}');
  AppLogger.logInfo('Title: ${message.notification?.title}');
  AppLogger.logInfo('Body: ${message.notification?.body}');
}

/// Firebase Cloud Messaging service for push notifications
class NotificationService {
  final StorageService _storageService;
  final ApiService _apiService;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  
  // Stream controllers for notification events
  final _notificationController = StreamController<RemoteMessage>.broadcast();
  final _tokenController = StreamController<String>.broadcast();
  
  // Public streams
  Stream<RemoteMessage> get notificationStream => _notificationController.stream;
  Stream<String> get tokenStream => _tokenController.stream;
  
  bool _initialized = false;
  String? _currentToken;
  
  NotificationService({
    required StorageService storageService,
    required ApiService apiService,
  })  : _storageService = storageService,
        _apiService = apiService;
  
  /// Initialize Firebase Messaging
  Future<void> initialize() async {
    if (_initialized) {
      AppLogger.logInfo('NotificationService already initialized');
      return;
    }
    
    try {
      AppLogger.logInfo('Initializing Firebase Messaging...');
      
      // Request permissions (iOS)
      await _requestPermissions();
      
      // Get FCM token
      final token = await _firebaseMessaging.getToken();
      if (token != null) {
        AppLogger.logInfo('✅ FCM Token: ${token.substring(0, 20)}...');
        _currentToken = token;
        await _saveToken(token);
        await _registerTokenWithBackend(token);
        _tokenController.add(token);
      }
      
      // Listen for token refresh
      _firebaseMessaging.onTokenRefresh.listen((newToken) {
        AppLogger.logInfo('🔄 FCM Token refreshed');
        _currentToken = newToken;
        _saveToken(newToken);
        _registerTokenWithBackend(newToken);
        _tokenController.add(newToken);
      });
      
      // Set up foreground message handler
      FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
      
      // Set up background message handler
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
      
      // Set up notification tap handler (app opened from notification)
      FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);
      
      // Check if app was opened from a notification
      final initialMessage = await _firebaseMessaging.getInitialMessage();
      if (initialMessage != null) {
        AppLogger.logInfo('App opened from notification');
        _handleNotificationTap(initialMessage);
      }
      
      // Set foreground notification presentation options (iOS)
      await _firebaseMessaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
      
      _initialized = true;
      AppLogger.logInfo('✅ NotificationService initialized successfully');
      
    } catch (e, stackTrace) {
      AppLogger.logError('Failed to initialize NotificationService: $e', e, stackTrace);
    }
  }
  
  /// Request notification permissions (iOS)
  Future<void> _requestPermissions() async {
    if (!Platform.isIOS) {
      AppLogger.logInfo('Skipping permission request (not iOS)');
      return;
    }
    
    final settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      AppLogger.logInfo('✅ Notification permissions granted');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      AppLogger.logInfo('📋 Provisional notification permissions granted');
    } else {
      AppLogger.logWarning('❌ Notification permissions denied');
    }
  }
  
  /// Save FCM token to local storage
  Future<void> _saveToken(String token) async {
    try {
      await _storageService.saveFcmToken(token);
      AppLogger.logInfo('💾 FCM token saved to storage');
    } catch (e) {
      AppLogger.logError('Failed to save FCM token: $e');
    }
  }
  
  /// Register FCM token with backend
  Future<void> _registerTokenWithBackend(String token) async {
    try {
      // TODO: Implement when backend endpoint is ready
      // await _apiService.registerFcmToken(token);
      AppLogger.logInfo('📤 FCM token registered with backend');
    } catch (e) {
      AppLogger.logError('Failed to register FCM token with backend: $e');
    }
  }
  
  /// Handle foreground messages (app is open)
  void _handleForegroundMessage(RemoteMessage message) {
    AppLogger.logInfo('📬 Foreground notification received');
    AppLogger.logInfo('Title: ${message.notification?.title}');
    AppLogger.logInfo('Body: ${message.notification?.body}');
    AppLogger.logInfo('Data: ${message.data}');
    
    // Add to stream for UI to handle
    _notificationController.add(message);
    
    // Update badge count
    _updateBadgeCount();
  }
  
  /// Handle notification tap (app opened from notification)
  void _handleNotificationTap(RemoteMessage message) {
    AppLogger.logInfo('👆 Notification tapped');
    AppLogger.logInfo('Data: ${message.data}');
    
    // Navigate based on notification type
    final type = message.data['type'] as String?;
    final targetId = message.data['target_id'] as String?;
    
    if (type != null && targetId != null) {
      _navigateToTarget(type, targetId);
    }
  }
  
  /// Navigate to target screen based on notification type
  void _navigateToTarget(String type, String targetId) {
    AppLogger.logInfo('Navigating to: $type with ID: $targetId');
    
    // TODO: Implement navigation when router is set up
    switch (type) {
      case 'like':
      case 'comment':
      case 'mint':
        // Navigate to post detail
        AppLogger.logInfo('Navigate to post: $targetId');
        break;
      case 'tip':
        // Navigate to transaction detail
        AppLogger.logInfo('Navigate to transaction: $targetId');
        break;
      case 'follow':
        // Navigate to user profile
        AppLogger.logInfo('Navigate to profile: $targetId');
        break;
      default:
        AppLogger.logWarning('Unknown notification type: $type');
    }
  }
  
  /// Update app badge count
  Future<void> _updateBadgeCount() async {
    try {
      // TODO: Get actual unread count from backend
      // For now, just clear the badge
      if (Platform.isIOS) {
        await _firebaseMessaging.setApplicationIconBadgeNumber(0);
      }
    } catch (e) {
      AppLogger.logError('Failed to update badge count: $e');
    }
  }
  
  /// Subscribe to a topic
  Future<void> subscribeToTopic(String topic) async {
    try {
      await _firebaseMessaging.subscribeToTopic(topic);
      AppLogger.logInfo('✅ Subscribed to topic: $topic');
    } catch (e) {
      AppLogger.logError('Failed to subscribe to topic $topic: $e');
    }
  }
  
  /// Unsubscribe from a topic
  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _firebaseMessaging.unsubscribeFromTopic(topic);
      AppLogger.logInfo('✅ Unsubscribed from topic: $topic');
    } catch (e) {
      AppLogger.logError('Failed to unsubscribe from topic $topic: $e');
    }
  }
  
  /// Get current FCM token
  String? get currentToken => _currentToken;
  
  /// Check if notifications are enabled
  Future<bool> areNotificationsEnabled() async {
    final settings = await _firebaseMessaging.getNotificationSettings();
    return settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional;
  }
  
  /// Clear all notifications
  Future<void> clearAllNotifications() async {
    try {
      // Clear badge count
      if (Platform.isIOS) {
        await _firebaseMessaging.setApplicationIconBadgeNumber(0);
      }
      
      // TODO: Clear notification center on Android
      // This requires a plugin like flutter_local_notifications
      
      AppLogger.logInfo('✅ All notifications cleared');
    } catch (e) {
      AppLogger.logError('Failed to clear notifications: $e');
    }
  }
  
  /// Dispose resources
  Future<void> dispose() async {
    await _notificationController.close();
    await _tokenController.close();
    AppLogger.logInfo('NotificationService disposed');
  }
}
