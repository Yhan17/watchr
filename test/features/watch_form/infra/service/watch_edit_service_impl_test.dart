// ignore_for_file: subtype_of_sealed_class

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:watchr/app/core/domain/entities/watch_entity.dart';
import 'package:watchr/app/core/domain/failures/failures.dart';
import 'package:watchr/app/core/infra/firebase/watch_storage.dart';
import 'package:watchr/app/features/watch_form/infra/service/watch_edit_service_impl.dart';

class MockFirestore extends Mock implements FirebaseFirestore {}

class MockFile extends Mock implements File {}

class MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

class MockDocumentReference extends Mock
    implements DocumentReference<Map<String, dynamic>> {}

class MockWatchStorage extends Mock implements WatchStorage {}

void main() {
  group('EditWatchServiceImpl', () {
    late WatchEditServiceImpl watchCreateService;
    late MockFirestore mockFirestore;
    late MockWatchStorage mockWatchStorage;
    late MockCollectionReference mockCollectionReference;
    late MockDocumentReference mockDocumentReference;
    late MockFile mockFile;

    setUp(() {
      mockFirestore = MockFirestore();
      mockWatchStorage = MockWatchStorage();
      mockCollectionReference = MockCollectionReference();
      mockDocumentReference = MockDocumentReference();
      mockFile = MockFile();

      watchCreateService = WatchEditServiceImpl(
        mockFirestore,
        mockWatchStorage,
      );

      when(
        () => mockWatchStorage.deleteImage(
          'mocked_uuid',
        ),
      ).thenAnswer((_) => Future.value());
      when(
        () => mockWatchStorage.uploadImage(
          uuid: 'mocked_uuid',
          image: mockFile,
        ),
      ).thenAnswer((_) => Future.value('path'));
      when(() => mockFirestore.collection('watches'))
          .thenReturn(mockCollectionReference);
      when(() => mockCollectionReference.doc(any()))
          .thenReturn(mockDocumentReference);
      when(() => mockDocumentReference.update(any())).thenAnswer((_) async {});
    });

    test('editWatch should call necessary methods', () async {
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

      final result = await watchCreateService.editWatch(
        'mocked_uuid',
        mockFile,
        entity,
      );

      expect(result, isA<Right<Failures, Unit>>());

      verify(() => mockWatchStorage.uploadImage(
            uuid: 'mocked_uuid',
            image: mockFile,
          )).called(1);
      verify(() => mockDocumentReference.update(any())).called(1);
    });
  });
}
