import 'package:flutter/material.dart';

import '../../../../core/presentation/shared/widgets/app_bar_button_widget.dart';
import '../../../../core/presentation/shared/widgets/watch_delete_button_widget.dart';

class AppBarDetailsWidget extends StatelessWidget {
  const AppBarDetailsWidget({super.key});

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
              const WatchDeleteButtonWidget(size: 32),
            ],
          ),
        ),
      ),
    );
  }
}
