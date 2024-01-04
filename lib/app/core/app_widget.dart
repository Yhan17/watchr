import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'presentation/router/config.dart';
import 'presentation/routes/app_routes.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'WatchR',
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.splash.path,
        onGenerateRoute: AppRouter(AppRoutes.routes).onGenerateRoutes,
      ),
    );
  }
}
