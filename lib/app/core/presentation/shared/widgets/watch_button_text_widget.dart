import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';

class WatchButtonTextWidget extends HookWidget {
  final String text;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color textColor;
  const WatchButtonTextWidget({
    Key? key,
    required this.text,
    this.onTap,
    this.backgroundColor = AppColors.golden,
    this.textColor = Colors.white,
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
            color: onTap != null
                ? backgroundColor.withOpacity(.8)
                : backgroundColor.withOpacity(.25),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 7), // changes position of shadow
          ),
        ],
      ),
      child: Material(
        color:
            onTap != null ? backgroundColor : backgroundColor.withOpacity(.25),
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
            padding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 24,
            ),
            child: Center(
              child: !isLoading.value
                  ? Text(
                      text,
                      style: GoogleFonts.poppins(
                        color: onTap != null
                            ? textColor
                            : textColor.withOpacity(.25),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : const CircularProgressIndicator(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
