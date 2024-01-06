import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/presentation/shared/common/app_spacing.dart';
import '../widgets/product_card_widget.dart';

class ProductCardComponent extends HookWidget {
  const ProductCardComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Products',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          AppSpacing.vertical(24),
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 300,
            ),
            child: Row(
              children: [
                Expanded(
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      return const ProductCardWidget();
                    },
                    separatorBuilder: (_, index) => AppSpacing.horizontal(
                      32,
                    ),
                    itemCount: 3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
