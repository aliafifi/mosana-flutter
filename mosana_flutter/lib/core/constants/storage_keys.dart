/// SharedPreferences storage keys
class StorageKeys {
  // Private constructor
  StorageKeys._();

  /// Auth Keys
  static const String jwtToken = 'jwt_token';
  static const String walletAddress = 'wallet_address';
  static const String username = 'username';
  static const String isLoggedIn = 'is_logged_in';

  /// App State Keys
  static const String isFirstTime = 'isFirstTime';
  static const String lastSyncTime = 'last_sync_time';
  static const String fcmToken = 'fcm_token';

  /// User Preferences
  static const String themeMode = 'theme_mode';
  static const String notificationsEnabled = 'notifications_enabled';
  static const String language = 'language';
}
