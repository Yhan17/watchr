import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/presentation/routes/app_routes.dart';
import '../../../core/presentation/shared/common/app_spacing.dart';
import '../../../core/presentation/shared/theme/app_colors.dart';
import '../../../core/presentation/shared/theme/app_images.dart';
import '../../../core/presentation/shared/widgets/watch_button_icon_widget.dart';
import 'components/create_account_modality.dart';
import 'components/forgot_password_modality.dart';
import 'widgets/login_input_widget.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

class _LoginPageMainContent extends StatelessWidget {
  const _LoginPageMainContent();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const WatchLoginInputWidget(
              label: 'E-mail',
            ),
            AppSpacing.vertical(32),
            WatchLoginInputWidget(
              label: 'Password',
              validator: (value) {
                if (value.length >= 2) {
                  return 'teste';
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WatchButtonIconWidget(
                  icon: Icons.arrow_forward_ios_rounded,
                  onTap: () async {
                    AppRoutes.home.pushReplacement(
                      context,
                      arguments: noArgs,
                    );
                  },
                ),
              ],
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
