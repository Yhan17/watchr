import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/domain/usecases/verify_if_logged_use_case.dart';
import '../../../../core/providers/use_case_provider.dart';
import '../../../../core/usecase/use_case.dart';

class SplashNotifier extends StateNotifier<Option<User?>?> {
  final VerifyIfLoggedUseCase _useCase;
  SplashNotifier(this._useCase) : super(null);

  Future<void> getCurrentUser() async {
    final result = await _useCase.call(noParams);

    state = result;
  }
}

final splashNotifierProvider =
    StateNotifierProvider.autoDispose<SplashNotifier, Option<User?>?>(
  (ref) => SplashNotifier(
    ref.read(verifyIfLoggedUseCaseProvider),
  ),
);
