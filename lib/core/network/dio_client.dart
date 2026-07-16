import 'package:dio/dio.dart';
import 'api_endpoints.dart';
import 'connectivity.dart';

/// Singleton Dio client with interceptors for auth token, logging, and errors.
class DioClient {
  DioClient._();
  static final DioClient instance = DioClient._();

  late final Dio _dio = _createDio();

  Dio get dio => _dio;

  // ── Factory ───────────────────────────────────────────────────────────────
  Dio _createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.addAll([
      _ConnectivityInterceptor(),
      _AuthInterceptor(),
      _LoggingInterceptor(),
      _ErrorInterceptor(),
    ]);

    return dio;
  }

  // ── Convenience methods ───────────────────────────────────────────────────
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.get<T>(path,
        queryParameters: queryParameters, options: options);
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Options? options,
  }) {
    return _dio.post<T>(path, data: data, options: options);
  }

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Options? options,
  }) {
    return _dio.put<T>(path, data: data, options: options);
  }

  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Options? options,
  }) {
    return _dio.delete<T>(path, data: data, options: options);
  }
}

// ── Auth Interceptor — attaches Bearer token ──────────────────────────────
class _AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: Load token from secure storage (e.g. flutter_secure_storage)
    const token = ''; // Replace with actual token read
    if (token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}

// ── Logging Interceptor — prints in debug mode only ───────────────────────
class _LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    assert(() {
      // ignore: avoid_print
      print('→ [${options.method}] ${options.uri}');
      if (options.data != null) print('   Body: ${options.data}');
      return true;
    }());
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    assert(() {
      // ignore: avoid_print
      print('← [${response.statusCode}] ${response.requestOptions.uri}');
      return true;
    }());
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    assert(() {
      // ignore: avoid_print
      print('✗ [${err.response?.statusCode}] ${err.requestOptions.uri}');
      // ignore: avoid_print
      print('  Message: ${err.message}');
      return true;
    }());
    handler.next(err);
  }
}

// ── Error Interceptor — normalizes API errors ─────────────────────────────
class _ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String message;

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        message = 'Connection timed out. Please check your internet.';
        break;
      case DioExceptionType.connectionError:
        message = 'No internet connection.';
        break;
      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode ?? 0;
        if (statusCode == 401) {
          message = 'Session expired. Please login again.';
          // TODO: Clear token and redirect to login
        } else if (statusCode == 403) {
          message = 'You do not have permission to do this.';
        } else if (statusCode >= 500) {
          message = 'Server error. Please try again later.';
        } else {
          message = err.response?.data?['message'] ?? 'Something went wrong.';
        }
        break;
      default:
        message = 'Unexpected error. Please try again.';
    }

    handler.next(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: message,
        message: message,
      ),
    );
  }
}

// ── Connectivity Interceptor — checks connection before requesting ────────
class _ConnectivityInterceptor extends Interceptor {
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final hasInternet = await ConnectivityService.instance.hasConnection();
    if (!hasInternet) {
      return handler.reject(
        DioException(
          requestOptions: options,
          type: DioExceptionType.connectionError,
          message: 'No internet connection.',
          error: 'No internet connection. Please check your network.',
        ),
      );
    }
    super.onRequest(options, handler);
  }
}
