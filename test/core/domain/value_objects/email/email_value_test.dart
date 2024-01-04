import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:watchr/app/core/domain/value_objects/email_address/email_address_value.dart';
import 'package:watchr/app/core/value_object/value_object.dart';

class EmailAddressValue extends ValueObject<String, EmailAddressValueFailure> {
  @override
  final Either<EmailAddressValueFailure, String> value;
  const EmailAddressValue._(this.value);

  factory EmailAddressValue(String input) {
    final value = validateEmailAddress(input);
    return EmailAddressValue._(value);
  }
}

class MockEmailAddressValueFailure extends Mock
    implements EmailAddressValueFailure {}

void main() {
  group('EmailAddressValue', () {
    late MockEmailAddressValueFailure mockFailure;

    setUp(() {
      mockFailure = MockEmailAddressValueFailure();
    });

    test('isValid returns true for a valid email address', () {
      final validEmailAddressValue = EmailAddressValue('test@example.com');

      expect(validEmailAddressValue.isValid, isTrue);
    });

    test('isValid returns false for an invalid email address', () {
      final invalidEmailAddressValue = EmailAddressValue('invalidEmail');

      when(() => mockFailure.failedValue).thenReturn('invalidEmail');

      expect(invalidEmailAddressValue.isValid, isFalse);
    });

    test('props contains the value', () {
      final emailAddressValue = EmailAddressValue('user@example.com');

      expect(emailAddressValue.props, [right('user@example.com')]);
    });

    test('stringify is true', () {
      final emailAddressValue = EmailAddressValue('test@example.com');

      expect(emailAddressValue.stringify, isTrue);
    });
  });

  group('EmailAddressValueFailure', () {
    test('failedValue returns the correct value', () {
      const failure = EmailAddressValueFailure('invalidEmail');

      expect(failure.failedValue, 'invalidEmail');
    });
  });
}
