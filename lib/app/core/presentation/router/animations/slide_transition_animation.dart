import 'package:flutter/material.dart';

import '../page_router.dart';

class SlideTransitionAnimation extends RouteTransition {
  @override
  Duration get reverseTransitionDuration => const Duration(seconds: 10);

  @override
  Duration get transitionDuration => const Duration(seconds: 10);

  @override
  Widget transitionBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const begin = Offset(1, 0);
    const end = Offset.zero;
    var tween = Tween(begin: begin, end: end);
    var offsetAnimation = animation.drive(tween);
    return SlideTransition(
      position: offsetAnimation,
      child: child,
    );
  }
}
