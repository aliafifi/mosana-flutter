/// Custom exceptions for the application
class AppException implements Exception {
  final String message;
  final String? code;

  AppException(this.message, {this.code});

  @override
  String toString() => message;
}

class NetworkException extends AppException {
  NetworkException([String message = 'Network error occurred']) : super(message);
}

class ServerException extends AppException {
  ServerException([String message = 'Server error occurred']) : super(message);
}

class UnauthorizedException extends AppException {
  UnauthorizedException([String message = 'Unauthorized access']) : super(message);
}

class NotFoundException extends AppException {
  NotFoundException([String message = 'Resource not found']) : super(message);
}

class ValidationException extends AppException {
  ValidationException([String message = 'Validation failed']) : super(message);
}

class CacheException extends AppException {
  CacheException([String message = 'Cache error occurred']) : super(message);
}
