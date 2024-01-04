import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:watchr/app/core/domain/entities/user_entity.dart';
import 'package:watchr/app/core/domain/failures/failures.dart';
import 'package:watchr/app/core/domain/value_objects/email_address/email_address_value.dart';
import 'package:watchr/app/core/domain/value_objects/password/password_value.dart';
import 'package:watchr/app/core/infra/services/auth_service_impl.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {}

class MockUser extends Mock implements User {}

void main() {
  group('AuthServiceImpl', () {
    late AuthServiceImpl authService;
    late MockFirebaseAuth mockFirebaseAuth;
    late MockUserCredential mockUserCredential;
    late MockUser mockUser;

    setUp(() {
      mockFirebaseAuth = MockFirebaseAuth();
      mockUserCredential = MockUserCredential();
      mockUser = MockUser();

      authService = AuthServiceImpl(mockFirebaseAuth);
    });

    test('signInEmailAndPassword returns UserEntity on successful sign-in',
        () async {
      final email = EmailAddressValue('test@example.com');
      final password = PasswordValue('password123');
      when(() => mockUser.uid).thenReturn('test_uid');
      when(() => mockUser.email).thenReturn('test@example.com');
      when(() => mockUser.displayName).thenReturn('Test User');
      when(() => mockUser.isAnonymous).thenReturn(false);
      when(() => mockUser.emailVerified).thenReturn(true);
      when(() => mockUser.phoneNumber).thenReturn('123456789');

      ///  {
      ///     "firebase": {
      ///       "sign_in_provider": "password"
      ///     }
      ///  }
      const token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9'
          '.eyJmaXJlYmFzZSI6eyJzaWduX2luX'
          '3Byb3ZpZGVyIjoicGFzc3dvcmQifX0'
          '.PXT97eWCjh7HBoR2KLg8Mv1tChEXFomGcuoLd9L-gqE';

      when(() => mockFirebaseAuth.signInWithEmailAndPassword(
            email: 'test@example.com',
            password: 'password123',
          )).thenAnswer((_) async => mockUserCredential);

      when(() => mockUserCredential.user).thenReturn(mockUser);

      when(() => mockUser.getIdToken()).thenAnswer((_) async => token);

      final result = await authService.signInEmailAndPassword(email, password);
      final user = result.toOption();

      expect(result, isA<Right<Failures, UserEntity>>());
      expect(user, isA<Some>());
    });

    test(
        'signInEmailAndPassword returns Failures.authFailure on sign-in failure',
        () async {
      final email = EmailAddressValue('test@example.com');
      final password = PasswordValue('password123');

      when(() => mockFirebaseAuth.signInWithEmailAndPassword(
                email: 'test@example.com',
                password: 'password123',
              ))
          .thenThrow(FirebaseAuthException(
              message: 'Sign-in failed', code: 'error_code'));

      final result = await authService.signInEmailAndPassword(email, password);

      expect(result, equals(left(Failures.authFailure)));
    });

    test('signInEmailAndPassword returns Failures.unknown on unexpected error',
        () async {
      final email = EmailAddressValue('test@example.com');
      final password = PasswordValue('password123');

      when(() => mockFirebaseAuth.signInWithEmailAndPassword(
            email: 'test@example.com',
            password: 'password123',
          )).thenThrow(Exception('Unexpected error'));

      final result = await authService.signInEmailAndPassword(email, password);

      expect(result, equals(left(Failures.unknown)));
    });

  });
}
