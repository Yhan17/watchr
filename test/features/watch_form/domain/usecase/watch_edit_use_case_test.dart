import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:watchr/app/core/domain/entities/watch_entity.dart';
import 'package:watchr/app/core/domain/failures/failures.dart';

import 'dart:io';

import 'package:watchr/app/features/watch_form/domain/service/watch_edit_service.dart';
import 'package:watchr/app/features/watch_form/domain/usecase/watch_edit_use_case.dart';

class MockWatchEditService extends Mock implements WatchEditService {}

class MockFile extends Mock implements File {}

void main() {
  group('WatchEditUseCase', () {
    late WatchEditUseCase watchEditUseCase;
    late WatchEditService mockWatchEditService;
    late MockFile file;

    setUp(() {
      mockWatchEditService = MockWatchEditService();
      watchEditUseCase = WatchEditUseCase(mockWatchEditService);
      file = MockFile();
    });

    test('should return Right(unit) when editWatch is successful', () async {
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
      final editWatchParams = EditWatchParams(
        'your_watch_id',
        file,
        entity,
      );
      when(() => mockWatchEditService.editWatch(
            editWatchParams.id,
            editWatchParams.image,
            editWatchParams.entity,
          )).thenAnswer((_) async => const Right(unit));

      final result = await watchEditUseCase(editWatchParams);

      expect(result, const Right(unit));
      verify(() => mockWatchEditService.editWatch(
            editWatchParams.id,
            editWatchParams.image,
            editWatchParams.entity,
          )).called(1);
    });

    test('should return Left(Failure) when editWatch fails', () async {
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
      final editWatchParams = EditWatchParams(
        'your_watch_id',
        file,
        entity,
      );
      const failure = Failures.unknown;
      when(() => mockWatchEditService.editWatch(
            editWatchParams.id,
            editWatchParams.image,
            editWatchParams.entity,
          )).thenAnswer((_) async => const Left(failure));

      final result = await watchEditUseCase(editWatchParams);

      expect(result, const Left(failure));
      verify(
        () => mockWatchEditService.editWatch(
          editWatchParams.id,
          editWatchParams.image,
          editWatchParams.entity,
        ),
      ).called(1);
    });
  });
}
