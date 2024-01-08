// ignore_for_file: subtype_of_sealed_class

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uuid/uuid.dart';
import 'package:watchr/app/core/domain/entities/watch_entity.dart';
import 'package:watchr/app/core/domain/failures/failures.dart';
import 'package:watchr/app/core/infra/firebase/watch_storage.dart';
import 'package:watchr/app/features/watch_form/infra/service/watch_create_service_impl.dart';

class MockUuid extends Mock implements Uuid {}

class MockFirestore extends Mock implements FirebaseFirestore {}

class MockUser extends Mock implements User {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFile extends Mock implements File {}

class MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

class MockDocumentReference extends Mock
    implements DocumentReference<Map<String, dynamic>> {}

class MockWatchStorage extends Mock implements WatchStorage {}

void main() {
  group('WatchCreateServiceImpl', () {
    late WatchCreateServiceImpl watchCreateService;
    late MockFirestore mockFirestore;
    late MockWatchStorage mockWatchStorage;
    late MockUuid mockUuid;
    late MockCollectionReference mockCollectionReference;
    late MockDocumentReference mockDocumentReference;
    late MockFile mockFile;
    late MockFirebaseAuth mockFirebaseAuth;
    late MockUser mockUser;

    setUp(() {
      mockFirestore = MockFirestore();
      mockWatchStorage = MockWatchStorage();
      mockUuid = MockUuid();
      mockCollectionReference = MockCollectionReference();
      mockDocumentReference = MockDocumentReference();
      mockFile = MockFile();
      mockFirebaseAuth = MockFirebaseAuth();
      mockUser = MockUser();

      watchCreateService = WatchCreateServiceImpl(
        mockFirestore,
        mockWatchStorage,
        mockUuid,
        mockFirebaseAuth,
      );
      when(() => mockFirebaseAuth.currentUser).thenReturn(mockUser);
      when(() => mockUser.uid).thenReturn('');
      when(
        () => mockWatchStorage.uploadImage(
          uuid: 'mocked_uuid',
          image: mockFile,
        ),
      ).thenAnswer((_) => Future.value('path'));
      when(() => mockUuid.v4()).thenReturn('mocked_uuid');
      when(() => mockFirestore.collection('watches'))
          .thenReturn(mockCollectionReference);
      when(() => mockCollectionReference.doc(any()))
          .thenReturn(mockDocumentReference);
      when(() => mockDocumentReference.set(any())).thenAnswer((_) async {});
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

      final result = await watchCreateService.saveWatchInFirestore(
        entity,
        mockFile,
      );

      expect(result, isA<Right<Failures, Unit>>());

      verify(() => mockUuid.v4()).called(1);
      verify(() => mockWatchStorage.uploadImage(
            uuid: 'mocked_uuid',
            image: mockFile,
          )).called(1);
      verify(() => mockDocumentReference.set(any())).called(1);
    });
  });
}
