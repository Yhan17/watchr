import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/domain/entities/watch_entity.dart';
import '../../../core/presentation/routes/app_routes.dart';
import '../../../core/presentation/shared/common/app_spacing.dart';
import '../../../core/presentation/shared/theme/app_colors.dart';
import '../../../core/presentation/shared/widgets/watch_button_text_widget.dart';
import 'widgets/app_bar_details_widget.dart';

class WatchDetailsPage extends HookConsumerWidget {
  final WatchEntity watchEntity;
  const WatchDetailsPage({
    Key? key,
    required this.watchEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        children: [
          _DetailsGreenSideContent(watchEntity),
          AppBarDetailsWidget(
            watchEntity: watchEntity,
          ),
          Row(
            children: [
              const Expanded(
                flex: 8,
                child: SizedBox.shrink(),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    watchEntity.imageStoragePath,
                    width: 200,
                  ),
                ],
              ),
              const Expanded(
                child: SizedBox.shrink(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DetailsGreenSideContent extends StatelessWidget {
  final WatchEntity entity;
  const _DetailsGreenSideContent(this.entity);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            color: AppColors.darkGreen,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: AppSpacing.vertical(64),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 64,
                      horizontal: 24,
                    ),
                    child: Text(
                      entity.name,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: 1,
                    (context, index) {
                      return Container(
                        constraints: const BoxConstraints(
                          maxHeight: 200,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text(
                                entity.description,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SliverToBoxAdapter(
                  child: AppSpacing.vertical(12),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                    ),
                    child: Row(
                      children: [
                        Container(
                          constraints: const BoxConstraints(),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: const BoxDecoration(
                            color: AppColors.greyLight,
                            borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.store_rounded,
                                color: AppColors.brownLight,
                              ),
                              AppSpacing.horizontal(12),
                              Text(
                                entity.stockQuantity.toString(),
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: AppColors.brownLight,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: AppSpacing.vertical(48),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      '\$ ${entity.price}',
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: AppSpacing.vertical(80),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: WatchButtonTextWidget(
                      text: 'Edit',
                      onTap: () {
                        AppRoutes.form.push(
                          context,
                          arguments: entity,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
