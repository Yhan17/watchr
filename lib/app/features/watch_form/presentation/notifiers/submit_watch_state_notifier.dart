import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/domain/entities/watch_entity.dart';
import '../../../../core/domain/failures/failures.dart';
import '../../../../core/presentation/shared/common/common_state.dart';
import '../../../../core/providers/use_case_provider.dart';
import '../../domain/usecase/watch_create_use_case.dart';

typedef SubmitWatchState = CommonState<Failures, Unit>;

class SubmitWatchStateNotifier extends StateNotifier<SubmitWatchState> {
  final WatchCreateUseCase _useCase;
  SubmitWatchStateNotifier(this._useCase)
      : super(const SubmitWatchState.initial());

  Future<void> createWatch(WatchEntity entity, File file) async {
    state = const SubmitWatchState.loadInProgress();
    final result =
        await _useCase.call(WatchCreateParams(entity: entity, file: file));

    state = result.fold(
      SubmitWatchState.loadFailure,
      SubmitWatchState.loadSuccess,
    );
  }
}

final submitWatchStateNotifierProvider = StateNotifierProvider.autoDispose<
    SubmitWatchStateNotifier, SubmitWatchState>(
  (ref) => SubmitWatchStateNotifier(
    ref.read(watchesCreateUseCaseProvider),
  ),
);
