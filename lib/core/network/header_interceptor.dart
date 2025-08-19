import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'network_config.dart';

/// Interceptor that adds basic headers to all HTTP requests
@injectable
class HeaderInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Add basic headers
    options.headers[NetworkConfig.contentTypeHeader] =
        NetworkConfig.defaultContentType;
    options.headers[NetworkConfig.acceptHeader] = NetworkConfig.defaultAccept;

    super.onRequest(options, handler);
  }
}
