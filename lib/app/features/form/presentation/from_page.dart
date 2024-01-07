import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/presentation/router/config.dart';
import 'routes/watch_form_routes.dart';

class FormPage extends HookConsumerWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigatorKey = useMemoized<GlobalKey>(
      () => GlobalKey<NavigatorState>(),
    );

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: AppRouter(WatchFormRoutes.routes).onGenerateRoutes,
    );
  }
}
