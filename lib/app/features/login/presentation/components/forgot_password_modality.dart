import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/domain/value_objects/email_address/email_address_value.dart';
import '../../../../core/presentation/shared/common/app_spacing.dart';
import '../../../../core/presentation/shared/components/watch_modality.dart';
import '../../../../core/presentation/shared/widgets/watch_button_text_widget.dart';
import '../notifiers/recovery_password_notifier.dart';
import '../widgets/login_input_widget.dart';

class ForgotPasswordModality extends WatchModality {
  const ForgotPasswordModality({
    super.key,
    super.name = 'forgot-password-modality',
  });

  @override
  Widget buildContent(BuildContext context, WidgetRef ref) {
    final recoveryPasswordNotifier = ref.watch(
      recoveryPasswordNotifierProvider.notifier,
    );
    final email = useState<EmailAddressValue>(EmailAddressValue(''));
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
          WatchLoginInputWidget(
            label: 'E-mail',
            validator: (value) {
              email.value = EmailAddressValue(value);
              if (!email.value.isValid) {
                return 'Please insert a valid email';
              }
              return null;
            },
          ),
          AppSpacing.vertical(32),
          Consumer(
            builder: (_, cRef, __) {
              final state = cRef.watch(recoveryPasswordNotifierProvider);
              return WatchButtonTextWidget(
                text: 'Submit',
                busy: state.maybeWhen(
                  loadInProgress: () => true,
                  orElse: () => false,
                ),
                onTap: email.value.isValid
                    ? () {
                        recoveryPasswordNotifier.recoveryPassword(email.value);
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
