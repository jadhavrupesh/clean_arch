import 'package:flutter_test/flutter_test.dart';
import 'package:clean_arch/domain/entities/post.dart';

void main() {
  group('Post Entity', () {
    const tPost = Post(
      userId: 1,
      id: 1,
      title: 'Test Title',
      body: 'Test Body',
    );

    test('should be a subclass of Equatable', () {
      // assert
      expect(tPost, isA<Post>());
    });

    test('should have correct props for Equatable', () {
      // arrange
      const post1 = Post(
        userId: 1,
        id: 1,
        title: 'Test Title',
        body: 'Test Body',
      );
      const post2 = Post(
        userId: 1,
        id: 1,
        title: 'Test Title',
        body: 'Test Body',
      );
      const post3 = Post(
        userId: 2,
        id: 1,
        title: 'Test Title',
        body: 'Test Body',
      );

      // assert
      expect(post1, equals(post2));
      expect(post1, isNot(equals(post3)));
    });

    test('should return correct props', () {
      // assert
      expect(tPost.props, [1, 1, 'Test Title', 'Test Body']);
    });

    test('should create instance with required properties', () {
      // assert
      expect(tPost.userId, equals(1));
      expect(tPost.id, equals(1));
      expect(tPost.title, equals('Test Title'));
      expect(tPost.body, equals('Test Body'));
    });
  });
}
