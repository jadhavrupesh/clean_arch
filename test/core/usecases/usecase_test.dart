import 'package:flutter_test/flutter_test.dart';
import 'package:clean_arch/core/usecases/usecase.dart';

void main() {
  group('NoParams', () {
    test('should be a subclass of Equatable', () {
      // arrange
      final noParams = NoParams();

      // assert
      expect(noParams, isA<NoParams>());
    });

    test('should have empty props for Equatable', () {
      // arrange
      final noParams = NoParams();

      // assert
      expect(noParams.props, []);
    });

    test('should be equal to another NoParams instance', () {
      // arrange
      final noParams1 = NoParams();
      final noParams2 = NoParams();

      // assert
      expect(noParams1, equals(noParams2));
    });

    test('should have the same hashCode for equal instances', () {
      // arrange
      final noParams1 = NoParams();
      final noParams2 = NoParams();

      // assert
      expect(noParams1.hashCode, equals(noParams2.hashCode));
    });
  });
}
