import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/domain/entities/watch_entity.dart';
import '../../../../core/domain/failures/failures.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/infra/firebase/extensions/collections_extension.dart';
import '../../domain/services/delete_watch_service.dart';

class DeleteWatchServiceImpl implements DeleteWatchService {
  final FirebaseFirestore _firestore;

  const DeleteWatchServiceImpl(this._firestore);
  @override
  Future<Either<Failures, Unit>> deleteWatch(WatchEntity entity) async {
    try {
      await _firestore.watchesReference.doc(entity.id).delete();
      return right(unit);
    } catch (_) {
      return left(Failures.unknown);
    }
  }
}
