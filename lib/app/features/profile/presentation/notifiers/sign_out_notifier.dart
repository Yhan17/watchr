import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/domain/usecases/sign_out_use_case.dart';
import '../../../../core/providers/use_case_provider.dart';
import '../../../../core/usecase/use_case.dart';

class SignOutNotifier extends StateNotifier<Option<Unit>> {
  final SignOutUseCase _useCase;
  SignOutNotifier(this._useCase) : super(none());

  Future<void> signOut() async {
    final result = await _useCase.call(noParams);

    state = result.fold(
      () => none(),
      (_) => some(unit),
    );
  }
}

final signOutNotifierProvider =
    StateNotifierProvider.autoDispose<SignOutNotifier, Option<Unit>>(
  (ref) => SignOutNotifier(
    ref.read(signOutUseCaseProvider),
  ),
);
