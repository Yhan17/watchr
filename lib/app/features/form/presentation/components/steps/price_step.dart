import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/presentation/shared/common/app_spacing.dart';
import '../../../../../core/presentation/shared/theme/app_colors.dart';
import '../../../../../core/presentation/shared/widgets/watch_button_text_widget.dart';
import '../../../../../core/presentation/shared/widgets/watch_input_widget.dart';
import '../default_form_scaffold.dart';

class PriceStep extends HookConsumerWidget {
  const PriceStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultFormScaffold(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24).copyWith(
              top: 64,
            ),
            child: const WatchInputWidget(label: 'Code'),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24).copyWith(
              top: 64,
            ),
            child: const WatchInputWidget(label: 'Quantity'),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24).copyWith(
              top: 64,
            ),
            child: const WatchInputWidget(label: 'Price'),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24).copyWith(
              top: 32,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            decoration: const BoxDecoration(
              color: AppColors.darkGreen,
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total in stock:',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.golden,
                  ),
                ),
                Text(
                  r'$865.00',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.golden,
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: AppSpacing.vertical(52),
        ),
        SliverToBoxAdapter(
          child: Text(
            'What about money?',
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
              'limited money and resources can provide high demand',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: AppSpacing.vertical(128),
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
            child: WatchButtonTextWidget(
              onTap: () {},
              text: 'Submit',
            ),
          ),
        ],
      ),
    );
  }
}
