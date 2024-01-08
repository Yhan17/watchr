import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/domain/entities/watch_entity.dart';
import '../../../../core/domain/failures/failures.dart';
import '../../../../core/usecase/use_case.dart';
import '../service/watch_edit_service.dart';

class WatchEditUseCase
    extends UseCaseWithFailure<Failures, Unit, EditWatchParams> {
  final WatchEditService _service;

  WatchEditUseCase(this._service);

  @override
  Future<Either<Failures, Unit>> call(EditWatchParams params) async {
    return _service.editWatch(params.id, params.image, params.entity);
  }
}

class EditWatchParams {
  final String id;
  final File? image;
  final WatchEntity entity;

  EditWatchParams(
    this.id,
    this.image,
    this.entity,
  );
}
