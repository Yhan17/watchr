import 'package:dartz/dartz.dart';

import '../../../value_object/value_failure.dart';
import '../../../value_object/value_object.dart';

class EmailAddressValue extends ValueObject<String, EmailAddressValueFailure> {
  @override
  final Either<EmailAddressValueFailure, String> value;
  const EmailAddressValue._(this.value);

  factory EmailAddressValue(String input) {
    final value = validateEmailAddress(input);
    return EmailAddressValue._(value);
  }
}

class EmailAddressValueFailure extends ValueFailure<String> {
  @override
  final String failedValue;
  const EmailAddressValueFailure(this.failedValue);
}

Either<EmailAddressValueFailure, String> validateEmailAddress(String input) {
  const emailRegex = r'''^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$''';
  if (RegExp(emailRegex).hasMatch(input)) {
    return right(input);
  } else {
    return left(EmailAddressValueFailure(input));
  }
}
