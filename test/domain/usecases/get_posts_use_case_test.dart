import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:clean_arch/domain/entities/post.dart';
import 'package:clean_arch/domain/repositories/post_repository.dart';
import 'package:clean_arch/domain/usecases/get_posts_use_case.dart';
import 'package:clean_arch/core/usecases/usecase.dart';
import 'package:clean_arch/core/error/failures.dart';

import 'get_posts_use_case_test.mocks.dart';

@GenerateMocks([PostRepository])
void main() {
  late GetPostsUseCase usecase;
  late MockPostRepository mockPostRepository;

  setUp(() {
    mockPostRepository = MockPostRepository();
    usecase = GetPostsUseCase(mockPostRepository);
  });

  const tPostsList = [
    Post(userId: 1, id: 1, title: 'Test Title 1', body: 'Test Body 1'),
    Post(userId: 1, id: 2, title: 'Test Title 2', body: 'Test Body 2'),
  ];

  group('GetPostsUseCase', () {
    test('should get posts from the repository', () async {
      // arrange
      when(
        mockPostRepository.getPosts(),
      ).thenAnswer((_) async => const Right(tPostsList));

      // act
      final result = await usecase(NoParams());

      // assert
      expect(result, const Right(tPostsList));
      verify(mockPostRepository.getPosts());
      verifyNoMoreInteractions(mockPostRepository);
    });

    test('should return ServerFailure when repository fails', () async {
      // arrange
      when(
        mockPostRepository.getPosts(),
      ).thenAnswer((_) async => Left(ServerFailure()));

      // act
      final result = await usecase(NoParams());

      // assert
      expect(result, Left(ServerFailure()));
      verify(mockPostRepository.getPosts());
      verifyNoMoreInteractions(mockPostRepository);
    });

    test(
      'should return NetworkFailure when repository fails with network error',
      () async {
        // arrange
        when(
          mockPostRepository.getPosts(),
        ).thenAnswer((_) async => Left(NetworkFailure()));

        // act
        final result = await usecase(NoParams());

        // assert
        expect(result, Left(NetworkFailure()));
        verify(mockPostRepository.getPosts());
        verifyNoMoreInteractions(mockPostRepository);
      },
    );
  });
}
