import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/domain/entities/watch_entity.dart';

part 'watch_form_state.freezed.dart';

@freezed
abstract class WatchFormState with _$WatchFormState {
  const WatchFormState._();
  factory WatchFormState({
    required File? image,
    required String? name,
    required String? code,
    required String? desc,
    required String? quantity,
    required String? price,
    required WatchEntity? editEntity,
  }) = _WatchFormState;

  factory WatchFormState.initial() => WatchFormState(
        image: null,
        name: null,
        desc: null,
        code: null,
        quantity: null,
        price: null,
        editEntity: null
      );

  bool get imageCanContinue => image != null;
  bool get nameCanContinue => name != null && desc != null;
  bool get canSubmit =>
      quantity != null &&
      price != null &&
      code != null &&
      nameCanContinue;
}
