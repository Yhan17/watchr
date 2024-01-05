// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../theme/app_colors.dart';

class WatchButtonIconWidget extends HookWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final double size;
  final Color backgroundColor;
  final Color iconColor;

  const WatchButtonIconWidget({
    Key? key,
    required this.icon,
    required this.onTap,
    this.size = 20,
    this.backgroundColor = AppColors.golden,
    this.iconColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLoading = useState<bool>(false);

    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: backgroundColor.withOpacity(.8),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 7), // changes position of shadow
          ),
        ],
      ),
      child: Material(
        color: backgroundColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
        child: InkWell(
          splashColor: backgroundColor.withOpacity(.5),
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
          onTap: onTap != null
              ? () {
                  isLoading.value = true;
                  onTap!();
                  isLoading.value = false;
                }
              : null,
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: size - 2,
              horizontal: size,
            ),
            child: Center(
              child: !isLoading.value
                  ? Icon(
                      icon,
                      color: iconColor,
                    )
                  : const CircularProgressIndicator(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
