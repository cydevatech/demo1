import 'package:flutter/services.dart';

class InputDateFormater extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // format dd/mm/yyyy
    // ten is add 2 string '/' at index 2 and 5

    if (oldValue.text.length == 10 && newValue.text.length > 10) {
      return oldValue;
    }
    String defaultText = 'dd/mm/yyyy';
    for (int i = 0; i < defaultText.length; i++) {
      if (i == 2 || i == 5) {
        if (newValue.text.length == i + 1) {
          if (newValue.text[i] != '/') {
            String text = newValue.text;
            text = '${text.substring(0, i)}/${text.substring(i)}';
            newValue = newValue.copyWith(
              text: text,
              selection: TextSelection.collapsed(offset: i + 2),
            );
          }
        }
      }
    }

    return newValue;
  }
}

class InputPhoneFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length > 12) {
      return oldValue;
    }
    String defaultText = 'xxx xxx xxxx';
    for (int i = 0; i < defaultText.length; i++) {
      if (i == 3 || i == 7) {
        if (newValue.text.length == i + 1) {
          if (newValue.text[i] != ' ') {
            String text = newValue.text;
            text = '${text.substring(0, i)} ${text.substring(i)}';
            newValue = newValue.copyWith(
              text: text,
              selection: TextSelection.collapsed(offset: i + 2),
            );
          }
        }
      }
    }

    return newValue;
  }
}
