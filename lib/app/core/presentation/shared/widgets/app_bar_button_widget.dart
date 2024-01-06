import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../theme/app_colors.dart';

class AppBarButtonWidget extends HookWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final VoidCallback? onTap;
  const AppBarButtonWidget({
    Key? key,
    required this.icon,
    this.backgroundColor = AppColors.golden,
    this.iconColor = Colors.white,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        constraints: const BoxConstraints(
          maxHeight: 32,
          maxWidth: 32,
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.golden.withOpacity(.8),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, 7), // changes position of shadow
            ),
          ],
        ),
        child: Icon(
          icon,
          size: 20,
          color: iconColor,
        ),
      ),
    );
  }
}
