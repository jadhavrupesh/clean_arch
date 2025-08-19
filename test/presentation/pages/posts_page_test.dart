import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:clean_arch/presentation/pages/posts_page.dart';
import 'package:clean_arch/presentation/bloc/post_bloc.dart';
import 'package:clean_arch/domain/entities/post.dart';

import 'posts_page_test.mocks.dart';

@GenerateMocks([PostBloc])
void main() {
  late MockPostBloc mockPostBloc;

  setUp(() {
    mockPostBloc = MockPostBloc();
  });

  const tPostsList = [
    Post(userId: 1, id: 1, title: 'Test Title 1', body: 'Test Body 1'),
    Post(userId: 1, id: 2, title: 'Test Title 2', body: 'Test Body 2'),
  ];

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<PostBloc>(
        create: (context) => mockPostBloc,
        child: const PostsPage(),
      ),
    );
  }

  group('PostsPage Widget Tests', () {
    testWidgets('should show loading indicator when state is PostLoading', (
      WidgetTester tester,
    ) async {
      // arrange
      when(mockPostBloc.state).thenReturn(PostLoading());
      when(
        mockPostBloc.stream,
      ).thenAnswer((_) => Stream.fromIterable([PostLoading()]));

      // act
      await tester.pumpWidget(createWidgetUnderTest());

      // assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should show error message when state is PostError', (
      WidgetTester tester,
    ) async {
      // arrange
      const errorMessage = 'Something went wrong';
      when(
        mockPostBloc.state,
      ).thenReturn(const PostError(message: errorMessage));
      when(mockPostBloc.stream).thenAnswer(
        (_) => Stream.fromIterable([const PostError(message: errorMessage)]),
      );

      // act
      await tester.pumpWidget(createWidgetUnderTest());

      // assert
      expect(find.text(errorMessage), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('should show posts list when state is PostLoaded', (
      WidgetTester tester,
    ) async {
      // arrange
      when(mockPostBloc.state).thenReturn(const PostLoaded(posts: tPostsList));
      when(mockPostBloc.stream).thenAnswer(
        (_) => Stream.fromIterable([const PostLoaded(posts: tPostsList)]),
      );

      // act
      await tester.pumpWidget(createWidgetUnderTest());

      // assert
      expect(find.byType(ListView), findsOneWidget);
      expect(find.text('Test Title 1'), findsOneWidget);
      expect(find.text('Test Title 2'), findsOneWidget);
      expect(find.text('Test Body 1'), findsOneWidget);
      expect(find.text('Test Body 2'), findsOneWidget);
    });

    testWidgets('should show empty message when no posts are loaded', (
      WidgetTester tester,
    ) async {
      // arrange
      when(mockPostBloc.state).thenReturn(const PostLoaded(posts: []));
      when(
        mockPostBloc.stream,
      ).thenAnswer((_) => Stream.fromIterable([const PostLoaded(posts: [])]));

      // act
      await tester.pumpWidget(createWidgetUnderTest());

      // assert
      expect(find.text('No posts available'), findsOneWidget);
      expect(find.byType(ListView), findsNothing);
    });

    testWidgets(
      'should trigger FetchPosts event when refresh button is tapped',
      (WidgetTester tester) async {
        // arrange
        when(
          mockPostBloc.state,
        ).thenReturn(const PostLoaded(posts: tPostsList));
        when(mockPostBloc.stream).thenAnswer(
          (_) => Stream.fromIterable([const PostLoaded(posts: tPostsList)]),
        );

        // act
        await tester.pumpWidget(createWidgetUnderTest());

        // Find and tap the refresh button
        final refreshButton = find.byIcon(Icons.refresh);
        expect(refreshButton, findsOneWidget);
        await tester.tap(refreshButton);

        // assert
        verify(mockPostBloc.add(any)).called(1);
      },
    );

    testWidgets('should have correct app bar title', (
      WidgetTester tester,
    ) async {
      // arrange
      when(mockPostBloc.state).thenReturn(PostInitial());
      when(
        mockPostBloc.stream,
      ).thenAnswer((_) => Stream.fromIterable([PostInitial()]));

      // act
      await tester.pumpWidget(createWidgetUnderTest());

      // assert
      expect(find.text('Posts'), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('should display posts in cards', (WidgetTester tester) async {
      // arrange
      when(mockPostBloc.state).thenReturn(const PostLoaded(posts: tPostsList));
      when(mockPostBloc.stream).thenAnswer(
        (_) => Stream.fromIterable([const PostLoaded(posts: tPostsList)]),
      );

      // act
      await tester.pumpWidget(createWidgetUnderTest());

      // assert
      expect(find.byType(Card), findsNWidgets(2));
    });

    testWidgets('should show initial state correctly', (
      WidgetTester tester,
    ) async {
      // arrange
      when(mockPostBloc.state).thenReturn(PostInitial());
      when(
        mockPostBloc.stream,
      ).thenAnswer((_) => Stream.fromIterable([PostInitial()]));

      // act
      await tester.pumpWidget(createWidgetUnderTest());

      // assert
      expect(
        find.byType(SizedBox),
        findsWidgets,
      ); // Empty container for initial state
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });
  });
}
