import 'package:flutter/services.dart';

class NumberRangeInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    int value = int.tryParse(newText) ?? 0;
    if (value < 1) {
      value = 1;
    } else if (value > 99) {
      value = 99;
    }

    newText = value.toString();

    return newValue.copyWith(text: newText);
  }
}
