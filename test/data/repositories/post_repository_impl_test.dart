import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:clean_arch/data/repositories/post_repository_impl.dart';
import 'package:clean_arch/data/datasources/remote/api_service.dart';
import 'package:clean_arch/data/models/post_model.dart';
import 'package:clean_arch/domain/entities/post.dart';
import 'package:clean_arch/core/error/failures.dart';

import 'post_repository_impl_test.mocks.dart';

@GenerateMocks([ApiService])
void main() {
  late PostRepositoryImpl repository;
  late MockApiService mockApiService;

  setUp(() {
    mockApiService = MockApiService();
    repository = PostRepositoryImpl(remoteDataSource: mockApiService);
  });

  group('PostRepositoryImpl', () {
    const tPostModelList = [
      PostModel(userId: 1, id: 1, title: 'Test Title 1', body: 'Test Body 1'),
      PostModel(userId: 1, id: 2, title: 'Test Title 2', body: 'Test Body 2'),
    ];

    const List<Post> tPostList = tPostModelList;

    group('getPosts', () {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(
            mockApiService.getPosts(),
          ).thenAnswer((_) async => tPostModelList);

          // act
          final result = await repository.getPosts();

          // assert
          verify(mockApiService.getPosts());
          expect(result, equals(const Right(tPostList)));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockApiService.getPosts()).thenThrow(
            DioException(
              response: Response(
                statusCode: 500,
                requestOptions: RequestOptions(path: '/posts'),
              ),
              requestOptions: RequestOptions(path: '/posts'),
            ),
          );

          // act
          final result = await repository.getPosts();

          // assert
          verify(mockApiService.getPosts());
          expect(result, equals(Left(ServerFailure())));
        },
      );

      test(
        'should return network failure when there is a connection error',
        () async {
          // arrange
          when(mockApiService.getPosts()).thenThrow(
            DioException(
              type: DioExceptionType.connectionTimeout,
              requestOptions: RequestOptions(path: '/posts'),
            ),
          );

          // act
          final result = await repository.getPosts();

          // assert
          verify(mockApiService.getPosts());
          expect(result, equals(Left(NetworkFailure())));
        },
      );

      test(
        'should return network failure when there is a connection error (receiveTimeout)',
        () async {
          // arrange
          when(mockApiService.getPosts()).thenThrow(
            DioException(
              type: DioExceptionType.receiveTimeout,
              requestOptions: RequestOptions(path: '/posts'),
            ),
          );

          // act
          final result = await repository.getPosts();

          // assert
          verify(mockApiService.getPosts());
          expect(result, equals(Left(NetworkFailure())));
        },
      );

      test('should return server failure when there is a 404 error', () async {
        // arrange
        when(mockApiService.getPosts()).thenThrow(
          DioException(
            response: Response(
              statusCode: 404,
              requestOptions: RequestOptions(path: '/posts'),
            ),
            requestOptions: RequestOptions(path: '/posts'),
          ),
        );

        // act
        final result = await repository.getPosts();

        // assert
        verify(mockApiService.getPosts());
        expect(result, equals(Left(ServerFailure())));
      });

      test('should return server failure for any other DioException', () async {
        // arrange
        when(mockApiService.getPosts()).thenThrow(
          DioException(
            type: DioExceptionType.unknown,
            requestOptions: RequestOptions(path: '/posts'),
          ),
        );

        // act
        final result = await repository.getPosts();

        // assert
        verify(mockApiService.getPosts());
        expect(result, equals(Left(ServerFailure())));
      });

      test(
        'should return empty list when API returns empty response',
        () async {
          // arrange
          when(mockApiService.getPosts()).thenAnswer((_) async => []);

          // act
          final result = await repository.getPosts();

          // assert
          verify(mockApiService.getPosts());
          expect(result, equals(const Right<Failure, List<Post>>([])));
        },
      );
    });
  });
}
