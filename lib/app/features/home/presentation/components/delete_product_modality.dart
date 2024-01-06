import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/presentation/shared/common/app_spacing.dart';
import '../../../../core/presentation/shared/components/watch_modality.dart';
import '../../../../core/presentation/shared/theme/app_colors.dart';
import '../../../../core/presentation/shared/widgets/watch_button_text_outlined_widget.dart';
import '../../../../core/presentation/shared/widgets/watch_button_text_widget.dart';

class DeleteProductModality extends WatchModality {
  const DeleteProductModality({
    super.key,
    super.name = 'delete-product-modality',
    super.modalityColor = Colors.white,
  });

  @override
  Widget buildContent(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Are tou sure want to delete?',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          AppSpacing.vertical(16),
          const Icon(
            Icons.close,
            size: 90,
            color: AppColors.darkOrange,
          ),
          AppSpacing.vertical(16),
          WatchButtonTextWidget(
            text: 'Confirm',
            onTap: () {},
          ),
          AppSpacing.vertical(16),
          WatchButtonTextOutlinedWidget(
            text: 'Close',
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          AppSpacing.vertical(16),
        ],
      ),
    );
  }
}
