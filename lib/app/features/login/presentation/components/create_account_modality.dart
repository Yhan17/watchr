import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/presentation/routes/app_routes.dart';
import '../../../../core/presentation/shared/common/app_spacing.dart';
import '../../../../core/presentation/shared/components/watch_modality.dart';
import '../../../../core/presentation/shared/utils/failure_snackbar_handler.dart';
import '../../../../core/presentation/shared/widgets/watch_button_text_widget.dart';
import '../notifiers/sign_up_email_password_notifier.dart';
import '../notifiers/sign_up_form_state_notifier.dart';
import '../widgets/login_input_widget.dart';

class CreateAccountModality extends WatchModality {
  const CreateAccountModality({
    Key? key,
  }) : super(
          key: key,
          name: 'create-account-modality',
        );

  @override
  Widget buildContent(BuildContext context, WidgetRef ref) {
    final signUpFormStateNotifier = ref.watch(
      signUpFormStateNotifierProvider.notifier,
    );
    final signUpEmailAndPasswordNotifier = ref.watch(
      signUpEmailAndPasswordNotifierProvider.notifier,
    );

    ref.listen(
      signUpEmailAndPasswordNotifierProvider,
      (_, state) {
        state.whenOrNull(
          loadFailure: (failure) => FailureSnackbarHandler.handleFailure(
            failure,
            context,
          ),
          loadSuccess: (_) {
            AppRoutes.home.pushReplacement(
              context,
              arguments: noArgs,
            );
          },
        );
      },
    );

    return Flexible(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        shrinkWrap: true,
        children: [
          Text(
            'Create a new account',
            style: GoogleFonts.poppins(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          AppSpacing.vertical(32),
          WatchLoginInputWidget(
            label: 'E-mail',
            controller: signUpFormStateNotifier.emailController,
            validator: (value) {
              signUpFormStateNotifier.changeEmailAddress(value);
              if (!signUpFormStateNotifier.emailIsValid) {
                return 'Please insert a valid email';
              }
              return null;
            },
          ),
          AppSpacing.vertical(32),
          WatchLoginInputWidget(
            label: 'Password',
            obscureText: true,
            controller: signUpFormStateNotifier.passwordController,
            validator: (value) {
              signUpFormStateNotifier.changePassword(value);
              if (!signUpFormStateNotifier.passwordIsValid &&
                  value.isNotEmpty) {
                return 'Please insert minimum 6 characters';
              }
              return null;
            },
          ),
          AppSpacing.vertical(32),
          WatchLoginInputWidget(
            label: 'Confirm Password',
            obscureText: true,
            controller: signUpFormStateNotifier.confirmPasswordController,
            validator: (value) {
              signUpFormStateNotifier.changeConfirmPassword(value);
              if (!signUpFormStateNotifier.isSamePassword) {
                return 'Please insert same password';
              }
              return null;
            },
          ),
          AppSpacing.vertical(32),
          Consumer(
            builder: (_, cRef, __) {
              final state = cRef.watch(signUpEmailAndPasswordNotifierProvider);
              final formState = cRef.watch(signUpFormStateNotifierProvider);
              return WatchButtonTextWidget(
                text: 'Create',
                busy: state.maybeWhen(
                  loadInProgress: () => true,
                  orElse: () => false,
                ),
                onTap: formState.signUpCanSubmit
                    ? () async {
                        signUpEmailAndPasswordNotifier.signUpEmailAndPassword(
                          signUpFormStateNotifier.last.email,
                          signUpFormStateNotifier.last.password,
                        );
                      }
                    : null,
              );
            },
          ),
          AppSpacing.vertical(32),
        ],
      ),
    );
  }
}
