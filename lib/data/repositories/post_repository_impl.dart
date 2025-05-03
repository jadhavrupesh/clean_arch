import 'package:clean_arch/core/error/failures.dart'; // Imports custom Failure types
import 'package:clean_arch/data/datasources/remote/api_service.dart'; // Imports the remote data source interface (ApiService)
import 'package:clean_arch/domain/entities/post.dart'; // Imports the domain entity (Post)
import 'package:clean_arch/domain/repositories/post_repository.dart'; // Imports the domain repository interface
import 'package:dartz/dartz.dart'; // Imports the dartz package for functional programming (Either type)
import 'package:dio/dio.dart'; // Imports Dio for handling HTTP exceptions
import 'package:injectable/injectable.dart'; // Imports injectable for dependency injection annotations

// Optional: Define interfaces for local data source and network info if needed
// import '../datasources/local/post_local_data_source.dart';
// import '../../core/platform/network_info.dart';

/// Implementation of the [PostRepository] interface defined in the domain layer.
///
/// This class is responsible for coordinating data retrieval from different sources
/// (currently only remote). It handles potential errors and returns either a [Failure]
/// or the requested data ([List<Post>]) wrapped in an [Either].
///
/// It's marked with `@Injectable(as: PostRepository)` which tells the `injectable`
/// generator to register this class as the concrete implementation for the
/// `PostRepository` abstract class/interface. `injectable` will automatically
/// inject the required dependencies (like `ApiService`) listed in the constructor.
// lib/data/repositories/post_repository_impl.dart
@Injectable(as: PostRepository) // Register this as the implementation for PostRepository
class PostRepositoryImpl implements PostRepository {
  /// The remote data source responsible for fetching data from the API.
  final ApiService remoteDataSource;

  // Optional: Inject NetworkInfo to check connectivity before making API calls
  // final NetworkInfo networkInfo;

  // Optional: Inject a local data source for caching data
  // final PostLocalDataSource localDataSource;

  /// Constructor for [PostRepositoryImpl].
  ///
  /// Dependencies listed here (like [remoteDataSource]) will be injected by `get_it`
  /// based on the `@injectable` configuration.
  PostRepositoryImpl({
    required this.remoteDataSource,
    // required this.networkInfo, // Uncomment if using NetworkInfo
    // required this.localDataSource, // Uncomment if using localDataSource
  });

  /// Fetches a list of posts.
  ///
  /// It attempts to retrieve posts from the [remoteDataSource].
  /// If successful, it returns a [Right] containing the [List<Post>].
  /// If an error occurs (e.g., network error, server error), it catches the
  /// exception and returns a [Left] containing a specific [Failure] type.
  ///
  /// Currently, it directly calls the remote source. Optional logic for checking
  /// network connectivity and falling back to a local cache is commented out.
  @override
  Future<Either<Failure, List<Post>>> getPosts() async {
    // Optional: Check network connection first using NetworkInfo
    // if (await networkInfo.isConnected) {
    try {
      // Fetch posts from the remote API using the injected ApiService
      final remotePosts = await remoteDataSource.getPosts();

      // Optional: Cache the fetched data using the localDataSource
      // await localDataSource.cachePosts(remotePosts);

      // Since PostModel extends Post, we can return the list directly.
      // If PostModel didn't extend Post, you would map models to entities here:
      // return Right(remotePosts.map((model) => model.toEntity()).toList());
      return Right(remotePosts);
    } on DioException catch (e) {
      // Handle Dio specific errors (like timeouts, connection errors, 4xx/5xx responses)
      // You could add more specific error mapping based on e.type or e.response?.statusCode
      print('DioError fetching posts: ${e.message}'); // Logging the error is helpful
      return Left(ServerFailure()); // Return a generic ServerFailure
    } catch (e) {
      // Handle any other unexpected errors during the process
      print('Unexpected error fetching posts: $e'); // Log unexpected errors
      return Left(ServerFailure()); // Return a generic ServerFailure
    }
    // } else {
    //   // Optional: Handle offline case - try fetching from cache
    //   try {
    //     final localPosts = await localDataSource.getLastPosts();
    //     return Right(localPosts); // Return cached posts if available
    //   } on CacheException {
    //     // Handle error if cache is empty or fails
    //     return Left(CacheFailure());
    //   } catch (e) {
    //     // Handle any other unexpected errors during cache retrieval
    //     print('Unexpected error fetching posts from cache: $e');
    //     return Left(CacheFailure());
    //   }
    // }
  }
}
