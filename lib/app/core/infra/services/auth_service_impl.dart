import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/failures/failures.dart';
import '../../domain/services/auth_service.dart';
import '../../domain/value_objects/email_address/email_address_value.dart';
import '../../domain/value_objects/password/password_value.dart';
import '../dtos/user_dto.dart';

class AuthServiceImpl implements AuthService {
  final FirebaseAuth _firebaseAuth;

  AuthServiceImpl(this._firebaseAuth);
  @override
  Future<Either<Failures, UserEntity>> signInEmailAndPassword(
    EmailAddressValue email,
    PasswordValue password,
  ) async {
    try {
      final emailString = email.value.getOrElse(
        () => throw Failures.serviceFailure,
      );

      final passwordString = password.value.getOrElse(
        () => throw Failures.serviceFailure,
      );

      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: emailString,
        password: passwordString,
      );

      final firebaseUser = userCredential.user!;
      final idToken = await firebaseUser.getIdToken();

      final user = UserDto.fromFirebaseUser(firebaseUser, idToken!).toEntity();

      return right(user);
    } on FirebaseAuthException catch (_) {
      // Seria possível criar exceções personalizadas para cada uma das falhas de AuthException mas devido ao tempo vou retornar genericamente
      return left(Failures.authFailure);
    } on Failures catch (failure) {
      return left(failure);
    } catch (_) {
      return left(Failures.unknown);
    }
  }

  @override
  Future<Either<Failures, UserEntity>> signUpEmailAndPassword(
    EmailAddressValue email,
    PasswordValue password,
  ) async {
    try {
      final emailString = email.value.getOrElse(
        () => throw Failures.serviceFailure,
      );

      final passwordString = password.value.getOrElse(
        () => throw Failures.serviceFailure,
      );

      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: emailString,
        password: passwordString,
      );

      final firebaseUser = userCredential.user!;
      final idToken = await firebaseUser.getIdToken();

      final user = UserDto.fromFirebaseUser(firebaseUser, idToken!).toEntity();

      return right(user);
    } on FirebaseAuthException catch (_) {
      // Seria possível criar exceções personalizadas para cada uma das falhas de AuthException mas devido ao tempo vou retornar genericamente
      return left(Failures.authFailure);
    } on Failures catch (failure) {
      return left(failure);
    } catch (_) {
      return left(Failures.unknown);
    }
  }

  @override
  Future<Option<User>> getCurrentUser() async {
    try {
      final firebaseUser = _firebaseAuth.currentUser;
      if (firebaseUser == null) {
        return none();
      }

      return some(firebaseUser);
    } catch (_) {
      return none();
    }
  }

  @override
  Future<Option<Unit>> signOut() async {
    try {
      await _firebaseAuth.signOut();

      return some(unit);
    } catch (_) {
      return none();
    }
  }
}
