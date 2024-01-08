import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/presentation/shared/common/app_spacing.dart';
import '../../../core/presentation/shared/widgets/app_bar_widget.dart';
import '../../../core/presentation/shared/widgets/menu_bottom_bar_widget.dart';
import '../../../core/presentation/shared/widgets/watch_input_widget.dart';
import '../domain/usecase/watches_list_use_case.dart';
import 'common/filter_list.dart';
import 'components/filter_card_component.dart';
import 'components/product_card_component.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = useState<FilterList>(filterList[0]);
    final filterValue = useState<String>('');
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: AppBarWidget(),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 40,
                    horizontal: 24,
                  ),
                  child: WatchInputWidget(
                    label: 'Search',
                    onChanged: (value) {
                      if (filter.value == filterList[1]) {
                        filterValue.value = value;
                      }
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: FilterCardComponent(
                  onTap: (value) {
                    filter.value = value;
                  },
                  selectedFilter: filter.value,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 40,
                  ),
                  child: ProductCardComponent(
                    filterParams: FilterParams(
                      orderBy: filter.value == filterList[2],
                    ),
                  ),
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
