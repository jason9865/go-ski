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
    final formatter = NumberFormat.simpleCurrency(locale: 'ko');
    String newText = formatter.format(parsedValue);

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
