import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/domain/entities/watch_entity.dart';
import '../../../../core/domain/failures/failures.dart';
import '../../../../core/infra/dtos/watch_dto.dart';
import '../../../../core/infra/firebase/extensions/collections_extension.dart';
import '../../../../core/infra/firebase/watch_storage.dart';
import '../../domain/service/watch_create_service.dart';

class WatchCreateServiceImpl implements WatchCreateService {
  final FirebaseFirestore _firebaseFirestore;
  final WatchStorage _watchStorage;
  final Uuid _uuid;
  const WatchCreateServiceImpl(
    this._firebaseFirestore,
    this._watchStorage,
    this._uuid,
  );
  @override
  Future<Either<Failures, Unit>> saveWatchInFirestore(
    WatchEntity entity,
    File file,
  ) async {
    try {
      final uuid = _uuid.v4();

      var dto = WatchDto.fromEntity(entity);

      final path = await _watchStorage.uploadImage(
        uuid: uuid,
        image: file,
      );

      dto = dto.copyWith(
        id: uuid,
        imageStoragePath: path,
      );

      await _firebaseFirestore.watchesReference.doc(uuid).set(dto.toMap());

      return right(unit);
    } catch (_) {
      return left(Failures.unknown);
    }
  }
}
