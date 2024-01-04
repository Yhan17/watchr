import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:watchr/app/core/value_object/value_failure.dart';
import 'package:watchr/app/core/value_object/value_object.dart';

class TestValue extends ValueObject<String, TestValueFailure> {
  @override
  final Either<TestValueFailure, String> value;

  const TestValue(this.value);

  @override
  bool? get stringify => true;
}

class TestValueFailure extends ValueFailure<String> {
  @override
  final String failedValue;

  const TestValueFailure(this.failedValue);
}

class MockValueFailure extends Mock implements TestValueFailure {}

void main() {
  group('ValueObject', () {
    late MockValueFailure mockFailure;

    setUp(() {
      mockFailure = MockValueFailure();
    });

    test('isValid returns true for a valid value', () {
      final validValueObject = TestValue(right('valid'));

      expect(validValueObject.isValid, isTrue);
    });

    test('isValid returns false for an invalid value', () {
      final invalidValueObject = TestValue(left(mockFailure));

      when(() => mockFailure.failedValue).thenReturn('invalid');

      expect(invalidValueObject.isValid, isFalse);
    });

    test('props contains the value', () {
      final valueObject = TestValue(right('test'));

      expect(valueObject.props, [right('test')]);
    });

    test('stringify is true', () {
      final valueObject = TestValue(right('test'));

      expect(valueObject.stringify, isTrue);
    });
  });

  group('ValueFailure', () {
    test('failedValue returns the correct value', () {
      const failure =  TestValueFailure('error');

      expect(failure.failedValue, 'error');
    });
  });
}
