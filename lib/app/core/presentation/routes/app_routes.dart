import 'package:flutter/material.dart';

import '../router/config.dart';
import '../router/page_router.dart';

export '../router/config.dart' show PageRouteNavigation, noArgs;

abstract class AppRoutes {
  static final splash = AppPageRoute<NoArgs>(
    path: '/',
    pageBuilder: (_) => const SizedBox.shrink(),
  );

  static final routes = routeMapFrom([splash]);
}
