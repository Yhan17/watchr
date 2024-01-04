import 'package:riverpod/riverpod.dart';

import '../domain/services/auth_service.dart';
import '../infra/services/auth_service_impl.dart';
import 'core_providers.dart';

final authServiceProvider = Provider.autoDispose<AuthService>(
  (ref) => AuthServiceImpl(
    ref.read(firebaseAuthProvider),
  ),
);
