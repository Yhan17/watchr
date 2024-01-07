import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../usecase/use_case.dart';
import '../services/auth_service.dart';

class VerifyIfLoggedUseCase extends UseCase<Option<User>, NoParams> {
  final AuthService _authService;

  const VerifyIfLoggedUseCase(this._authService);
  @override
  Future<Option<User>> call(NoParams params) {
    return _authService.getCurrentUser();
  }
}
