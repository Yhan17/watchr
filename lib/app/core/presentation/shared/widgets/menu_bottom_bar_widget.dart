import 'package:flutter/material.dart';

import '../../observers/app_nav_observer.dart';
import '../../routes/app_routes.dart';
import '../theme/app_colors.dart';

class MenuBottomBarWidget extends StatelessWidget {
  const MenuBottomBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 24,
        ).copyWith(bottom: 16),
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 32,
        ),
        decoration: const BoxDecoration(
          color: AppColors.darkGreen,
          borderRadius: BorderRadius.all(
            Radius.circular(24),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                final navStack = AppNavObserver().navStack;
                final routeSettings = navStack.isEmpty ? null : navStack.last;
                if (routeSettings != null) {
                  if (routeSettings.name == '/home') {
                    return;
                  }
                  AppRoutes.home.pushReplacement(context, arguments: noArgs);
                } else {
                  AppRoutes.home.pushReplacement(context, arguments: noArgs);
                }
              },
              child: const Icon(
                Icons.home_rounded,
                color: AppColors.golden,
              ),
            ),
            const Icon(
              Icons.line_axis_outlined,
              color: AppColors.golden,
            ),
            GestureDetector(
              onTap: () {
                final navStack = AppNavObserver().navStack;
                final routeSettings = navStack.isEmpty ? null : navStack.last;
                if (routeSettings != null) {
                  if (routeSettings.name == '/profile') {
                    return;
                  }
                  AppRoutes.profile.pushReplacement(context, arguments: noArgs);
                } else {
                  AppRoutes.profile.pushReplacement(context, arguments: noArgs);
                }
              },
              child: const Icon(
                Icons.person_2_rounded,
                color: AppColors.golden,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
