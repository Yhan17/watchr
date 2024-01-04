// ignore_for_file: subtype_of_sealed_class

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uuid/uuid.dart';
import 'package:watchr/app/core/domain/entities/watch_entity.dart';
import 'package:watchr/app/core/domain/failures/failures.dart';
import 'package:watchr/app/core/domain/services/auth_service.dart';
import 'package:watchr/app/core/infra/firebase/watch_storage.dart';
import 'package:watchr/app/core/infra/services/auth_service_impl.dart';
import 'package:watchr/app/core/providers/core_providers.dart';
import 'package:watchr/app/core/providers/service_provider.dart';
import 'package:watchr/app/features/home/domain/services/delete_watch_service.dart';
import 'package:watchr/app/features/home/infra/service/delete_watch_service_impl.dart';
import 'package:watchr/app/features/watch_form/infra/service/watch_edit_service_impl.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFirestore extends Mock implements FirebaseFirestore {}

class MockWatchStorage extends Mock implements WatchStorage {}

class MockUuid extends Mock implements Uuid {}

class MockFile extends Mock implements File {}

class MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

class MockDocumentReference extends Mock
    implements DocumentReference<Map<String, dynamic>> {}

void main() {
  group('AuthService Provider', () {
    test('AuthService Provider initializes AuthServiceImpl', () {
      final mockFirebaseAuth = MockFirebaseAuth();
      when(() => mockFirebaseAuth.currentUser).thenReturn(null);
      when(() => mockFirebaseAuth.authStateChanges())
          .thenAnswer((_) => const Stream.empty());

      final container = ProviderContainer(overrides: [
        firebaseAuthProvider.overrideWithValue(mockFirebaseAuth),
      ]);

      final authService = container.read(authServiceProvider);

      expect(authService, isA<AuthService>());
      expect(authService, isA<AuthServiceImpl>());
    });
  });

  group('WatchCreateService Provider Test', () {
    test('WatchCreateService Provider', () async {
      final mockFirestore = MockFirestore();
      final mockWatchStorage = MockWatchStorage();
      final mockUuid = MockUuid();
      final mockFile = MockFile();
      final mockCollectionReference = MockCollectionReference();
      final mockDocumentReference = MockDocumentReference();
      final container = ProviderContainer(overrides: [
        firestoreProvider.overrideWithValue(mockFirestore),
        watchStorageProvider.overrideWithValue(mockWatchStorage),
        uuidProvider.overrideWithValue(mockUuid),
      ]);

      when(() => mockUuid.v4()).thenReturn('mocked_uuid');
      when(
        () => mockWatchStorage.uploadImage(
          uuid: 'mocked_uuid',
          image: mockFile,
        ),
      ).thenAnswer((_) => Future.value('path'));

      container.read(firestoreProvider);
      container.read(watchStorageProvider);
      container.read(uuidProvider);

      final watchCreateService = container.read(watchCreateServiceProvider);
      final date = DateTime.now();

      final watchEntity = WatchEntity(
        id: 'mocked_id',
        name: 'mocked_name',
        description: 'mocked_description',
        price: 123.45,
        stockQuantity: 10,
        code: 'mocked_code',
        imageStoragePath: 'mocked_path',
        userId: 'mocked_user_id',
        createdAt: date,
        updatedAt: date,
      );
      when(() => mockFirestore.collection('watches'))
          .thenReturn(mockCollectionReference);
      when(() => mockCollectionReference.doc(any()))
          .thenReturn(mockDocumentReference);
      when(
        () => mockDocumentReference.set(any()),
      ).thenAnswer((_) => Future.value());

      final result = await watchCreateService.saveWatchInFirestore(
        watchEntity,
        mockFile,
      );

      expect(result, isA<Right<Failures, Unit>>());
      verify(() => watchCreateService.saveWatchInFirestore(
            watchEntity,
            mockFile,
          )).called(1);
    });
  });

  group('deleteWatchServiceProvider', () {
    test('should provide DeleteWatchService instance', () {
      final mockFirestore = MockFirestore();
      final container = ProviderContainer(overrides: [
        firestoreProvider.overrideWithValue(mockFirestore),
      ]);

      final deleteWatchService = container.read(deleteWatchServiceProvider);

      expect(deleteWatchService, isA<DeleteWatchServiceImpl>());
      expect(deleteWatchService, isA<DeleteWatchService>());
    });
  });

  group('editWatchServiceProvider', () {
    test('should provide WatchEditService instance', () async {
      // Arrange
      final mockFirestore = MockFirestore();
      final mockWatchStorage = MockWatchStorage();
      final mockFile = MockFile();
      final mockCollectionReference = MockCollectionReference();
      final mockDocumentReference = MockDocumentReference();
      final container = ProviderContainer(overrides: [
        firestoreProvider.overrideWithValue(mockFirestore),
        watchStorageProvider.overrideWithValue(mockWatchStorage),
      ]);

      when(
        () => mockWatchStorage.uploadImage(
          uuid: 'mocked_uuid',
          image: mockFile,
        ),
      ).thenAnswer((_) => Future.value('path'));
      when(
        () => mockWatchStorage.deleteImage(
          'mocked_uuid',
        ),
      ).thenAnswer((_) => Future.value());

      container.read(firestoreProvider);
      container.read(watchStorageProvider);

      final editWatchService = container.read(editWatchServiceProvider);
      final date = DateTime.now();

      final watchEntity = WatchEntity(
        id: 'mocked_id',
        name: 'mocked_name',
        description: 'mocked_description',
        price: 123.45,
        stockQuantity: 10,
        code: 'mocked_code',
        imageStoragePath: 'mocked_path',
        userId: 'mocked_user_id',
        createdAt: date,
        updatedAt: date,
      );
      when(() => mockFirestore.collection('watches'))
          .thenReturn(mockCollectionReference);
      when(() => mockCollectionReference.doc(any()))
          .thenReturn(mockDocumentReference);
      when(
        () => mockDocumentReference.update(any()),
      ).thenAnswer((_) => Future.value());
      final result = await editWatchService.editWatch(
        'mocked_uuid',
        mockFile,
        watchEntity,
      );
      // Assert
      expect(editWatchService, isA<WatchEditServiceImpl>());
      expect(result, isA<Right<Failures, Unit>>());
      verify(
        () => editWatchService.editWatch(
          'mocked_uuid',
          mockFile,
          watchEntity,
        ),
      ).called(1);
    });
  });
}
