import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/domain/entities/watch_entity.dart';
import '../../../../core/domain/failures/failures.dart';
import '../../../../core/usecase/use_case.dart';
import '../service/watch_create_service.dart';

class WatchCreateUseCase
    extends UseCaseWithFailure<Failures, Unit, WatchCreateParams> {
  final WatchCreateService _service;

  WatchCreateUseCase(this._service);
  @override
  Future<Either<Failures, Unit>> call(WatchCreateParams params) {
    return _service.saveWatchInFirestore(
      params.entity,
      params.file,
    );
  }
}

class WatchCreateParams {
  final WatchEntity entity;
  final File file;

  WatchCreateParams({
    required this.entity,
    required this.file,
  });
}
