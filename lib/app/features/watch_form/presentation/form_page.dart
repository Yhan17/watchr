import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/domain/entities/watch_entity.dart';
import '../../../core/presentation/router/config.dart';
import 'notifiers/watch_form_state_notifier.dart';
import 'routes/watch_form_routes.dart';

class FormPage extends HookConsumerWidget {
  final WatchEntity? watchEntity;
  const FormPage({
    Key? key,
    required this.watchEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigatorKey = useMemoized<GlobalKey>(
      () => GlobalKey<NavigatorState>(),
    );
    final formInstance = ref.watch(watchFormStateNotifierProvider.notifier);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        formInstance.changeEditEntity(watchEntity);
      });
      return null;
    }, const []);

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: AppRouter(WatchFormRoutes.routes).onGenerateRoutes,
    );
  }
}
