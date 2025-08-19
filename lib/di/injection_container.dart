import 'package:clean_arch/di/injection_container.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

GetIt getIt = GetIt.instance;

@InjectableInit(initializerName: 'init') // Points to the generated function
Future<void> configureDependencies(String environment) async {
  // The generated 'init' function will be called here
  getIt.init(environment: environment);
}
