import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:watchr/app/core/domain/failures/failures.dart';
import 'package:watchr/app/core/usecase/use_case.dart';

class MockUseCaseWithFailure extends Mock implements UseCaseWithFailure<Failures, String, NoParams> {}

void main() {
  group('UseCaseWithFailure', () {
    late MockUseCaseWithFailure mockUseCase;

    setUp(() {
      mockUseCase = MockUseCaseWithFailure();
    });

    test('call returns Right for successful execution', () async {
      when(() => mockUseCase.call(const NoParams()))
          .thenAnswer((_) async => const Right('Success'));

      final result = await mockUseCase.call(const NoParams());

      expect(result, equals(const Right('Success')));
    });

    test('call returns Left for failure', () async {
      const failure = Failures.serviceFailure;

      when(() => mockUseCase.call(const NoParams()))
          .thenAnswer((_) async => const Left(failure));

      final result = await mockUseCase.call(const NoParams());

      expect(result, equals(const Left(failure)));
    });
  });
}
