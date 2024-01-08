import '../../../features/details/presentation/watch_details_page.dart';
import '../../../features/home/presentation/home_page.dart';
import '../../../features/login/presentation/login_page.dart';
import '../../../features/onboarding/presentation/onboarding_page.dart';
import '../../../features/profile/presentation/profile_page.dart';
import '../../../features/splash/presentation/splash_page.dart';
import '../../../features/watch_form/presentation/form_page.dart';
import '../../domain/entities/watch_entity.dart';
import '../router/animations/slide_transition_animation.dart';
import '../router/config.dart';
import '../router/page_router.dart';
import 'params/form_params.dart';

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

  static final details = AppPageRoute<WatchEntity>(
    path: '/details',
    pageBuilder: (entity) => WatchDetailsPage(
      watchEntity: entity as WatchEntity,
    ),
  );

  static final profile = AppPageRoute<NoArgs>(
    path: '/profile',
    pageBuilder: (_) => const ProfilePage(),
  );

  static final form = AppPageRoute<FormParams>(
    path: '/form',
    pageBuilder: (entity) => FormPage(
      watchEntity: (entity as FormParams).watchEntity,
    ),
  );

  static final routes = routeMapFrom([
    splash,
    onboarding,
    login,
    home,
    details,
    profile,
    form,
  ]);
}
