// lib/di/register_module.dart
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module // Marks this class as a source of dependencies
abstract class RegisterModule {
  @lazySingleton // Creates a single instance when first requested
  Dio get dio => Dio(); // Provides an instance of Dio
}