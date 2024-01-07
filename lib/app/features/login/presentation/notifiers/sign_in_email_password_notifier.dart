import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/domain/entities/user_entity.dart';
import '../../../../core/domain/failures/failures.dart';
import '../../../../core/domain/usecases/sign_in_email_and_password_use_case.dart';
import '../../../../core/domain/value_objects/email_address/email_address_value.dart';
import '../../../../core/domain/value_objects/password/password_value.dart';
import '../../../../core/presentation/shared/common/common_state.dart';
import '../../../../core/providers/use_case_provider.dart';

typedef SignInEmailPasswordState = CommonState<Failures, UserEntity>;

class SignInEmailPasswordNotifier
    extends StateNotifier<SignInEmailPasswordState> {
  final SignInEmailAndPasswordUseCase _useCase;
  SignInEmailPasswordNotifier(this._useCase)
      : super(
          const SignInEmailPasswordState.initial(),
        );

  Future<void> signInEmailAndPassword(
    EmailAddressValue email,
    PasswordValue password,
  ) async {
    state = const SignInEmailPasswordState.loadInProgress();

    final result = await _useCase.call(
      SignInEmailAndPasswordParams(
        email,
        password,
      ),
    );

    state = result.fold(
      SignInEmailPasswordState.loadFailure,
      SignInEmailPasswordState.loadSuccess,
    );
  }
}

final signInEmailAndPasswordNotifierProvider = StateNotifierProvider
    .autoDispose<SignInEmailPasswordNotifier, SignInEmailPasswordState>(
  (ref) => SignInEmailPasswordNotifier(
    ref.read(signInEmailAndPasswordUseCaseProvider),
  ),
);
