import 'package:injectable/injectable.dart';

@injectable
class NetworkConfig {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  static const int connectTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds
  static const int sendTimeout = 30000; // 30 seconds

  // Header keys
  static const String contentTypeHeader = 'Content-Type';
  static const String acceptHeader = 'Accept';

  // Default header values
  static const String defaultContentType = 'application/json';
  static const String defaultAccept = 'application/json';
}
