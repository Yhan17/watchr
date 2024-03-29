import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:watchr/app/core/domain/entities/watch_entity.dart';
import 'package:watchr/app/core/domain/failures/failures.dart';
import 'package:watchr/app/features/home/domain/services/watches_service.dart';

class MockWatchesService extends Mock implements WatchesService {}

void main() {
  group('WatchesService', () {
    late WatchesService watchesService;

    setUp(() {
      watchesService = MockWatchesService();
    });

    test('emits a list of watches on successful stream', () async {
      final expectedWatches = [
        WatchEntity(
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
        ),
        WatchEntity(
          id: '2',
          name: 'Watch 2',
          description: 'Description 2',
          price: 149.99,
          stockQuantity: 15,
          code: 'W2',
          imageStoragePath: 'path2',
          userId: 'user2',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ];

      when(() => watchesService.listWatches())
          .thenAnswer((_) => Stream.value(right(expectedWatches)));

      final controller =
          StreamController<Either<Failures, List<WatchEntity>>>();

      watchesService.listWatches().listen(controller.add);

      final actualResult = await controller.stream.first;

      await controller.close();

      expect(actualResult, equals(right(expectedWatches)));

      verify(() => watchesService.listWatches()).called(1);
    });

    test('emits a failure on stream failure', () async {
      when(() => watchesService.listWatches())
          .thenAnswer((_) => Stream.value(left(Failures.unknown)));

      final controller =
          StreamController<Either<Failures, List<WatchEntity>>>();

      watchesService.listWatches().listen(controller.add);

      final actualResult = await controller.stream.first;

      await controller.close();

      expect(actualResult, equals(left(Failures.unknown)));

      verify(() => watchesService.listWatches()).called(1);
    });
  });
}
