import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class WatchDeleteButtonWidget extends StatelessWidget {
  final double size;
  const WatchDeleteButtonWidget({
    super.key,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
