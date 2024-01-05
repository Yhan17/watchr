import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lottie/lottie.dart';

import '../../../core/presentation/routes/app_routes.dart';
import '../../../core/presentation/shared/theme/app_animations.dart';
import '../../../core/presentation/shared/theme/app_colors.dart';

class SplashPage extends HookWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(const Duration(seconds: 5), () {
          AppRoutes.onboarding.pushAndResetStack(context, arguments: noArgs);
        });
      });
      return null;
    }, const []);

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
