import 'package:logger/logger.dart';

/// Application logger with different log levels
class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
  );

  /// Log debug message (static)
  static void logDebug(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.d(message, error: error, stackTrace: stackTrace);
  }

  /// Log info message (static)
  static void logInfo(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.i(message, error: error, stackTrace: stackTrace);
  }

  /// Log warning message (static)
  static void logWarning(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  /// Log error message (static)
  static void logError(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  /// Log fatal/critical message (static)
  static void logFatal(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.f(message, error: error, stackTrace: stackTrace);
  }

  // ===================== INSTANCE METHODS (for backward compatibility) =====================
  
  /// Instance method - info
  void info(dynamic message) {
    AppLogger.logInfo(message);
  }

  /// Instance method - success (alias for info with emoji)
  void success(dynamic message) {
    AppLogger.logInfo('✅ $message');
  }

  /// Instance method - warning
  void warning(dynamic message) {
    AppLogger.logWarning(message);
  }

  /// Instance method - error
  void error(dynamic message) {
    AppLogger.logError(message);
  }
  
  // Static aliases for backward compatibility
  static void debug(dynamic message) => logDebug(message);
  static void info(dynamic message) => logInfo(message);
  static void warning(dynamic message) => logWarning(message);
  static void error(dynamic message) => logError(message);
  static void fatal(dynamic message) => logFatal(message);
}



