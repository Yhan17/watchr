import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/domain/value_objects/email_address/email_address_value.dart';
import '../../../../core/domain/value_objects/password/password_value.dart';
import 'sign_up_form_state.dart';

class SignUpFormStateNotifier extends StateNotifier<SignUpFormState> {
  SignUpFormStateNotifier() : super(SignUpFormState.initial());
  SignUpFormState get last => state;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void changeEmailAddress(String email) {
    state = state.copyWith(email: EmailAddressValue(email));
  }

  void changePassword(String password) {
    state = state.copyWith(password: PasswordValue(password));
  }

  void changeConfirmPassword(String password) {
    state = state.copyWith(confirmPassword: PasswordValue(password));
  }

  bool get emailIsValid => state.email.isValid;
  bool get passwordIsValid => state.password.isValid;
  bool get isSamePassword => state.isPasswordEquals;
}

final signUpFormStateNotifierProvider =
    StateNotifierProvider.autoDispose<SignUpFormStateNotifier, SignUpFormState>(
  (_) => SignUpFormStateNotifier(),
);
