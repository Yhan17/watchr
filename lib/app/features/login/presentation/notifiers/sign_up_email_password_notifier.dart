import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/domain/entities/user_entity.dart';
import '../../../../core/domain/failures/failures.dart';
import '../../../../core/domain/usecases/sign_up_email_and_password_use_case.dart';
import '../../../../core/domain/value_objects/email_address/email_address_value.dart';
import '../../../../core/domain/value_objects/password/password_value.dart';
import '../../../../core/presentation/shared/common/common_state.dart';
import '../../../../core/providers/use_case_provider.dart';

typedef SignUpEmailAndPasswordState = CommonState<Failures, UserEntity>;

class SignUpEmailAndPasswordStateNotifierNotifier
    extends StateNotifier<SignUpEmailAndPasswordState> {
  final SignUpEmailAndPasswordUseCase _useCase;
  SignUpEmailAndPasswordStateNotifierNotifier(this._useCase)
      : super(const SignUpEmailAndPasswordState.initial());

  Future<void> signUpEmailAndPassword(
    EmailAddressValue email,
    PasswordValue password,
  ) async {
    state = const SignUpEmailAndPasswordState.loadInProgress();
    final result = await _useCase.call(
      SignUpEmailAndPasswordParams(email, password),
    );
    state = result.fold(
      SignUpEmailAndPasswordState.loadFailure,
      SignUpEmailAndPasswordState.loadSuccess,
    );
  }
}

final signUpEmailAndPasswordNotifierProvider =
    StateNotifierProvider.autoDispose<
        SignUpEmailAndPasswordStateNotifierNotifier,
        SignUpEmailAndPasswordState>(
  (ref) => SignUpEmailAndPasswordStateNotifierNotifier(
    ref.read(signUpEmailAndPasswordUseCaseProvider),
  ),
);
