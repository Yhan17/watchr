import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/presentation/routes/app_routes.dart';
import '../../../../core/presentation/shared/common/app_spacing.dart';
import '../../../../core/presentation/shared/theme/app_colors.dart';
import '../../../../core/presentation/shared/theme/app_images.dart';
import '../../../../core/presentation/shared/widgets/watch_delete_button_widget.dart';
import '../components/delete_product_modality.dart';

class ProductCardWidget extends HookWidget {
  const ProductCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 200,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              GestureDetector(
                onTap: () {
                  AppRoutes.details.push(
                    context,
                    arguments: noArgs,
                  );
                },
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(24),
                    ),
                    color: AppColors.darkGreen,
                  ),
                  child: Image.asset(
                    AppImages.onboardingWatch,
                  ),
                ),
              ),
              Positioned(
                right: 16,
                top: 16,
                child: GestureDetector(
                  onTap: () {
                    const DeleteProductModality().show(context);
                  },
                  child: const WatchDeleteButtonWidget(),
                ),
              )
            ],
          ),
          AppSpacing.vertical(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  'Rolex Top 2019',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: AppColors.darkGreen,
                  ),
                ),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.store_rounded,
                    color: AppColors.golden,
                    size: 24,
                  ),
                  AppSpacing.horizontal(4),
                  Text(
                    '22',
                    style: GoogleFonts.poppins(
                        fontSize: 16, color: AppColors.darkGreen),
                  )
                ],
              ),
            ],
          ),
          AppSpacing.vertical(2),
          Text(
            r'$55.96',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: AppColors.darkGreen,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
