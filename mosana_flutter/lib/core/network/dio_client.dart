import 'package:dio/dio.dart';
import '../config/app_config.dart';
import '../services/storage_service.dart';
import '../utils/logger.dart';

/// HTTP client service using Dio
class DioClient {
  late final Dio _dio;
  final StorageService _storageService;

  DioClient(this._storageService) {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.apiBaseUrl,
        connectTimeout: Duration(milliseconds: AppConfig.apiTimeout),
        receiveTimeout: Duration(milliseconds: AppConfig.apiTimeout),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add interceptors
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: _onRequest,
        onResponse: _onResponse,
        onError: _onError,
      ),
    );
  }

  /// Get the Dio instance
  Dio get dio => _dio;

  /// Request interceptor - Add JWT token
  Future<void> _onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Add JWT token if available
    final token = await _storageService.getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    AppLogger.info(
      '🌐 REQUEST: ${options.method} ${options.path}\n'
      'Headers: ${options.headers}\n'
      'Body: ${options.data}',
    );

    handler.next(options);
  }

  /// Response interceptor - Log response
  void _onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    AppLogger.info(
      '✅ RESPONSE: ${response.statusCode} ${response.requestOptions.path}\n'
      'Data: ${response.data}',
    );

    handler.next(response);
  }

  /// Error interceptor - Handle errors
  Future<void> _onError(
    DioException error,
    ErrorInterceptorHandler handler,
  ) async {
    AppLogger.error(
      '❌ ERROR: ${error.requestOptions.method} ${error.requestOptions.path}\n'
      'Status Code: ${error.response?.statusCode}\n'
      'Message: ${error.message}\n'
      'Response: ${error.response?.data}',
    );

    // Handle 401 Unauthorized - Clear token and redirect to login
    if (error.response?.statusCode == 401) {
      AppLogger.warning('🔒 Unauthorized! Clearing auth data...');
      await _storageService.clearAuthData();
      // TODO: Trigger navigation to login screen
    }

    handler.next(error);
  }

  /// GET request
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      rethrow;
    }
  }

  /// POST request
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      rethrow;
    }
  }

  /// PUT request
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      rethrow;
    }
  }

  /// DELETE request
  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      rethrow;
    }
  }
}
