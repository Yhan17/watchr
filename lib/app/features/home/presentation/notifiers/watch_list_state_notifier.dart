import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/providers/use_case_provider.dart';
import '../../../../core/usecase/use_case.dart';
import '../../domain/usecase/watches_list_use_case.dart';
import 'stream_watch_notifier.dart';

class WatchListStateNotifier extends StreamWatchNotifier {
  final WatchesListUseCase _useCase;

  WatchListStateNotifier(this._useCase);

  void fetchAll() {
    final shouldExecuteSubscription = state.maybeWhen(
      loadSuccess: (_) {
        return true;
      },
      orElse: () => true,
    );

    if (shouldExecuteSubscription) {
      cancelSubscription();
      executeSubscription(_useCase.call(noParams));
    }
  }
}

final watchListStateNotifierProvider =
    StateNotifierProvider.autoDispose<WatchListStateNotifier, StreamState>(
  (ref) => WatchListStateNotifier(
    ref.read(
      watchesListUseCaseProvider,
    ),
  ),
);
