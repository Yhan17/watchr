import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:watchr/app/core/domain/entities/watch_entity.dart';
import 'package:watchr/app/core/domain/failures/failures.dart';
import 'package:watchr/app/features/home/domain/services/delete_watch_service.dart';

class MockDeleteWatchService extends Mock implements DeleteWatchService {}

void main() {
  group('DeleteWatchService', () {
    late DeleteWatchService deleteWatchService;

    setUp(() {
      deleteWatchService = MockDeleteWatchService();
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
      when(() => deleteWatchService.deleteWatch(watchEntity))
          .thenAnswer((_) async => const Right(unit));

      final result = await deleteWatchService.deleteWatch(watchEntity);

      expect(result, const Right(unit));
      verify(() => deleteWatchService.deleteWatch(watchEntity)).called(1);
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
      when(() => deleteWatchService.deleteWatch(watchEntity))
          .thenAnswer((_) async => const Left(failure));

      final result = await deleteWatchService.deleteWatch(watchEntity);

      expect(result, const Left(failure));
      verify(() => deleteWatchService.deleteWatch(watchEntity)).called(1);
    });
  });
}
