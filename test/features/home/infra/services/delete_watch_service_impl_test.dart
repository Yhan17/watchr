// ignore_for_file: subtype_of_sealed_class

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:watchr/app/core/domain/entities/watch_entity.dart';
import 'package:watchr/app/core/domain/failures/failures.dart';
import 'package:watchr/app/features/home/infra/service/delete_watch_service_impl.dart';

class MockFirestore extends Mock implements FirebaseFirestore {}

class MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

class MockDocumentReference extends Mock
    implements DocumentReference<Map<String, dynamic>> {}

void main() {
  group('WatchCreateServiceImpl', () {
    late DeleteWatchServiceImpl deleteWatchServiceImpl;
    late MockFirestore mockFirestore;
    late MockCollectionReference mockCollectionReference;
    late MockDocumentReference mockDocumentReference;

    setUp(() {
      mockFirestore = MockFirestore();
      deleteWatchServiceImpl = DeleteWatchServiceImpl(mockFirestore);
      mockCollectionReference = MockCollectionReference();
      mockDocumentReference = MockDocumentReference();

      when(() => mockFirestore.collection('watches'))
          .thenReturn(mockCollectionReference);
      when(() => mockCollectionReference.doc(any()))
          .thenReturn(mockDocumentReference);
      when(() => mockDocumentReference.delete()).thenAnswer((_) async {});
    });

    test('saveWatchInFirestore should call necessary methods', () async {
      final entity = WatchEntity(
        id: 'mocked_id',
        name: 'mocked_name',
        description: 'mocked_description',
        price: 123.45,
        stockQuantity: 10,
        code: 'mocked_code',
        imageStoragePath: 'mocked_path',
        userId: 'mocked_user_id',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final result = await deleteWatchServiceImpl.deleteWatch(
        entity,
      );

      expect(result, isA<Right<Failures, Unit>>());

      verify(() => mockDocumentReference.delete()).called(1);
    });
  });
}
