import 'package:flutter/material.dart';

import '../../../../core/domain/entities/watch_entity.dart';
import '../../../../core/presentation/shared/widgets/app_bar_button_widget.dart';
import '../../../../core/presentation/shared/widgets/watch_delete_button_widget.dart';

class AppBarDetailsWidget extends StatelessWidget {
  final WatchEntity watchEntity;
  const AppBarDetailsWidget({
    super.key,
    required this.watchEntity,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: 64,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppBarButtonWidget(
                onTap: () {
                  Navigator.of(context).pop();
                },
                icon: Icons.arrow_back_ios_rounded,
              ),
              const SizedBox.shrink(),
              WatchDeleteButtonWidget(
                size: 32,
                entity: watchEntity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
