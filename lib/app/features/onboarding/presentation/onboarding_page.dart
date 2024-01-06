import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/presentation/routes/app_routes.dart';
import '../../../core/presentation/shared/common/app_spacing.dart';
import '../../../core/presentation/shared/theme/app_colors.dart';
import '../../../core/presentation/shared/theme/app_images.dart';
import '../../../core/presentation/shared/widgets/watch_button_text_widget.dart';

class OnboardingPage extends HookWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greenLight,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 24,
        ),
        child: Column(
          children: [
            Hero(
              tag: 'watch-onboarding',
              child: Image.asset(AppImages.onboardingWatch),
            ),
            AppSpacing.vertical(20),
            Text.rich(
              TextSpan(
                text: 'Do not waste time \n',
                children: [
                  TextSpan(
                    text: 'Sell it',
                    style: GoogleFonts.poppins(
                      color: AppColors.golden,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            AppSpacing.vertical(48),
            Hero(
              tag: 'button-animation',
              child: Row(
                children: [
                  Expanded(
                    child: WatchButtonTextWidget(
                      onTap: () {
                        AppRoutes.login.pushReplacement(
                          context,
                          arguments: noArgs,
                        );
                      },
                      text: 'Get Started',
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
