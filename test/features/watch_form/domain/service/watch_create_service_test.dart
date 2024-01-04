import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:watchr/app/core/domain/entities/watch_entity.dart';
import 'package:watchr/app/core/domain/failures/failures.dart';
import 'package:watchr/app/features/watch_form/domain/service/watch_create_service.dart';

class MockFile extends Mock implements File {}

class MockWatchCreateService extends Mock implements WatchCreateService {}

void main() {
  group('WatchCreateService', () {
    late MockWatchCreateService mockWatchCreateService;
    late MockFile mockFile;

    setUp(() {
      mockWatchCreateService = MockWatchCreateService();
      mockFile = MockFile();
    });

    test('saveWatchInFirestore calls the correct methods', () async {
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

      when(() => mockWatchCreateService.saveWatchInFirestore(
            entity,
            mockFile,
          )).thenAnswer((_) async => const Right(unit));

      final result =
          await mockWatchCreateService.saveWatchInFirestore(entity, mockFile);

      expect(result, isA<Right<Failures, Unit>>());

      verify(() =>
              mockWatchCreateService.saveWatchInFirestore(entity, mockFile))
          .called(1);
    });
  });
}
