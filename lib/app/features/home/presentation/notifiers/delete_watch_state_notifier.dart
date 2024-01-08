import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/domain/entities/watch_entity.dart';
import '../../../../core/domain/failures/failures.dart';
import '../../../../core/presentation/shared/common/common_state.dart';
import '../../../../core/providers/use_case_provider.dart';
import '../../domain/usecase/delete_watch_use_case.dart';

typedef DeleteWatchState = CommonState<Failures, Unit>;

class DeleteWatchStateNotifier extends StateNotifier<DeleteWatchState> {
  final DeleteWatchUseCase _useCase;
  DeleteWatchStateNotifier(this._useCase)
      : super(const DeleteWatchState.initial());

  Future<void> deleteWatch(WatchEntity entity) async {
    state = const DeleteWatchState.loadInProgress();

    final result = await _useCase.call(entity);

    state = result.fold(
      DeleteWatchState.loadFailure,
      DeleteWatchState.loadSuccess,
    );
  }
}

final deleteWatchStateNotifierProvider = StateNotifierProvider.autoDispose<
    DeleteWatchStateNotifier, DeleteWatchState>(
  (ref) => DeleteWatchStateNotifier(ref.watch(deleteWatchUseCaseProvider)),
);
