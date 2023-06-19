import 'package:flutter/services.dart';
import 'package:my_local_vendor/common/utils.dart';


class CapitalCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.capitalizeSentence(),
      selection: newValue.selection,
    );
  }
}
