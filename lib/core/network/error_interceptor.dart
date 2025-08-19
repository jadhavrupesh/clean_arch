import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../error/failures.dart';

/// Interceptor for handling HTTP errors and converting them to appropriate failures
@injectable
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Map to failure for potential future use
    _mapDioExceptionToFailure(err);

    // You can handle specific errors here
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        print('Timeout Error: ${err.message}');
        break;
      case DioExceptionType.badResponse:
        print(
          'Bad Response Error: ${err.response?.statusCode} - ${err.message}',
        );
        break;
      case DioExceptionType.connectionError:
        print('Connection Error: ${err.message}');
        break;
      case DioExceptionType.cancel:
        print('Request Cancelled: ${err.message}');
        break;
      case DioExceptionType.unknown:
        print('Unknown Error: ${err.message}');
        break;
      case DioExceptionType.badCertificate:
        print('Bad Certificate Error: ${err.message}');
        break;
    }

    // Pass the error to the next handler
    super.onError(err, handler);
  }

  /// Maps DioException to appropriate Failure types
  Failure _mapDioExceptionToFailure(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return NetworkFailure();
      case DioExceptionType.badResponse:
        if (dioException.response?.statusCode != null) {
          final statusCode = dioException.response!.statusCode!;
          if (statusCode >= 500) {
            return ServerFailure();
          } else if (statusCode >= 400) {
            return ServerFailure(); // Could create ClientFailure if needed
          }
        }
        return ServerFailure();
      case DioExceptionType.cancel:
        return NetworkFailure();
      case DioExceptionType.unknown:
      case DioExceptionType.badCertificate:
        return ServerFailure();
    }
  }
}
