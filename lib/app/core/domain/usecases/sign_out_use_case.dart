import 'package:dartz/dartz.dart';

import '../../usecase/use_case.dart';
import '../services/auth_service.dart';

class SignOutUseCase extends UseCase<Option<Unit>, NoParams> {
  final AuthService _authService;

  const SignOutUseCase(this._authService);
  @override
  Future<Option<Unit>> call(NoParams params) {
    return _authService.signOut();
  }
}
