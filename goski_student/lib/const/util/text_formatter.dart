import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';

class TextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    final int parsedValue = int.parse(newValue.text);
    final formatter = NumberFormat('#,###');
    String newText = formatter.format(parsedValue);

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

String formatFromString(String amount) {
  return NumberFormat('#,###').format(int.parse(amount));
}

String formatFromInt(int amount) {
  return NumberFormat('#,###').format(amount);
}