// ignore_for_file: subtype_of_sealed_class

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:watchr/app/core/domain/entities/watch_entity.dart';
import 'package:watchr/app/core/domain/failures/failures.dart';
import 'package:watchr/app/features/home/infra/service/watches_service_impl.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockWatchesServiceImpl extends Mock implements WatchesServiceImpl {}

class MockUser extends Mock implements User {}

class MockQuerySnapshot extends Mock
    implements QuerySnapshot<Map<String, dynamic>> {}

class MockQueryDocumentSnapshot extends Mock
    implements QueryDocumentSnapshot<Map<String, dynamic>> {}

class MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

class MockQuery extends Mock implements Query<Map<String, dynamic>> {}

class MockStreamSnapshot extends Mock
    implements Stream<QuerySnapshot<Map<String, dynamic>>> {}

class MockStreamSubscription extends Mock implements StreamSubscription {}

class MockStreamMap extends Mock
    implements Stream<Either<Failures, List<WatchEntity>>> {}

void main() {
  group('WatchesServiceImpl', () {
    late WatchesServiceImpl watchesService;
    late MockFirebaseAuth mockFirebaseAuth;
    late MockFirebaseFirestore mockFirestore;
    late MockCollectionReference mockCollectionReference;
    late MockQuery mockQuery;

    setUp(() {
      mockFirebaseAuth = MockFirebaseAuth();
      mockFirestore = MockFirebaseFirestore();
      watchesService = WatchesServiceImpl(mockFirebaseAuth, mockFirestore);
      mockCollectionReference = MockCollectionReference();
      mockQuery = MockQuery();
    });

    test('listWatches returns a stream of watches on successful call',
        () async {
      final mockUser = MockUser();
      when(() => mockFirebaseAuth.currentUser).thenReturn(mockUser);
      when(() => mockUser.uid).thenReturn('user_id');

      when(() => mockFirestore.collection('watches'))
          .thenReturn(mockCollectionReference);
      when(() => mockCollectionReference.where('user_id', isEqualTo: 'user_id'))
          .thenReturn(mockQuery);
      when(() => mockQuery.snapshots()).thenAnswer((_) {
        final controller =
            StreamController<QuerySnapshot<Map<String, dynamic>>>();

        final mockDocumentSnapshot1 = MockQueryDocumentSnapshot();
        when(() => mockDocumentSnapshot1.data()).thenReturn({
          'id': '1',
          'name': 'Watch 1',
          'description': 'Description 1',
          'price': 199.99,
          'stock_quantity': 10,
          'code': 'W1',
          'image_storage_path': 'path1',
          'user_id': 'user1',
          'created_at': DateTime.now().toString(),
          'updated_at': DateTime.now().toString(),
        });
        final querySnapshot1 = MockQuerySnapshot();
        when(() => querySnapshot1.docs).thenReturn([mockDocumentSnapshot1]);
        controller.add(querySnapshot1);

        final mockDocumentSnapshot2 = MockQueryDocumentSnapshot();
        when(() => mockDocumentSnapshot2.data()).thenReturn({
          'id': '2',
          'name': 'Watch 2',
          'description': 'Description 2',
          'price': 149.99,
          'stock_quantity': 15,
          'code': 'W2',
          'image_storage_path': 'path2',
          'user_id': 'user2',
          'created_at': DateTime.now().toString(),
          'updated_at': DateTime.now().toString(),
        });
        final querySnapshot2 = MockQuerySnapshot();
        when(() => querySnapshot2.docs).thenReturn([mockDocumentSnapshot2]);
        controller.add(querySnapshot2);
        return controller.stream;
      });

      final controller =
          StreamController<Either<Failures, List<WatchEntity>>>();
      watchesService.listWatches().listen(controller.add);

      await Future.delayed(const Duration(seconds: 1));

      await expectLater(
        controller.stream,
        emits(isA<Either<Failures, List<WatchEntity>>>()),
      );

      await controller.close();
      verify(() => mockFirebaseAuth.currentUser).called(1);
      verify(() => mockFirestore.collection('watches')).called(1);
      verify(() =>
              mockCollectionReference.where('user_id', isEqualTo: 'user_id'))
          .called(1);
      verify(() => mockQuery.snapshots()).called(1);
    });
  });
}
