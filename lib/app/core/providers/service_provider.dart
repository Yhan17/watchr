import 'package:riverpod/riverpod.dart';

import '../../features/create_watch/domain/service/watch_create_service.dart';
import '../../features/create_watch/infra/service/watch_create_service_impl.dart';
import '../../features/home/domain/services/watches_service.dart';
import '../../features/home/infra/service/watches_service_impl.dart';
import '../domain/services/auth_service.dart';
import '../infra/services/auth_service_impl.dart';
import 'core_providers.dart';

final authServiceProvider = Provider.autoDispose<AuthService>(
  (ref) => AuthServiceImpl(
    ref.read(firebaseAuthProvider),
  ),
);

final watchCreateServiceProvider = Provider.autoDispose<WatchCreateService>(
  (ref) => WatchCreateServiceImpl(
    ref.read(firestoreProvider),
    ref.read(watchStorageProvider),
    ref.read(uuidProvider),
  ),
);

final watchesServiceProvider = Provider.autoDispose<WatchesService>(
  (ref) => WatchesServiceImpl(
    ref.read(firebaseAuthProvider),
    ref.read(firestoreProvider),
  ),
);
