import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/domain/entities/watch_entity.dart';
import '../../../../core/domain/failures/failures.dart';
import '../../../../core/presentation/shared/common/common_state.dart';
import '../../../../core/providers/use_case_provider.dart';
import '../../domain/usecase/watch_edit_use_case.dart';

typedef EditWatchState = CommonState<Failures, Unit>;

class EditWatchStateNotifier extends StateNotifier<EditWatchState> {
  final WatchEditUseCase _useCase;
  EditWatchStateNotifier(this._useCase) : super(const EditWatchState.initial());

  Future<void> editWatch(
    WatchEntity entity,
    File? file,
  ) async {
    state = const EditWatchState.loadInProgress();
    final result = await _useCase.call(EditWatchParams(
      entity.id,
      file,
      entity,
    ));

    state = result.fold(
      EditWatchState.loadFailure,
      EditWatchState.loadSuccess,
    );
  }
}

final editWatchStateNotifierProvider =
    StateNotifierProvider.autoDispose<EditWatchStateNotifier, EditWatchState>(
  (ref) => EditWatchStateNotifier(
    ref.read(editWatchUseCaseProvider),
  ),
);
