import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/domain/entities/watch_entity.dart';
import '../../../../core/domain/failures/failures.dart';
import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/infra/dtos/watch_dto.dart';
import '../../../../core/infra/firebase/extensions/collections_extension.dart';
import '../../../../core/infra/firebase/watch_storage.dart';
import '../../domain/service/watch_edit_service.dart';

class WatchEditServiceImpl implements WatchEditService {
  final FirebaseFirestore _firebaseFirestore;
  final WatchStorage _watchStorage;

  WatchEditServiceImpl(this._firebaseFirestore, this._watchStorage);
  @override
  Future<Either<Failures, Unit>> editWatch(
    String id,
    File? image,
    WatchEntity entity,
  ) async {
    try {
      var dto = WatchDto.fromEntity(entity);
      if (image != null) {
        await _watchStorage.deleteImage(id);
        final path = await _watchStorage.uploadImage(
          uuid: id,
          image: image,
        );
        dto = dto.copyWith(
          imageStoragePath: path,
        );
      }

      await _firebaseFirestore.watchesReference.doc(id).update(dto.toMap());

      return right(unit);
    } catch (_) {
      return left(Failures.unknown);
    }
  }
}
