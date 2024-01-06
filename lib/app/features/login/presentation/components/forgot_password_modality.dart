import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/presentation/shared/common/app_spacing.dart';
import '../../../../core/presentation/shared/components/watch_modality.dart';
import '../../../../core/presentation/shared/widgets/watch_button_text_widget.dart';
import '../widgets/login_input_widget.dart';

class ForgotPasswordModality extends WatchModality {
  const ForgotPasswordModality({
    super.key,
    super.name = 'forgot-password-modality',
  });

  @override
  Widget buildContent(BuildContext context, WidgetRef ref) {
    return Flexible(
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          Text(
            'Forgot Password',
            style: GoogleFonts.poppins(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          AppSpacing.vertical(32),
          const WatchLoginInputWidget(label: 'E-mail'),
          AppSpacing.vertical(32),
          const WatchButtonTextWidget(text: 'Submit'),
          AppSpacing.vertical(32),
        ],
      ),
    );
  }
}
