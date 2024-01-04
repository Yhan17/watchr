import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:watchr/app/core/domain/entities/watch_entity.dart';
import 'package:watchr/app/core/domain/failures/failures.dart';

import 'dart:io';

import 'package:watchr/app/features/watch_form/domain/service/watch_edit_service.dart';

class MockWatchEditService extends Mock implements WatchEditService {}

class MockFile extends Mock implements File {}

void main() {
  group('WatchEditService', () {
    late WatchEditService watchEditService;

    setUp(() {
      watchEditService = MockWatchEditService();
    });

    test('should return Right(unit) when editWatch is successful', () async {
      final mockFile = MockFile();
      const watchId = 'your_watch_id';
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
      when(
        () => watchEditService.editWatch(
          watchId,
          mockFile,
          entity,
        ),
      ).thenAnswer((_) async => const Right(unit));

      final result = await watchEditService.editWatch(
        watchId,
        mockFile,
        entity,
      );

      expect(result, const Right(unit));
      verify(
        () => watchEditService.editWatch(
          watchId,
          mockFile,
          entity,
        ),
      ).called(1);
    });

    test('should return Left(Failure) when editWatch fails', () async {
      final mockFile = MockFile();
      const watchId = 'your_watch_id';
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
      const failure = Failures.unknown;
      when(() => watchEditService.editWatch(watchId, mockFile, entity))
          .thenAnswer(
        (_) async => const Left(failure),
      );

      final result = await watchEditService.editWatch(
        watchId,
        mockFile,
        entity,
      );

      expect(result, const Left(failure));
      verify(
        () => watchEditService.editWatch(
          watchId,
          mockFile,
          entity,
        ),
      ).called(1);
    });
  });
}
