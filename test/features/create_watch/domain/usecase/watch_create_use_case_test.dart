import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:watchr/app/core/domain/entities/watch_entity.dart';
import 'package:watchr/app/core/domain/failures/failures.dart';
import 'package:watchr/app/features/create_watch/domain/service/watch_create_service.dart';
import 'package:watchr/app/features/create_watch/domain/usecase/watch_create_use_case.dart';

import '../../../../core/providers/service_provider_test.dart';

class MockWatchCreateService extends Mock implements WatchCreateService {}

void main() {
  group('WatchCreateUseCase', () {
    late WatchCreateUseCase watchCreateUseCase;
    late MockWatchCreateService mockWatchCreateService;
    late MockFile mockFile;

    setUp(() {
      mockWatchCreateService = MockWatchCreateService();
      watchCreateUseCase = WatchCreateUseCase(mockWatchCreateService);
      mockFile = MockFile();
    });

    test('calls saveWatchInFirestore on WatchCreateService', () async {
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

      final params = WatchCreateParams(entity: entity, file: mockFile);

      when(() => mockWatchCreateService.saveWatchInFirestore(entity, mockFile))
          .thenAnswer((_) async => const Right(unit));

      final result = await watchCreateUseCase(params);

      verify(
        () => mockWatchCreateService.saveWatchInFirestore(
          entity,
          mockFile,
        ),
      ).called(1);

      expect(result, isA<Right<Failures, Unit>>());
    });
  });
}
