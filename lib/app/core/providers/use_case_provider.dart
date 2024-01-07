import 'package:riverpod/riverpod.dart';

import '../../features/home/domain/usecase/watches_list_use_case.dart';
import '../../features/watch_form/domain/usecase/watch_create_use_case.dart';
import '../../features/watch_form/domain/usecase/watch_edit_use_case.dart';
import '../domain/usecases/sign_in_email_and_password_use_case.dart';
import '../domain/usecases/sign_out_use_case.dart';
import '../domain/usecases/sign_up_email_and_password_use_case.dart';
import '../domain/usecases/verify_if_logged_use_case.dart';
import 'service_provider.dart';

final signInEmailAndPasswordUseCaseProvider = Provider.autoDispose(
  (ref) => SignInEmailAndPasswordUseCase(
    ref.read(authServiceProvider),
  ),
);

final signUpEmailAndPasswordUseCaseProvider = Provider.autoDispose(
  (ref) => SignUpEmailAndPasswordUseCase(
    ref.read(authServiceProvider),
  ),
);

final watchesCreateUseCaseProvider = Provider.autoDispose(
  (ref) => WatchCreateUseCase(
    ref.read(watchCreateServiceProvider),
  ),
);

final watchesListUseCaseProvider = Provider.autoDispose(
  (ref) => WatchesListUseCase(
    ref.read(watchesServiceProvider),
  ),
);

final editWatchUseCaseProvider = Provider.autoDispose(
  (ref) => WatchEditUseCase(
    ref.read(editWatchServiceProvider),
  ),
);

final verifyIfLoggedUseCaseProvider = Provider.autoDispose(
  (ref) => VerifyIfLoggedUseCase(
    ref.read(authServiceProvider),
  ),
);
final signOutUseCaseProvider = Provider.autoDispose(
  (ref) => SignOutUseCase(
    ref.read(authServiceProvider),
  ),
);
