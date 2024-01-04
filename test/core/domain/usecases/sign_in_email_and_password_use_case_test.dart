import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:watchr/app/core/domain/entities/user_entity.dart';
import 'package:watchr/app/core/domain/failures/failures.dart';
import 'package:watchr/app/core/domain/services/auth_service.dart';
import 'package:watchr/app/core/domain/usecases/sign_in_email_and_password_use_case.dart';
import 'package:watchr/app/core/domain/value_objects/email_address/email_address_value.dart';
import 'package:watchr/app/core/domain/value_objects/password/password_value.dart';


class MockAuthService extends Mock implements AuthService {}

void main() {
  group('SignInEmailAndPasswordUseCase', () {
    late MockAuthService mockAuthService;
    late SignInEmailAndPasswordUseCase signInUseCase;

    setUp(() {
      mockAuthService = MockAuthService();
      signInUseCase = SignInEmailAndPasswordUseCase(mockAuthService);
    });

    test('call returns Right for successful signin', () async {
      final email = EmailAddressValue('test@example.com');
      final password = PasswordValue('password123');
      final params = SignInEmailAndPasswordParams(email, password);
      const userEntity = UserEntity(
        uid: '1',
        idToken: 'token',
        emailAddress: 'test@example.com',
        displayName: 'Test User',
        isAnonymous: false,
        emailVerified: true,
        provider: FirebaseProvider.unknown,
      );

      when(() => mockAuthService.signInEmailAndPassword(email, password))
          .thenAnswer((_) async => const Right(userEntity));

      final result = await signInUseCase(params);

      expect(result, equals(const Right(userEntity)));
    });

    test('call returns Left for signin failure', () async {
      final email = EmailAddressValue('test@example.com');
      final password = PasswordValue('password123');
      final params = SignInEmailAndPasswordParams(email, password);
      const failure = Failures.serviceFailure;

      when(() => mockAuthService.signInEmailAndPassword(email, password))
          .thenAnswer((_) async => const Left(failure));

      final result = await signInUseCase(params);

      expect(result, equals(const Left(failure)));
    });
  });
}
