import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/presentation/shared/common/app_spacing.dart';
import '../../domain/usecase/watches_list_use_case.dart';
import '../notifiers/watch_list_state_notifier.dart';
import '../widgets/product_card_widget.dart';

class ProductCardComponent extends HookConsumerWidget {
  final FilterParams filterParams;
  const ProductCardComponent({
    Key? key,
    required this.filterParams,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watchListNotifier = ref.watch(
      watchListStateNotifierProvider.notifier,
    );
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        watchListNotifier.fetchAll();
      });
      return null;
    }, const []);
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
                Consumer(
                  builder: (_, cRef, __) {
                    final state = cRef.watch(watchListStateNotifierProvider);

                    return state.maybeWhen(
                      loadSuccess: (list) {
                        return Expanded(
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (_, index) {
                              final entity = list[index];
                              return ProductCardWidget(
                                watchEntity: entity,
                              );
                            },
                            separatorBuilder: (_, index) =>
                                AppSpacing.horizontal(
                              32,
                            ),
                            itemCount: list.length,
                          ),
                        );
                      },
                      loadFailure: (failure) => Text(
                        failure.message,
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      loadInProgress: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      orElse: () => const SizedBox.shrink(),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
