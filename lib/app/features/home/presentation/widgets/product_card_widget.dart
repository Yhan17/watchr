import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/domain/entities/watch_entity.dart';
import '../../../../core/presentation/routes/app_routes.dart';
import '../../../../core/presentation/shared/common/app_spacing.dart';
import '../../../../core/presentation/shared/components/delete_product_modality.dart';
import '../../../../core/presentation/shared/theme/app_colors.dart';
import '../../../../core/presentation/shared/widgets/watch_delete_button_widget.dart';

class ProductCardWidget extends HookWidget {
  final WatchEntity watchEntity;
  const ProductCardWidget({
    Key? key,
    required this.watchEntity,
  }) : super(key: key);

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
                    arguments: watchEntity,
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
                  child: Image.network(
                    watchEntity.imageStoragePath,
                  ),
                ),
              ),
              Positioned(
                right: 16,
                top: 16,
                child: GestureDetector(
                  onTap: () {
                    DeleteProductModality(
                      watchEntity: watchEntity,
                    ).show(context);
                  },
                  child: WatchDeleteButtonWidget(
                    entity: watchEntity,
                  ),
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
                  watchEntity.name,
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
                    '${watchEntity.stockQuantity}',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: AppColors.darkGreen,
                    ),
                  )
                ],
              ),
            ],
          ),
          AppSpacing.vertical(2),
          Text(
            '\$ ${watchEntity.price}',
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
