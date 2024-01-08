import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/presentation/routes/app_routes.dart';
import '../../../core/presentation/shared/common/app_spacing.dart';
import '../../../core/presentation/shared/theme/app_colors.dart';
import '../../../core/presentation/shared/widgets/app_bar_widget.dart';
import '../../../core/presentation/shared/widgets/menu_bottom_bar_widget.dart';
import '../../../core/presentation/shared/widgets/watch_button_text_widget.dart';
import 'notifiers/profile_notifier.dart';
import 'notifiers/sign_out_notifier.dart';

class ProfilePage extends HookConsumerWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileNotifier = ref.watch(profileNotifierProvider.notifier);
    final signOutNotifier = ref.watch(signOutNotifierProvider.notifier);

    final user = useState<String>('');

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        profileNotifier.getCurrentUser();
      });
      return null;
    }, const []);

    ref.listen(
      signOutNotifierProvider,
      (_, state) {
        if (state.isSome()) {
          AppRoutes.login.pushAndResetStack(
            context,
            arguments: noArgs,
          );
        }
      },
    );
    ref.listen(
      profileNotifierProvider,
      (_, state) {
        if (state != null) {
          user.value = state.email!;
        }
      },
    );

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: AppBarWidget(),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 56,
                  ),
                  child: CircleAvatar(
                    radius: 75,
                    child: ClipOval(
                      child: Image.network(
                        'https://ui-avatars.com/api/?name=${user.value}',
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Text(
                  user.value,
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: WatchButtonTextWidget(
                  onTap: () {
                    signOutNotifier.signOut();
                  },
                  text: 'Sign Out',
                  backgroundColor: AppColors.darkOrange,
                ),
              ),
              AppSpacing.vertical(20),
              const MenuBottomBarWidget(),
            ],
          )
        ],
      ),
    );
  }
}
