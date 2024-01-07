import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/domain/value_objects/email_address/email_address_value.dart';
import '../../../../core/domain/value_objects/password/password_value.dart';

part 'login_form_state.freezed.dart';

@freezed
abstract class LoginFormState with _$LoginFormState {
  const LoginFormState._();
  factory LoginFormState({
    required EmailAddressValue email,
    required PasswordValue password,
  }) = _LoginFormState;

  factory LoginFormState.initial() => LoginFormState(
        email: EmailAddressValue(''),
        password: PasswordValue(''),
      );

  bool get loginCanSubmit => email.isValid && password.isValid;
}
