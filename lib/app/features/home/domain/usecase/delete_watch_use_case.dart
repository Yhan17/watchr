import 'package:dartz/dartz.dart';

import '../../../../core/domain/entities/watch_entity.dart';
import '../../../../core/domain/failures/failures.dart';
import '../../../../core/usecase/use_case.dart';
import '../services/delete_watch_service.dart';

class DeleteWatchUseCase
    extends UseCaseWithFailure<Failures, Unit, WatchEntity> {
  final DeleteWatchService _service;

  const DeleteWatchUseCase(this._service);

  @override
  Future<Either<Failures, Unit>> call(WatchEntity params) async {
    return _service.deleteWatch(params);
  }
}
