import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../routes/app_routes.dart';
import '../theme/app_colors.dart';
import 'app_bar_button_widget.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: 64,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const AppBarButtonWidget(
                icon: Icons.menu_rounded,
              ),
              Text(
                'WatchR',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              AppBarButtonWidget(
                onTap: () {
                  AppRoutes.form.push(context, arguments: noArgs);
                },
                icon: Icons.add_rounded,
                backgroundColor: AppColors.darkGreen,
                iconColor: AppColors.golden,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
