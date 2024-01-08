import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../../../core/presentation/routes/app_routes.dart';
import '../../../core/presentation/shared/theme/app_animations.dart';
import '../../../core/presentation/shared/theme/app_colors.dart';
import '../utils/splash_debouncer.dart';
import 'notifiers/splash_notifier.dart';

class SplashPage extends HookConsumerWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final splashNotifier = ref.watch(splashNotifierProvider.notifier);
    final splashDebouncer = useMemoized(() => SplashDebouncer());
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        splashDebouncer.start();
        splashNotifier.getCurrentUser();
      });
      return null;
    }, const []);

    ref.listen(
      splashNotifierProvider,
      (_, state) {
        splashDebouncer.run(() {
          if (state != null) {
            AppRoutes.home.pushAndResetStack(context, arguments: noArgs);
          } else {
            AppRoutes.onboarding.pushAndResetStack(context, arguments: noArgs);
          }
        });
      },
    );

    const double size = 300;
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Hero(
          tag: 'button-animation',
          child: Container(
            color: AppColors.golden,
            child: Center(
              child: SizedBox(
                height: size,
                width: size,
                child: Lottie.asset(
                  AppAnimations.animations,
                  animate: true,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
