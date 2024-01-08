import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/presentation/routes/app_routes.dart';
import '../../../core/presentation/shared/common/app_spacing.dart';
import '../../../core/presentation/shared/theme/app_colors.dart';
import '../../../core/presentation/shared/theme/app_images.dart';
import '../../../core/presentation/shared/utils/failure_snackbar_handler.dart';
import '../../../core/presentation/shared/widgets/watch_button_icon_widget.dart';
import 'components/create_account_modality.dart';
import 'components/forgot_password_modality.dart';
import 'notifiers/login_form_state_notifier.dart';
import 'notifiers/sign_in_email_password_notifier.dart';
import 'widgets/login_input_widget.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _ = ref.watch(
      loginFormStateNotifierProvider.notifier,
    );

    ref.listen(
      signInEmailAndPasswordNotifierProvider,
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

    return Scaffold(
      backgroundColor: AppColors.greenLight,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 400,
              child: Hero(
                tag: 'watch-onboarding',
                child: Image.asset(AppImages.onboardingWatch),
              ),
            ),
          ),
          const _LoginPageMainContent(),
        ],
      ),
    );
  }
}

class _LoginPageMainContent extends HookConsumerWidget {
  const _LoginPageMainContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginFormStateNotifier = ref.watch(
      loginFormStateNotifierProvider.notifier,
    );
    final signInEmailPasswordNotifier = ref.watch(
      signInEmailAndPasswordNotifierProvider.notifier,
    );

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            WatchLoginInputWidget(
              label: 'E-mail',
              controller: loginFormStateNotifier.emailController,
              validator: (value) {
                loginFormStateNotifier.changeEmailAddress(value);
                if (!loginFormStateNotifier.emailIsValid) {
                  return 'Please insert a valid email';
                }
                return null;
              },
            ),
            AppSpacing.vertical(32),
            WatchLoginInputWidget(
              label: 'Password',
              controller: loginFormStateNotifier.passwordController,
              obscureText: true,
              validator: (value) {
                loginFormStateNotifier.changePassword(value);
                if (!loginFormStateNotifier.passwordIsValid &&
                    value.isNotEmpty) {
                  return 'Please insert minimum 6 characters';
                }
                return null;
              },
            ),
            AppSpacing.vertical(12),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                const ForgotPasswordModality().show(context);
              },
              child: Text(
                'Forgot password?',
                style: GoogleFonts.poppins(
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
            AppSpacing.vertical(48),
            Consumer(
              builder: (_, cRef, __) {
                final state = cRef.watch(
                  signInEmailAndPasswordNotifierProvider,
                );
                final formState = cRef.watch(
                  loginFormStateNotifierProvider,
                );
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Hero(
                      tag: 'button-animation',
                      child: WatchButtonIconWidget(
                        icon: Icons.arrow_forward_ios_rounded,
                        busy: state.maybeWhen(
                          loadInProgress: () => true,
                          orElse: () => false,
                        ),
                        onTap: formState.loginCanSubmit
                            ? () async {
                                signInEmailPasswordNotifier
                                    .signInEmailAndPassword(
                                  loginFormStateNotifier.last.email,
                                  loginFormStateNotifier.last.password,
                                );
                              }
                            : null,
                      ),
                    ),
                  ],
                );
              },
            ),
            AppSpacing.vertical(48),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Doesn’t have an account?',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    const CreateAccountModality().show(context);
                  },
                  child: Text(
                    ' sign up',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: AppColors.golden,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
