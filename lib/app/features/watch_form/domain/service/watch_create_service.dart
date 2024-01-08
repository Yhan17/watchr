import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/domain/entities/watch_entity.dart';
import '../../../../core/domain/failures/failures.dart';

abstract class WatchCreateService {
  Future<Either<Failures, Unit>> saveWatchInFirestore(
    WatchEntity entity,
    File image,
  );
}
