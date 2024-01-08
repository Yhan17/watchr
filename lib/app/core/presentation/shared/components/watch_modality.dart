import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../common/app_spacing.dart';
import '../theme/app_colors.dart';

abstract class WatchModality<T> extends HookConsumerWidget {
  final bool isScrollControlled;
  final EdgeInsets contentPadding;
  final Key? scaffoldKey;
  final String? name;
  final Color modalityColor;
  const WatchModality({
    this.scaffoldKey,
    this.name,
    this.contentPadding = const EdgeInsets.symmetric(
      vertical: 20,
    ),
    this.isScrollControlled = true,
    this.modalityColor = AppColors.modalityColor,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final windowMediaQuery = MediaQueryData.fromView(
      View.of(context),
    );
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.decelerate,
      constraints: BoxConstraints(maxHeight: windowMediaQuery.size.height * .9),
      decoration: BoxDecoration(
        color: modalityColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppSpacing.vertical(32),
            buildContent(context, ref),
          ],
        ),
      ),
    );
  }

  Widget buildContent(BuildContext context, WidgetRef ref);

  Future<T?> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => this,
      isScrollControlled: isScrollControlled,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      routeSettings: RouteSettings(name: name),
      barrierColor: AppColors.darkGreen.withOpacity(.25),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
    );
  }
}
