// lib/di/register_module.dart
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../core/network/network_config.dart';
import '../core/network/header_interceptor.dart';
import '../core/network/error_interceptor.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  Dio dio(
    HeaderInterceptor headerInterceptor,
    ErrorInterceptor errorInterceptor,
  ) {
    final dio = Dio(
      BaseOptions(
        baseUrl: NetworkConfig.baseUrl,
        connectTimeout: const Duration(
          milliseconds: NetworkConfig.connectTimeout,
        ),
        receiveTimeout: const Duration(
          milliseconds: NetworkConfig.receiveTimeout,
        ),
        sendTimeout: const Duration(milliseconds: NetworkConfig.sendTimeout),
        headers: const {
          NetworkConfig.contentTypeHeader: NetworkConfig.defaultContentType,
          NetworkConfig.acceptHeader: NetworkConfig.defaultAccept,
        },
      ),
    );

    dio.interceptors.addAll([
      headerInterceptor,
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
      errorInterceptor,
    ]);

    return dio;
  }
}
