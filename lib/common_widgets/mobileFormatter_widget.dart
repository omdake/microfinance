import 'package:flutter/services.dart';

class MobileNumberPrefixFormatter extends TextInputFormatter {
  static const String prefix = '+91';

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (!newValue.text.startsWith(prefix)) {
      return oldValue;
    }
    String afterPrefix = newValue.text.substring(prefix.length);
    afterPrefix = afterPrefix.replaceAll(RegExp(r'[^0-9]'), '');
    if (afterPrefix.length > 10) {
      afterPrefix = afterPrefix.substring(0, 10);
    }

    final updatedText = prefix + afterPrefix;
    int selectionIndex = newValue.selection.end;
    if (selectionIndex < prefix.length) {
      selectionIndex = prefix.length;
    } else if (selectionIndex > updatedText.length) {
      selectionIndex = updatedText.length;
    }

    return TextEditingValue(
      text: updatedText,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
