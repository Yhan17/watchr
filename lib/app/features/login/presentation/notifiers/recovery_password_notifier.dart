import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/domain/failures/failures.dart';
import '../../../../core/domain/usecases/recovery_password_use_case.dart';
import '../../../../core/domain/value_objects/email_address/email_address_value.dart';
import '../../../../core/presentation/shared/common/common_state.dart';
import '../../../../core/providers/use_case_provider.dart';

typedef RecoveryPasswordState = CommonState<Failures, Unit>;

class RecoveryPasswordNotifier extends StateNotifier<RecoveryPasswordState> {
  final RecoveryPasswordUseCase _useCase;
  RecoveryPasswordNotifier(this._useCase)
      : super(const RecoveryPasswordState.initial());

  Future<void> recoveryPassword(EmailAddressValue email) async {
    state = const RecoveryPasswordState.loadInProgress();

    final result = await _useCase.call(email);

    state = result.fold(
      RecoveryPasswordState.loadFailure,
      RecoveryPasswordState.loadSuccess,
    );
  }
}

final recoveryPasswordNotifierProvider = StateNotifierProvider.autoDispose<
    RecoveryPasswordNotifier, RecoveryPasswordState>(
  (ref) => RecoveryPasswordNotifier(
    ref.read(recoveryPasswordUseCaseProvider),
  ),
);
