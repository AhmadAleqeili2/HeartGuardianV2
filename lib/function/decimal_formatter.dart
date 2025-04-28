import 'package:flutter/services.dart';

class DecimalTextInputFormatter extends TextInputFormatter {
  final RegExp _decimalRegex = RegExp(r'^\d*\.?\d*$'); // يسمح بأرقام عشرية

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (_decimalRegex.hasMatch(newValue.text)) {
      return newValue;
    }
    return oldValue;
  }
}
