import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:watchr/app/core/domain/entities/watch_entity.dart';
import 'package:watchr/app/core/domain/failures/failures.dart';
import 'package:watchr/app/features/home/domain/services/delete_watch_service.dart';
import 'package:watchr/app/features/home/domain/usecase/delete_watch_use_case.dart';

class MockDeleteWatchService extends Mock implements DeleteWatchService {}

void main() {
  group('DeleteWatchUseCase', () {
    late DeleteWatchUseCase deleteWatchUseCase;
    late DeleteWatchService mockDeleteWatchService;

    setUp(() {
      mockDeleteWatchService = MockDeleteWatchService();
      deleteWatchUseCase = DeleteWatchUseCase(mockDeleteWatchService);
    });

    test('should return Right(unit) when deleteWatch is successful', () async {
      final watchEntity = WatchEntity(
        id: '1',
        name: 'Watch 1',
        description: 'Description 1',
        price: 199.99,
        stockQuantity: 10,
        code: 'W1',
        imageStoragePath: 'path1',
        userId: 'user1',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      when(() => mockDeleteWatchService.deleteWatch(watchEntity))
          .thenAnswer((_) async => const Right(unit));

      final result = await deleteWatchUseCase(watchEntity);

      expect(result, const Right(unit));
      verify(() => mockDeleteWatchService.deleteWatch(watchEntity)).called(1);
    });

    test('should return Left(Failure) when deleteWatch fails', () async {
      final watchEntity = WatchEntity(
        id: '1',
        name: 'Watch 1',
        description: 'Description 1',
        price: 199.99,
        stockQuantity: 10,
        code: 'W1',
        imageStoragePath: 'path1',
        userId: 'user1',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      const failure = Failures.unknown;
      when(() => mockDeleteWatchService.deleteWatch(watchEntity))
          .thenAnswer((_) async => const Left(failure));

      final result = await deleteWatchUseCase(watchEntity);

      expect(result, const Left(failure));
      verify(() => mockDeleteWatchService.deleteWatch(watchEntity)).called(1);
    });
  });
}
