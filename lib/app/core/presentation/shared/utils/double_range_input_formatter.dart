import 'package:flutter/services.dart';

class DoubleRangeInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAll(RegExp(r'[^0-9.]'), '');

    double value = double.tryParse(newText) ?? 0.0;

    if (value < 0.50) {
      value = 0.50;
    } else if (value > 99.99) {
      value = 99.99;
    }

    newText = value.toStringAsFixed(2);

    return newValue.copyWith(text: newText);
  }
}
