import 'dart:async';

import 'package:flutter/material.dart';

class SplashDebouncer {
  final _isFinishedNotifier = ValueNotifier(false);
  late VoidCallback _callback;

  void start() {
    Timer? timer;

    timer = Timer(
      const Duration(seconds: 5),
      () {
        _isFinishedNotifier.value = true;
        timer?.cancel();
      },
    );
  }

  void run(VoidCallback callback) {
    _callback = callback;
    _isFinishedNotifier.addListener(_onValueChanged);
  }

  void _onValueChanged() {
    if (_isFinishedNotifier.value) {
      _callback();
      _isFinishedNotifier.removeListener(_onValueChanged);
    }
  }
}
