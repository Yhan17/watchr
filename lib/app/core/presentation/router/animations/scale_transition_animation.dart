import 'package:flutter/material.dart';

import '../page_router.dart';

class ScaleTransitionAnimation extends RouteTransition {
  @override
  Duration get transitionDuration => const Duration(milliseconds: 113);

  @override
  Duration get reverseTransitionDuration => const Duration(milliseconds: 113);

  @override
  Widget transitionBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return ScaleTransition(
      scale: animation,
      child: child,
    );
  }
}
