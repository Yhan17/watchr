import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/presentation/shared/common/app_spacing.dart';
import '../../../core/presentation/shared/theme/app_colors.dart';
import '../../../core/presentation/shared/widgets/watch_input_widget.dart';
import 'components/filter_card_component.dart';
import 'components/product_card_component.dart';
import 'widgets/app_bar_widget.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: AppBarWidget(),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 40,
                    horizontal: 24,
                  ),
                  child: WatchInputWidget(
                    label: 'Search',
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: FilterCardComponent(),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 40,
                  ),
                  child: ProductCardComponent(),
                ),
              ),
              SliverToBoxAdapter(
                child: AppSpacing.vertical(128),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 24,
              ).copyWith(bottom: 16),
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 32,
              ),
              decoration: const BoxDecoration(
                color: AppColors.darkGreen,
                borderRadius: BorderRadius.all(
                  Radius.circular(24),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.home_rounded,
                    color: AppColors.golden,
                  ),
                  Icon(
                    Icons.line_axis_outlined,
                    color: AppColors.golden,
                  ),
                  Icon(
                    Icons.person_2_rounded,
                    color: AppColors.golden,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
