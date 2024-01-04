import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:watchr/app/core/domain/entities/user_entity.dart';
import 'package:watchr/app/core/domain/failures/failures.dart';
import 'package:watchr/app/core/domain/services/auth_service.dart';
import 'package:watchr/app/core/domain/value_objects/email_address/email_address_value.dart';
import 'package:watchr/app/core/domain/value_objects/password/password_value.dart';

class MockAuthService extends Mock implements AuthService {}

void main() {
  group('AuthService', () {
    late MockAuthService mockAuthService;

    setUp(() {
      mockAuthService = MockAuthService();
    });

    test('signInEmailAndPassword returns a UserEntity on success', () async {
      final email = EmailAddressValue('test@example.com');
      final password = PasswordValue('password123');
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

      final result =
          await mockAuthService.signInEmailAndPassword(email, password);

      expect(result, equals(const Right(userEntity)));
    });

    test('signInEmailAndPassword returns a Failures on failure', () async {
      final email = EmailAddressValue('test@example.com');
      final password = PasswordValue('password123');
      const failure = Failures.serviceFailure;

      when(() => mockAuthService.signInEmailAndPassword(email, password))
          .thenAnswer((_) async => const Left(failure));

      final result =
          await mockAuthService.signInEmailAndPassword(email, password);

      expect(result, equals(const Left(failure)));
    });

    test('signUpEmailAndPassword returns a UserEntity on success', () async {
      final email = EmailAddressValue('test@example.com');
      final password = PasswordValue('password123');
      const userEntity = UserEntity(
        uid: '2',
        idToken: 'token2',
        emailAddress: 'test@example.com',
        displayName: 'Test User',
        isAnonymous: false,
        emailVerified: true,
        provider: FirebaseProvider.unknown,
      );

      when(() => mockAuthService.signUpEmailAndPassword(email, password))
          .thenAnswer((_) async => const Right(userEntity));

      final result =
          await mockAuthService.signUpEmailAndPassword(email, password);

      expect(result, equals(const Right(userEntity)));
    });

    test('signUpEmailAndPassword returns a Failures on failure', () async {
      final email = EmailAddressValue('test@example.com');
      final password = PasswordValue('password123');
      const failure = Failures.serviceFailure;

      when(() => mockAuthService.signUpEmailAndPassword(email, password))
          .thenAnswer((_) async => const Left(failure));

      final result =
          await mockAuthService.signUpEmailAndPassword(email, password);

      expect(result, equals(const Left(failure)));
    });
  });
}
