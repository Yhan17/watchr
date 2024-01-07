import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/presentation/shared/common/app_spacing.dart';
import '../../../../../core/presentation/shared/theme/app_colors.dart';
import '../../../../../core/presentation/shared/utils/double_range_input_formatter.dart';
import '../../../../../core/presentation/shared/utils/number_range_input_formatter.dart';
import '../../../../../core/presentation/shared/widgets/watch_button_text_widget.dart';
import '../../../../../core/presentation/shared/widgets/watch_input_widget.dart';
import '../../notifiers/watch_form_state_notifier.dart';
import '../default_form_scaffold.dart';

class PriceStep extends HookConsumerWidget {
  const PriceStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watchFormStateNotifier = ref.watch(
      watchFormStateNotifierProvider.notifier,
    );
    final canSubmit = ref.watch(
      watchFormStateNotifierProvider.select((value) => value.canSubmit),
    );
    final quantity = useState<int>(0);
    final price = useState<double>(0);
    return DefaultFormScaffold(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24).copyWith(
              top: 64,
            ),
            child: WatchInputWidget(
              label: 'Code',
              onChanged: watchFormStateNotifier.codeChange,
              inputFormatters: [
                LengthLimitingTextInputFormatter(8),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ).copyWith(
              top: 64,
            ),
            child: WatchInputWidget(
              label: 'Quantity',
              inputType: TextInputType.number,
              inputFormatters: [
                NumberRangeInputFormatter(),
              ],
              onChanged: (value) {
                watchFormStateNotifier.quantityChange(value);
                quantity.value = int.parse(value);
              },
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24).copyWith(
              top: 64,
            ),
            child: WatchInputWidget(
              inputType: const TextInputType.numberWithOptions(decimal: true),
              label: 'Price',
              inputFormatters: [
                DoubleRangeInputFormatter(),
              ],
              onChanged: (value) {
                watchFormStateNotifier.priceChange(value);
                price.value = double.parse(value);
              },
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: canSubmit
              ? Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24).copyWith(
                    top: 32,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: const BoxDecoration(
                    color: AppColors.darkGreen,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total in stock:',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.golden,
                        ),
                      ),
                      Text(
                        '\$ ${quantity.value * price.value}',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.golden,
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        ),
        SliverToBoxAdapter(
          child: AppSpacing.vertical(52),
        ),
        SliverToBoxAdapter(
          child: Text(
            'What about money?',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SliverToBoxAdapter(
          child: AppSpacing.vertical(32),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'limited money and resources can provide high demand',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: AppSpacing.vertical(128),
        ),
      ],
      bottomBarWidget: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'back',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: AppColors.golden,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24).copyWith(
              bottom: 32,
            ),
            child: WatchButtonTextWidget(
              onTap: canSubmit ? () {} : null,
              text: 'Submit',
            ),
          ),
        ],
      ),
    );
  }
}
