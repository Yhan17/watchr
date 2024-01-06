import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/presentation/shared/theme/app_colors.dart';

class FilterButtonWidget extends HookWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  const FilterButtonWidget({
    Key? key,
    required this.icon,
    this.backgroundColor = Colors.white,
    this.iconColor = AppColors.golden,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minWidth: 64,
        minHeight: 64,
        maxHeight: 64,
        maxWidth: 64,
      ),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
        border: Border.all(
          color: AppColors.greyLighter.withOpacity(.5),
        ),
      ),
      child: Icon(
        icon,
        size: 32,
        color: iconColor,
      ),
    );
  }
}
