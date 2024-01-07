import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/domain/entities/watch_entity.dart';
import '../../../../core/domain/failures/failures.dart';
import '../../../../core/infra/dtos/watch_dto.dart';
import '../../../../core/infra/firebase/extensions/collections_extension.dart';
import '../../domain/services/watches_service.dart';

class WatchesServiceImpl extends WatchesService {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  WatchesServiceImpl(
    this._firebaseAuth,
    this._firestore,
  );

  @override
  Stream<Either<Failures, List<WatchEntity>>> listWatches() async* {
    final user = _firebaseAuth.currentUser!;
    yield* _firestore.watchesReference
        .where('user_id', isEqualTo: user.uid)
        .snapshots()
        .map(
          (snapshot) => right<Failures, List<WatchEntity>>(
            snapshot.docs
                .map(
                  (doc) => WatchDto.fromMap(doc.data()).toEntity(),
                )
                .toList(),
          ),
        )
        .onErrorReturnWith((_, __) {
      return left<Failures, List<WatchEntity>>(Failures.serviceFailure);
    });
  }
}
