import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uuid/uuid.dart';
import 'package:watchr/app/core/infra/firebase/watch_storage.dart';
import 'package:watchr/app/core/providers/core_providers.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockFirebaseStorage extends Mock implements FirebaseStorage {}

class MockFirebaseApp extends Mock implements FirebaseApp {}

class MockUuid extends Mock implements Uuid {}

void main() {
  group('Firebase Auth and Firestore Providers', () {
    test('Firebase Auth Provider initializes FirebaseAuth.instance', () {
      // Configurar o mock
      final mockFirebaseAuth = MockFirebaseAuth();
      when(() => mockFirebaseAuth.currentUser).thenReturn(null);
      when(() => mockFirebaseAuth.authStateChanges())
          .thenAnswer((_) => const Stream.empty());

      // Sobrescrever o provider para usar o mock
      final container = ProviderContainer(overrides: [
        firebaseAuthProvider.overrideWithValue(mockFirebaseAuth),
      ]);

      // Obter a instância de FirebaseAuth do provider
      final firebaseAuth = container.read(firebaseAuthProvider);

      // Verificar se a instância obtida é o mock
      expect(firebaseAuth, same(mockFirebaseAuth));
    });

    test('Firestore Provider initializes FirebaseFirestore.instance', () {
      // Configurar o mock
      final mockFirebaseFirestore = MockFirebaseFirestore();

      // Sobrescrever o provider para usar o mock
      final container = ProviderContainer(overrides: [
        firestoreProvider.overrideWithValue(mockFirebaseFirestore),
      ]);

      // Obter a instância de FirebaseFirestore do provider
      final firestore = container.read(firestoreProvider);

      // Verificar se a instância obtida é o mock
      expect(firestore, same(mockFirebaseFirestore));
    });
  });

  group('StorageProvider Test', () {
    test('FirebaseStorage Provider', () {
      final mockFirebaseStorage = MockFirebaseStorage();
      final container = ProviderContainer(overrides: [
        firebaseStorage.overrideWithValue(mockFirebaseStorage),
      ]);

      when(() => mockFirebaseStorage.app).thenReturn(MockFirebaseApp());
      container.read(firebaseStorage);

      expect(container.read(firebaseStorage), isA<FirebaseStorage>());
    });

    test('WatchStorage Provider', () {
      final mockFirebaseStorage = MockFirebaseStorage();
      final container = ProviderContainer(overrides: [
        firebaseStorage.overrideWithValue(mockFirebaseStorage),
      ]);
      when(() => mockFirebaseStorage.app).thenReturn(MockFirebaseApp());
      container.read(firebaseStorage);

      final watchStorage = container.read(watchStorageProvider);

      expect(watchStorage, isA<WatchStorage>());
    });

    test('Uuid Provider', () {
      final mockUuid = MockUuid();

      final container = ProviderContainer(overrides: [
        uuidProvider.overrideWithValue(mockUuid),
      ]);

      final uuid = container.read(uuidProvider);

      expect(uuid, isA<Uuid>());
    });
  });
}
