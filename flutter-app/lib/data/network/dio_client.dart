import 'package:dio/dio.dart';

import 'package:nexus/data/network/api_endpoints.dart';
import 'package:nexus/domain/repositories/auth_repository.dart';

Dio createDioClient(AuthRepository authRepository) {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: const <String, String>{'Accept': 'application/json'},
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        if (authRepository.pendingEmail case final String email) {
          options.headers['X-Mock-User'] = email;
        }
        handler.next(options);
      },
      onError: (DioException error, ErrorInterceptorHandler handler) {
        handler.next(
          DioException(
            requestOptions: error.requestOptions,
            error: error.error ?? 'Network request failed',
            message: error.message ?? 'Unknown request error',
          ),
        );
      },
    ),
  );

  return dio;
}
