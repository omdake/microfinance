import 'package:flutter/services.dart';

class MobileNumberPrefixFormatter extends TextInputFormatter {
  static const String prefix = '+91';

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String newText = newValue.text;
    if (!newText.startsWith(prefix)) {
      if (newText.length < prefix.length) {
        return TextEditingValue(
          text: prefix,
          selection: const TextSelection.collapsed(offset: 3),
        );
      }

      newText = prefix + newText.replaceAll(RegExp(r'[^0-9]'), '');
    } else {
      String afterPrefix = newText.substring(prefix.length);
      afterPrefix = afterPrefix.replaceAll(RegExp(r'[^0-9]'), '');

      if (afterPrefix.length > 10) {
        afterPrefix = afterPrefix.substring(0, 10);
      }

      newText = prefix + afterPrefix;
    }

    int cursorPosition = newValue.selection.end;
    if (cursorPosition < prefix.length) {
      cursorPosition = prefix.length;
    } else if (cursorPosition > newText.length) {
      cursorPosition = newText.length;
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: cursorPosition),
    );
  }
}
