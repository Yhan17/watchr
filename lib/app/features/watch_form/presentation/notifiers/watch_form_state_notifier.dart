import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'watch_form_state.dart';

class WatchFormStateNotifier extends StateNotifier<WatchFormState> {
  WatchFormStateNotifier() : super(WatchFormState.initial());

  WatchFormState get last => state;

  void imageChange(File file) {
    state = state.copyWith(image: file);
  }

  void nameChange(String name) {
    state = state.copyWith(name: name);
  }

  void descChange(String desc) {
    state = state.copyWith(desc: desc);
  }

  void priceChange(String price) {
    state = state.copyWith(price: price);
  }

  void quantityChange(String quantity) {
    state = state.copyWith(quantity: quantity);
  }

  void codeChange(String code) {
    state = state.copyWith(code: code);
  }
}

final watchFormStateNotifierProvider =
    StateNotifierProvider.autoDispose<WatchFormStateNotifier, WatchFormState>(
  (_) => WatchFormStateNotifier(),
);
