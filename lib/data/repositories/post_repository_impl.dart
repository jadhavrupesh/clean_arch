import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../core/error/failures.dart';
import '../../domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';
import '../datasources/remote/api_service.dart';

// You might want a local data source interface here too for caching

class PostRepositoryImpl implements PostRepository {
  final ApiService remoteDataSource;
  // final NetworkInfo networkInfo; // Optional: To check connectivity
  // final PostLocalDataSource localDataSource; // Optional: For caching

  PostRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Post>>> getPosts() async {
    // Optional: Check network connection first
    // if (await networkInfo.isConnected) {
      try {
        final remotePosts = await remoteDataSource.getPosts();
        // Optionally cache the data here: localDataSource.cachePosts(remotePosts);
        // PostModel extends Post, so we can return List<PostModel> directly
        // If PostModel didn't extend Post, you would map here:
        // return Right(remotePosts.map((model) => model.toEntity()).toList());
        return Right(remotePosts);
      } on DioException catch (e) {
        // Handle Dio specific errors (e.g., timeouts, response errors)
        return Left(ServerFailure()); // More specific error handling is better
      } catch (e) {
        // Handle other errors
        return Left(ServerFailure());
      }
    // } else {
    //   // Optional: Try fetching from cache if offline
    //   try {
    //     final localPosts = await localDataSource.getLastPosts();
    //     return Right(localPosts);
    //   } on CacheException {
    //     return Left(CacheFailure());
    //   }
    // }
  }
} 