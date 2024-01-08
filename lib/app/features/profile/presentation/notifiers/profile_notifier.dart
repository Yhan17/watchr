import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/domain/usecases/verify_if_logged_use_case.dart';
import '../../../../core/providers/use_case_provider.dart';
import '../../../../core/usecase/use_case.dart';

class ProfileNotifier extends StateNotifier<User?> {
  final VerifyIfLoggedUseCase _useCase;
  ProfileNotifier(this._useCase) : super(null);

  Future<void> getCurrentUser() async {
    final result = await _useCase.call(noParams);

    state = result.fold(
      () => null,
      (user) => user,
    );
  }
}

final profileNotifierProvider =
    StateNotifierProvider.autoDispose<ProfileNotifier, User?>(
  (ref) => ProfileNotifier(
    ref.read(verifyIfLoggedUseCaseProvider),
  ),
);
