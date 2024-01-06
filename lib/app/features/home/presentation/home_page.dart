import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/presentation/shared/common/app_spacing.dart';
import '../../../core/presentation/shared/widgets/app_bar_widget.dart';
import '../../../core/presentation/shared/widgets/menu_bottom_bar_widget.dart';
import '../../../core/presentation/shared/widgets/watch_input_widget.dart';
import 'components/filter_card_component.dart';
import 'components/product_card_component.dart';

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
          const MenuBottomBarWidget()
        ],
      ),
    );
  }
}
