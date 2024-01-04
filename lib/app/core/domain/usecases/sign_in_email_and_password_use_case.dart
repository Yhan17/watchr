import 'package:dartz/dartz.dart';

import '../../usecase/use_case.dart';
import '../entities/user_entity.dart';
import '../failures/failures.dart';
import '../services/auth_service.dart';
import '../value_objects/email_address/email_address_value.dart';
import '../value_objects/password/password_value.dart';

class SignInEmailAndPasswordUseCase extends UseCaseWithFailure<Failures,
    UserEntity, SignInEmailAndPasswordParams> {
  final AuthService _authService;

  const SignInEmailAndPasswordUseCase(this._authService);

  @override
  Future<Either<Failures, UserEntity>> call(
    SignInEmailAndPasswordParams params,
  ) {
    return _authService.signInEmailAndPassword(params.email, params.password);
  }
}

class SignInEmailAndPasswordParams {
  final EmailAddressValue email;
  final PasswordValue password;

  SignInEmailAndPasswordParams(
    this.email,
    this.password,
  );
}
