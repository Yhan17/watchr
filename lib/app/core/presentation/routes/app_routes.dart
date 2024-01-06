import '../../../features/login/presentation/login_page.dart';
import '../../../features/onboarding/presentation/onboarding_page.dart';
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

  static final routes = routeMapFrom([
    splash,
    onboarding,
    login,
  ]);
}
