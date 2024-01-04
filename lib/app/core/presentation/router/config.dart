import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import 'page_router.dart';
part 'page_navigator.dart';

class AppRouter {
  final IMap<String, AppPageRoute> routes;

  const AppRouter(this.routes);

  Route onGenerateRoutes(RouteSettings settings) {
    final Object arguments = settings.arguments ?? noArgs;

    final possibleRoute = routes.get(settings.name!);

    return possibleRoute.fold(
      () => throw Exception('Page ${settings.name} not found!'),
      (route) {
        late final Route pageRoute;
        if (route.routeTransition != null) {
          final routeTransitions = route.routeTransition!;
          pageRoute = PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => route.pageBuilder(arguments),
            transitionDuration: routeTransitions.transitionDuration,
            reverseTransitionDuration:
                routeTransitions.reverseTransitionDuration,
            transitionsBuilder: routeTransitions.transitionBuilder,
          );
        } else {
          pageRoute = MaterialPageRoute(
            builder: (_) => route.pageBuilder(arguments),
          );
        }

        return pageRoute;
      },
    );
  }
}

IMap<String, AppPageRoute> routeMapFrom(List<AppPageRoute> routes) {
  return imap({for (final route in routes) route.path: route});
}
