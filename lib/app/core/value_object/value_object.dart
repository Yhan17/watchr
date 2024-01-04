import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'value_failure.dart';

@immutable
abstract class ValueObject<ValueType, F extends ValueFailure<ValueType>>
    extends Equatable {
  const ValueObject();
  Either<F, ValueType> get value;

  bool get isValid => value.isRight();

  @override
  List<Object?> get props => [value];

  @override
  bool? get stringify => true;
}

