import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/presentation/shared/common/app_spacing.dart';
import '../common/filter_list.dart';
import '../widgets/filter_button_widget.dart';

class FilterCardComponent extends HookWidget {
  const FilterCardComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 132,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Filters',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            AppSpacing.vertical(24),
            SizedBox(
              height: 64,
              child: Row(
                children: [
                  Expanded(
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        final filter = filterList[index];
                        return FilterButtonWidget(
                          icon: filter.icon,
                        );
                      },
                      separatorBuilder: (_, index) => AppSpacing.horizontal(
                        32,
                      ),
                      itemCount: filterList.length,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
