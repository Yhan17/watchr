import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../features/home/presentation/notifiers/delete_watch_state_notifier.dart';
import '../../../domain/entities/watch_entity.dart';
import '../common/app_spacing.dart';
import '../theme/app_colors.dart';
import '../widgets/watch_button_text_outlined_widget.dart';
import '../widgets/watch_button_text_widget.dart';
import 'watch_modality.dart';

class DeleteProductModality extends WatchModality {
  final WatchEntity watchEntity;
  const DeleteProductModality({
    super.key,
    super.name = 'delete-product-modality',
    required this.watchEntity,
    super.modalityColor = Colors.white,
  });

  @override
  Widget buildContent(BuildContext context, WidgetRef ref) {
    final deleteWatchNotifier = ref.watch(
      deleteWatchStateNotifierProvider.notifier,
    );

    ref.listen(
      deleteWatchStateNotifierProvider,
      (_, state) {
        state.whenOrNull(loadSuccess: (_) {
          Navigator.of(context).pop();
        });
      },
    );

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
            onTap: () {
              deleteWatchNotifier.deleteWatch(watchEntity);
            },
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
