import 'package:riverpod/riverpod.dart';

import '../domain/usecases/sign_in_email_and_password_use_case.dart';
import '../domain/usecases/sign_up_email_and_password_use_case.dart';
import 'service_provider.dart';

final signInEmailAndPasswordUseCaseProvider = Provider.autoDispose(
  (ref) => SignInEmailAndPasswordUseCase(
    ref.read(authServiceProvider),
  ),
);

final signUpEmailAndPasswordUseCaseProvider = Provider.autoDispose(
  (ref) => SignUpEmailAndPasswordUseCase(
    ref.read(authServiceProvider),
  ),
);


