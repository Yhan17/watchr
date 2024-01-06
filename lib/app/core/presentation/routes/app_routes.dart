import '../../../features/details/presentation/watch_details_page.dart';
import '../../../features/home/presentation/home_page.dart';
import '../../../features/login/presentation/login_page.dart';
import '../../../features/onboarding/presentation/onboarding_page.dart';
import '../../../features/profile/presentation/profile_page.dart';
import '../../../features/splash/presentation/splash_page.dart';
import '../router/animations/slide_transition_animation.dart';
import '../router/config.dart';
import '../router/page_router.dart';

export '../router/config.dart' show PageRouteNavigation, noArgs;

abstract class AppRoutes {
  static final splash = AppPageRoute<NoArgs>(
    path: '/',
    pageBuilder: (_) => const SplashPage(),
  );
  static final onboarding = AppPageRoute<NoArgs>(
    path: '/onboarding',
    pageBuilder: (_) => const OnboardingPage(),
    routeTransition: SlideTransitionAnimation(),
  );
  static final login = AppPageRoute<NoArgs>(
    path: '/login',
    pageBuilder: (_) => const LoginPage(),
  );
  static final home = AppPageRoute<NoArgs>(
    path: '/home',
    pageBuilder: (_) => const HomePage(),
  );
  static final details = AppPageRoute<NoArgs>(
    path: '/details',
    pageBuilder: (_) => const WatchDetailsPage(),
  );
  static final profile = AppPageRoute<NoArgs>(
    path: '/profile',
    pageBuilder: (_) => const ProfilePage(),
  );

  static final routes = routeMapFrom([
    splash,
    onboarding,
    login,
    home,
    details,
    profile,
  ]);
}
