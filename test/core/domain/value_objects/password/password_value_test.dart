import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:watchr/app/core/domain/value_objects/password/password_value.dart';
import 'package:watchr/app/core/value_object/value_object.dart';

class PasswordValue extends ValueObject<String, PasswordValueFailure> {
  @override
  final Either<PasswordValueFailure, String> value;

  const PasswordValue._(this.value);

  factory PasswordValue(String input) {
    final value = validatePassword(input);
    return PasswordValue._(value);
  }
}

class MockPasswordValueFailure extends Mock implements PasswordValueFailure {}

void main() {
  group('PasswordValue', () {
    late MockPasswordValueFailure mockFailure;

    setUp(() {
      mockFailure = MockPasswordValueFailure();
    });

    test('isValid returns true for a valid password', () {
      final validPasswordValue = PasswordValue('validPassword123');

      expect(validPasswordValue.isValid, isTrue);
    });

    test('isValid returns false for an invalid password', () {
      final invalidPasswordValue = PasswordValue('short');

      when(() => mockFailure.failedValue).thenReturn('short');

      expect(invalidPasswordValue.isValid, isFalse);
    });

    test('props contains the value', () {
      final passwordValue = PasswordValue('securePassword123');

      expect(passwordValue.props, [right('securePassword123')]);
    });

    test('stringify is true', () {
      final passwordValue = PasswordValue('password123');

      expect(passwordValue.stringify, isTrue);
    });
  });

  group('PasswordValueFailure', () {
    test('failedValue returns the correct value', () {
      const failure = PasswordValueFailure('weakPassword');

      expect(failure.failedValue, 'weakPassword');
    });
  });

  group('validatePassword', () {
    test('returns right for a valid password', () {
      final result = validatePassword('strongPassword123');

      expect(result, right('strongPassword123'));
    });
  });
}
