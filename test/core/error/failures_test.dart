import 'package:flutter_test/flutter_test.dart';
import 'package:clean_arch/core/error/failures.dart';

void main() {
  group('Failures', () {
    group('ServerFailure', () {
      test('should be a subclass of Failure', () {
        // arrange
        final serverFailure = ServerFailure();

        // assert
        expect(serverFailure, isA<Failure>());
      });

      test('should have empty props', () {
        // arrange
        final serverFailure = ServerFailure();

        // assert
        expect(serverFailure.props, []);
      });

      test('should be equal to another ServerFailure', () {
        // arrange
        final serverFailure1 = ServerFailure();
        final serverFailure2 = ServerFailure();

        // assert
        expect(serverFailure1, equals(serverFailure2));
      });
    });

    group('CacheFailure', () {
      test('should be a subclass of Failure', () {
        // arrange
        final cacheFailure = CacheFailure();

        // assert
        expect(cacheFailure, isA<Failure>());
      });

      test('should have empty props', () {
        // arrange
        final cacheFailure = CacheFailure();

        // assert
        expect(cacheFailure.props, []);
      });

      test('should be equal to another CacheFailure', () {
        // arrange
        final cacheFailure1 = CacheFailure();
        final cacheFailure2 = CacheFailure();

        // assert
        expect(cacheFailure1, equals(cacheFailure2));
      });
    });

    group('NetworkFailure', () {
      test('should be a subclass of Failure', () {
        // arrange
        final networkFailure = NetworkFailure();

        // assert
        expect(networkFailure, isA<Failure>());
      });

      test('should have empty props', () {
        // arrange
        final networkFailure = NetworkFailure();

        // assert
        expect(networkFailure.props, []);
      });

      test('should be equal to another NetworkFailure', () {
        // arrange
        final networkFailure1 = NetworkFailure();
        final networkFailure2 = NetworkFailure();

        // assert
        expect(networkFailure1, equals(networkFailure2));
      });
    });

    test('different failure types should not be equal', () {
      // arrange
      final serverFailure = ServerFailure();
      final cacheFailure = CacheFailure();
      final networkFailure = NetworkFailure();

      // assert
      expect(serverFailure, isNot(equals(cacheFailure)));
      expect(serverFailure, isNot(equals(networkFailure)));
      expect(cacheFailure, isNot(equals(networkFailure)));
    });
  });
}
