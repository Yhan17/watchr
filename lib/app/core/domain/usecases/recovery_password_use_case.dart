import 'package:dartz/dartz.dart';

import '../../usecase/use_case.dart';
import '../failures/failures.dart';
import '../services/auth_service.dart';
import '../value_objects/email_address/email_address_value.dart';

class RecoveryPasswordUseCase
    extends UseCaseWithFailure<Failures, Unit, EmailAddressValue> {
  final AuthService _authService;

  const RecoveryPasswordUseCase(this._authService);

  @override
  Future<Either<Failures, Unit>> call(
    EmailAddressValue params,
  ) {
    return _authService.recoveryPassword(params);
  }
}
