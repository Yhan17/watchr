import '../../../../core/presentation/router/config.dart';
import '../../../../core/presentation/router/page_router.dart';
import '../components/steps/image_step.dart';
import '../components/steps/name_step.dart';
import '../components/steps/price_step.dart';

abstract class WatchFormRoutes {
  static final imageStep = AppPageRoute<NoArgs>(
    path: '/',
    useRootNavigation: false,
    pageBuilder: (_) => const ImageStep(),
  );

  static final nameStep = AppPageRoute<NoArgs>(
    path: '/name-step',
    useRootNavigation: false,
    pageBuilder: (_) => const NameStep(),
  );

  static final priceStep = AppPageRoute<NoArgs>(
    path: '/price-step',
    useRootNavigation: false,
    pageBuilder: (_) => const PriceStep(),
  );

  static final routes = routeMapFrom([
    imageStep,
    nameStep,
    priceStep,
  ]);
}
