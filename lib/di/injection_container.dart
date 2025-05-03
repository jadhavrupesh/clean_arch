import 'package:clean_arch/di/injection_container.config.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

GetIt getIt = GetIt.instance;

@InjectableInit(initializerName: 'init') // Points to the generated function
Future<void> configureDependencies(String environment) async {
  // The generated 'init' function will be called here
  getIt.init(environment: environment);
}


//
// Future<void> init() async {
//   // Features - Posts
//
//   // Bloc
//   sl.registerFactory(
//     () => PostBloc(
//       getPosts: sl(),
//     ),
//   );
//
//   // Use cases
//   sl.registerLazySingleton(() => GetPosts(sl()));
//
//   // Repository
//   sl.registerLazySingleton<PostRepository>(
//     () => PostRepositoryImpl(
//       remoteDataSource: sl(),
//       // localDataSource: sl(), // Add if using local data source
//       // networkInfo: sl(), // Add if using network info
//     ),
//   );
//
//   // Data sources
//   sl.registerLazySingleton<ApiService>(
//     () => ApiService(sl()),
//   );
//
//   // sl.registerLazySingleton<PostLocalDataSource>(
//   //   () => PostLocalDataSourceImpl(sharedPreferences: sl()),
//   // ); // Add if using local data source
//
//   //! Core
//   // sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl())); // Add if using network info
//
//   //! External
//   // final sharedPreferences = await SharedPreferences.getInstance(); // Add if using shared prefs
//   // sl.registerLazySingleton(() => sharedPreferences);
//   sl.registerLazySingleton(() => Dio());
//   // sl.registerLazySingleton(() => DataConnectionChecker()); // Add if using network info
// }