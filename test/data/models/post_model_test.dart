import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:clean_arch/data/models/post_model.dart';
import 'package:clean_arch/domain/entities/post.dart';
import '../../fixtures/fixture_reader.dart';

void main() {
  const tPostModel = PostModel(
    userId: 1,
    id: 1,
    title:
        'sunt aut facere repellat provident occaecati excepturi optio reprehenderit',
    body:
        'quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto',
  );

  group('PostModel', () {
    test('should be a subclass of Post entity', () {
      // assert
      expect(tPostModel, isA<Post>());
    });

    group('fromJson', () {
      test('should return a valid model', () {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('posts_fixture.json'))[0];

        // act
        final result = PostModel.fromJson(jsonMap);

        // assert
        expect(result, tPostModel);
      });

      test('should handle all required fields', () {
        // arrange
        final Map<String, dynamic> jsonMap = {
          'userId': 1,
          'id': 1,
          'title': 'Test Title',
          'body': 'Test Body',
        };

        // act
        final result = PostModel.fromJson(jsonMap);

        // assert
        expect(result.userId, 1);
        expect(result.id, 1);
        expect(result.title, 'Test Title');
        expect(result.body, 'Test Body');
      });
    });

    group('toJson', () {
      test('should return a JSON map containing the proper data', () {
        // act
        final result = tPostModel.toJson();

        // assert
        final expectedJsonMap = {
          'userId': 1,
          'id': 1,
          'title':
              'sunt aut facere repellat provident occaecati excepturi optio reprehenderit',
          'body':
              'quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto',
        };
        expect(result, expectedJsonMap);
      });

      test(
        'should maintain data integrity during serialization round trip',
        () {
          // arrange
          final originalModel = tPostModel;

          // act
          final json = originalModel.toJson();
          final deserializedModel = PostModel.fromJson(json);

          // assert
          expect(deserializedModel, equals(originalModel));
        },
      );
    });

    group('equality', () {
      test('should be equal when all properties are the same', () {
        // arrange
        const model1 = PostModel(
          userId: 1,
          id: 1,
          title: 'Test Title',
          body: 'Test Body',
        );
        const model2 = PostModel(
          userId: 1,
          id: 1,
          title: 'Test Title',
          body: 'Test Body',
        );

        // assert
        expect(model1, equals(model2));
      });

      test('should not be equal when properties differ', () {
        // arrange
        const model1 = PostModel(
          userId: 1,
          id: 1,
          title: 'Test Title',
          body: 'Test Body',
        );
        const model2 = PostModel(
          userId: 2,
          id: 1,
          title: 'Test Title',
          body: 'Test Body',
        );

        // assert
        expect(model1, isNot(equals(model2)));
      });
    });
  });
}
