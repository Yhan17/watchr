import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../features/home/presentation/notifiers/delete_watch_state_notifier.dart';
import '../../../domain/entities/watch_entity.dart';
import '../components/delete_product_modality.dart';
import '../theme/app_colors.dart';

class WatchDeleteButtonWidget extends HookConsumerWidget {
  final WatchEntity entity;
  final double size;
  const WatchDeleteButtonWidget({
    super.key,
    this.size = 24,
    required this.entity,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      deleteWatchStateNotifierProvider,
      (_, state) {
        state.whenOrNull(loadSuccess: (_) {
          Navigator.of(context).pop();
        });
      },
    );
    return GestureDetector(
      onTap: () {
        DeleteProductModality(
          watchEntity: entity,
        ).show(context);
      },
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          color: AppColors.greyLight,
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
        ),
        child: Center(
          child: Icon(
            Icons.delete_forever_rounded,
            color: AppColors.brownLight,
            size: size - 8,
          ),
        ),
      ),
    );
  }
}
