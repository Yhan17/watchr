import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/domain/value_objects/email_address/email_address_value.dart';
import '../../../../core/domain/value_objects/password/password_value.dart';

part 'sign_up_form_state.freezed.dart';

@freezed
abstract class SignUpFormState with _$SignUpFormState {
  const SignUpFormState._();
  factory SignUpFormState({
    required EmailAddressValue email,
    required PasswordValue password,
    required PasswordValue confirmPassword,
  }) = _SignUpFormState;

  factory SignUpFormState.initial() => SignUpFormState(
        email: EmailAddressValue(''),
        password: PasswordValue(''),
        confirmPassword: PasswordValue(''),
      );

  bool get isPasswordEquals {
    final passwordValue = password.value.getOrElse(() => '');
    final confirmPasswordValue = confirmPassword.value.getOrElse(() => '');
    final result = passwordValue == confirmPasswordValue;
    return result;
  }

  bool get signUpCanSubmit =>
      email.isValid && password.isValid && isPasswordEquals;
}
