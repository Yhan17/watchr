import 'package:dartz/dartz.dart';

import '../../usecase/use_case.dart';
import '../entities/user_entity.dart';
import '../failures/failures.dart';
import '../services/auth_service.dart';
import '../value_objects/email_address/email_address_value.dart';
import '../value_objects/password/password_value.dart';

class SignUpEmailAndPasswordUseCase extends UseCaseWithFailure<Failures,
    UserEntity, SignUpEmailAndPasswordParams> {
  final AuthService _authService;

  const SignUpEmailAndPasswordUseCase(this._authService);

  @override
  Future<Either<Failures, UserEntity>> call(
    SignUpEmailAndPasswordParams params,
  ) {
    return _authService.signUpEmailAndPassword(params.email, params.password);
  }
}

class SignUpEmailAndPasswordParams {
  final EmailAddressValue email;
  final PasswordValue password;

  SignUpEmailAndPasswordParams(
    this.email,
    this.password,
  );
}
