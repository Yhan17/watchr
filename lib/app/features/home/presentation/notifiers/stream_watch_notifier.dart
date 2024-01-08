import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/domain/entities/watch_entity.dart';
import '../../../../core/domain/failures/failures.dart';
import '../../../../core/presentation/shared/common/common_state.dart';

typedef StreamState = CommonState<Failures, List<WatchEntity>>;
typedef WatchStream = Stream<Either<Failures, List<WatchEntity>>>;

abstract class StreamWatchNotifier extends StateNotifier<StreamState> {
  StreamWatchNotifier() : super(const StreamState.initial());

  StreamSubscription? _subscription;

  @protected
  void executeSubscription(WatchStream stream) {
    state = const StreamState.loadInProgress();

    _subscription = stream.listen((event) {
      event.fold(
        (failures) => state = StreamState.loadFailure(failures),
        (watchList) => state = StreamState.loadSuccess(watchList),
      );
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void cancelSubscription() {
    if (_subscription != null) {
      _subscription!.cancel();
      _subscription = null;
    }
  }
}
