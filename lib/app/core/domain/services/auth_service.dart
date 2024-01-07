import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../entities/user_entity.dart';
import '../failures/failures.dart';
import '../value_objects/email_address/email_address_value.dart';
import '../value_objects/password/password_value.dart';

abstract class AuthService {
  const AuthService();

  Future<Either<Failures, UserEntity>> signInEmailAndPassword(
    EmailAddressValue email,
    PasswordValue password,
  );
  Future<Either<Failures, UserEntity>> signUpEmailAndPassword(
    EmailAddressValue email,
    PasswordValue password,
  );

  Future<Option<User>> getCurrentUser();

  Future<Option<Unit>> signOut();
}
