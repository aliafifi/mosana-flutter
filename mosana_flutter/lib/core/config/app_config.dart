import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Application configuration loaded from environment variables
class AppConfig {
  // Private constructor
  AppConfig._();

  /// API Configuration
  static String get apiBaseUrl => dotenv.env['API_BASE_URL'] ?? 'https://api.mosana.xyz';
  static int get apiTimeout => int.tryParse(dotenv.env['API_TIMEOUT'] ?? '30000') ?? 30000;

  /// WebSocket Configuration
  static String get wsUrl => dotenv.env['WS_URL'] ?? 'wss://api.mosana.xyz/notifications';

  /// Firebase Configuration
  static String get firebaseProjectId => dotenv.env['FIREBASE_PROJECT_ID'] ?? 'mosana-9586f';
  static String get firebaseMessagingSenderId => dotenv.env['FIREBASE_MESSAGING_SENDER_ID'] ?? '';
  static String get firebaseAppIdAndroid => dotenv.env['FIREBASE_APP_ID_ANDROID'] ?? '';
  static String get firebaseAppIdIos => dotenv.env['FIREBASE_APP_ID_IOS'] ?? '';
  static String get firebaseApiKeyAndroid => dotenv.env['FIREBASE_API_KEY_ANDROID'] ?? '';
  static String get firebaseApiKeyIos => dotenv.env['FIREBASE_API_KEY_IOS'] ?? '';

  /// App Configuration
  static String get appName => dotenv.env['APP_NAME'] ?? 'Mosana';
  static String get appVersion => dotenv.env['APP_VERSION'] ?? '1.0.0';
  static String get environment => dotenv.env['ENVIRONMENT'] ?? 'production';

  /// Helper methods
  static bool get isProduction => environment == 'production';
  static bool get isDevelopment => environment == 'development';

  /// Initialize environment variables
  static Future<void> init() async {
    await dotenv.load(fileName: '.env');
  }
}
