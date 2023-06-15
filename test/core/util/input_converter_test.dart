import 'package:clean_arch_tdd_course/core/either.dart';
import 'package:clean_arch_tdd_course/core/error/failures.dart';
import 'package:clean_arch_tdd_course/core/util/input_converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group('#stringToUnsignedInt', () {
    test(
        'should return an integer when the string represents an unsigned integer',
        () async {
      // arrange
      const string = '123';
      // act
      final result = inputConverter.stringToUnsignedInteger(string);
      // assert
      expect(result, equals(Right(123)));
    });

    test('should return a failure when the string is not an integer', () async {
      // arrange
      const string = 'abc';
      // act
      final result = inputConverter.stringToUnsignedInteger(string);
      // assert
      expect(result, equals(Left(InvalidInputFailure())));
    });

    test('should return a failure when the string is a negative integer',
        () async {
      // arrange
      const string = '-123';
      // act
      final result = inputConverter.stringToUnsignedInteger(string);
      // assert
      expect(result, equals(Left(InvalidInputFailure())));
    });
  });
}
