import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/presentation/router/config.dart';
import '../../../../../core/presentation/shared/common/app_spacing.dart';
import '../../../../../core/presentation/shared/theme/app_colors.dart';
import '../../../../../core/presentation/shared/widgets/watch_button_text_outlined_widget.dart';
import '../../../../../core/presentation/shared/widgets/watch_input_widget.dart';
import '../../notifiers/watch_form_state_notifier.dart';
import '../../routes/watch_form_routes.dart';
import '../default_form_scaffold.dart';

class NameStep extends HookConsumerWidget {
  const NameStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watchFormStateNotifier = ref.watch(
      watchFormStateNotifierProvider.notifier,
    );
    final nameCanContinue = ref.watch(
      watchFormStateNotifierProvider.select((value) => value.nameCanContinue),
    );
    return DefaultFormScaffold(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24).copyWith(
              top: 64,
            ),
            child: WatchInputWidget(
              label: 'Name',
              onChanged: watchFormStateNotifier.nameChange,
              inputFormatters: [
                LengthLimitingTextInputFormatter(20),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: AppSpacing.vertical(4),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24).copyWith(
              top: 64,
            ),
            child: WatchInputWidget(
              label: 'Desc',
              maxLines: 4,
              onChanged: watchFormStateNotifier.descChange,
              inputFormatters: [
                LengthLimitingTextInputFormatter(150),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: AppSpacing.vertical(52),
        ),
        SliverToBoxAdapter(
          child: Text(
            'Nameless?',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SliverToBoxAdapter(
          child: AppSpacing.vertical(32),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'that’s not a good idea, please tell us what’s name and desc for your product',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
      bottomBarWidget: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'back',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: AppColors.golden,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24).copyWith(
              bottom: 32,
            ),
            child: WatchButtonTextOutlinedWidget(
              onTap: nameCanContinue
                  ? () {
                      WatchFormRoutes.priceStep.push(
                        context,
                        arguments: noArgs,
                      );
                    }
                  : null,
              text: 'Next',
            ),
          ),
        ],
      ),
    );
  }
}
