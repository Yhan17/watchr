import 'package:dartz/dartz.dart';

import '../../../value_object/value_failure.dart';
import '../../../value_object/value_object.dart';

class PasswordValue extends ValueObject<String, PasswordValueFailure> {
  @override
  final Either<PasswordValueFailure, String> value;
  
  const PasswordValue._(this.value);

  factory PasswordValue(String input) {
    final value = validatePassword(input);
    return PasswordValue._(value);
  }
}

class PasswordValueFailure extends ValueFailure<String> {
  @override
  final String failedValue;

  const PasswordValueFailure(this.failedValue);
}

Either<PasswordValueFailure, String> validatePassword(String input) {
  if (input.length >= 6) {
    return right(input);
  } else {
    return left(PasswordValueFailure(input));
  }
}
