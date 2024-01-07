import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/domain/value_objects/email_address/email_address_value.dart';
import '../../../../core/domain/value_objects/password/password_value.dart';
import 'login_form_state.dart';

class LoginFormStateNotifier extends StateNotifier<LoginFormState> {
  LoginFormStateNotifier() : super(LoginFormState.initial());

  LoginFormState get last => state;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void changeEmailAddress(String email) {
    state = state.copyWith(email: EmailAddressValue(email));
  }

  void changePassword(String password) {
    state = state.copyWith(password: PasswordValue(password));
  }

  bool get emailIsValid => state.email.isValid;
  bool get passwordIsValid => state.password.isValid;
}

final loginFormStateNotifierProvider =
    StateNotifierProvider.autoDispose<LoginFormStateNotifier, LoginFormState>(
  (_) => LoginFormStateNotifier(),
);
