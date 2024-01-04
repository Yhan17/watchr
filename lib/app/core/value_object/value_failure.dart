import 'package:flutter/foundation.dart';

@immutable
abstract class ValueFailure<T> {
  const ValueFailure();
  T get failedValue;
}
