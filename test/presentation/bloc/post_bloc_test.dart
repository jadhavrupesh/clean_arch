import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:clean_arch/presentation/bloc/post_bloc.dart';
import 'package:clean_arch/domain/entities/post.dart';
import 'package:clean_arch/domain/usecases/get_posts_use_case.dart';
import 'package:clean_arch/core/error/failures.dart';
import 'package:clean_arch/core/usecases/usecase.dart';

import 'post_bloc_test.mocks.dart';

@GenerateMocks([GetPostsUseCase])
void main() {
  late PostBloc bloc;
  late MockGetPostsUseCase mockGetPostsUseCase;

  setUp(() {
    mockGetPostsUseCase = MockGetPostsUseCase();
    bloc = PostBloc(mockGetPostsUseCase);
  });

  const tPostsList = [
    Post(userId: 1, id: 1, title: 'Test Title 1', body: 'Test Body 1'),
    Post(userId: 1, id: 2, title: 'Test Title 2', body: 'Test Body 2'),
  ];

  group('PostBloc', () {
    test('initial state should be PostInitial', () {
      expect(bloc.state, equals(PostInitial()));
    });

    group('FetchPosts', () {
      blocTest<PostBloc, PostState>(
        'should emit [PostLoading, PostLoaded] when data is gotten successfully',
        build: () {
          when(
            mockGetPostsUseCase(any),
          ).thenAnswer((_) async => const Right(tPostsList));
          return bloc;
        },
        act: (bloc) => bloc.add(FetchPosts()),
        expect: () => [PostLoading(), const PostLoaded(posts: tPostsList)],
        verify: (_) {
          verify(mockGetPostsUseCase(NoParams()));
        },
      );

      blocTest<PostBloc, PostState>(
        'should emit [PostLoading, PostError] when getting data fails with ServerFailure',
        build: () {
          when(
            mockGetPostsUseCase(any),
          ).thenAnswer((_) async => Left(ServerFailure()));
          return bloc;
        },
        act: (bloc) => bloc.add(FetchPosts()),
        expect:
            () => [
              PostLoading(),
              const PostError(message: SERVER_FAILURE_MESSAGE),
            ],
        verify: (_) {
          verify(mockGetPostsUseCase(NoParams()));
        },
      );

      blocTest<PostBloc, PostState>(
        'should emit [PostLoading, PostError] when getting data fails with CacheFailure',
        build: () {
          when(
            mockGetPostsUseCase(any),
          ).thenAnswer((_) async => Left(CacheFailure()));
          return bloc;
        },
        act: (bloc) => bloc.add(FetchPosts()),
        expect:
            () => [
              PostLoading(),
              const PostError(message: CACHE_FAILURE_MESSAGE),
            ],
        verify: (_) {
          verify(mockGetPostsUseCase(NoParams()));
        },
      );

      blocTest<PostBloc, PostState>(
        'should emit [PostLoading, PostError] when getting data fails with NetworkFailure',
        build: () {
          when(
            mockGetPostsUseCase(any),
          ).thenAnswer((_) async => Left(NetworkFailure()));
          return bloc;
        },
        act: (bloc) => bloc.add(FetchPosts()),
        expect:
            () => [
              PostLoading(),
              const PostError(message: NETWORK_FAILURE_MESSAGE),
            ],
        verify: (_) {
          verify(mockGetPostsUseCase(NoParams()));
        },
      );

      blocTest<PostBloc, PostState>(
        'should emit [PostLoading, PostLoaded] with empty list when no posts are returned',
        build: () {
          when(
            mockGetPostsUseCase(any),
          ).thenAnswer((_) async => const Right([]));
          return bloc;
        },
        act: (bloc) => bloc.add(FetchPosts()),
        expect: () => [PostLoading(), const PostLoaded(posts: [])],
        verify: (_) {
          verify(mockGetPostsUseCase(NoParams()));
        },
      );
    });

    group('Event Equality', () {
      test('FetchPosts should be equal to another FetchPosts', () {
        expect(FetchPosts(), equals(FetchPosts()));
      });
    });
  });
}
