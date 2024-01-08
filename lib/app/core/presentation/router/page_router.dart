import 'package:flutter/material.dart';

typedef PageBuilder = Widget Function(dynamic args);

abstract class RouteTransition {
  Duration get transitionDuration;
  Duration get reverseTransitionDuration;

  Widget transitionBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  );
}

class AppPageRoute<ArgType> {
  final String path;

  final PageBuilder pageBuilder;
  final RouteTransition? routeTransition;
  final bool useRootNavigation;

  const AppPageRoute({
    required this.path,
    required this.pageBuilder,
    this.useRootNavigation = true,
    this.routeTransition,
  });
}
