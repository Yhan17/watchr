import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/domain/entities/watch_entity.dart';
import '../../../../core/domain/failures/failures.dart';

abstract class WatchEditService {
  Future<Either<Failures, Unit>> editWatch(
    String id,
    File? image,
    WatchEntity entity,
  );
}
