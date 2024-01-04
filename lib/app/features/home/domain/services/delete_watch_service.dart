import 'package:dartz/dartz.dart';

import '../../../../core/domain/entities/watch_entity.dart';
import '../../../../core/domain/failures/failures.dart';

abstract class DeleteWatchService {
  Future<Either<Failures, Unit>> deleteWatch(WatchEntity entity);
}
