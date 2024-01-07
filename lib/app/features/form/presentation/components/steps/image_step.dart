import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/presentation/routes/app_routes.dart';
import '../../../../../core/presentation/shared/common/app_spacing.dart';
import '../../../../../core/presentation/shared/theme/app_colors.dart';
import '../../../../../core/presentation/shared/widgets/watch_button_text_outlined_widget.dart';
import '../../routes/watch_form_routes.dart';
import '../default_form_scaffold.dart';

class ImageStep extends HookConsumerWidget {
  const ImageStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultFormScaffold(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.all(122),
            margin: const EdgeInsets.symmetric(
              horizontal: 24,
            ).copyWith(top: 64),
            decoration: const BoxDecoration(
              color: AppColors.greyLight,
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.photo_rounded,
                color: AppColors.brownLight,
                size: 64,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: AppSpacing.vertical(52),
        ),
        SliverToBoxAdapter(
          child: Text(
            'What time is it?',
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
          child: Text(
            'insert an image of your watch adn we will do the rest',
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
      bottomBarWidget: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24).copyWith(
              bottom: 32,
            ),
            child: WatchButtonTextOutlinedWidget(
              onTap: () {
                WatchFormRoutes.nameStep.push(
                  context,
                  arguments: noArgs,
                );
              },
              text: 'Next',
            ),
          ),
        ],
      ),
    );
  }
}
