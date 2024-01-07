import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/presentation/shared/widgets/app_bar_button_widget.dart';

class DefaultFormScaffold extends HookWidget {
  final List<Widget> slivers;
  final Widget? bottomBarWidget;
  const DefaultFormScaffold({
    Key? key,
    required this.slivers,
    this.bottomBarWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rootNavigator = Navigator.of(context, rootNavigator: true);
    final localNavigator = Navigator.of(context);

    final canPop = rootNavigator.canPop() || localNavigator.canPop();

    if (!canPop) return const SizedBox.shrink();

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                    ).copyWith(top: 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppBarButtonWidget(
                          onTap: () {
                            localNavigator.canPop()
                                ? localNavigator.maybePop()
                                : rootNavigator.maybePop();
                          },
                          icon: Icons.arrow_back_ios_new_rounded,
                        ),
                        Text(
                          'Create/Edit Watch',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox.shrink(),
                      ],
                    ),
                  ),
                ),
              ),
              ...slivers,
            ],
            
          ),
          if(bottomBarWidget != null) ... [
            bottomBarWidget!,
          ] 
        ],
      ),
    );
  }
}
