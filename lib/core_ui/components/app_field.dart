import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_doodle/core_ui/components/app_text.dart';
import 'package:test_doodle/core_ui/theme/theme_constants.dart';
import 'package:test_doodle/core_ui/theme/theme_context.dart';

class AppField extends StatelessWidget {
  const AppField({
    required this.textController,
    required this.focusNode,
    required this.label,
    required this.onChanged,
    this.maxLines = 1,
    this.disabled = false,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.maxLength = 100,
    this.error,
    super.key,
  });

  final TextEditingController textController;
  final FocusNode focusNode;
  final String label;
  final int maxLines;
  final int maxLength;
  final bool disabled;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String) onChanged;
  final String? error;

  static const double border = 2.0;
  static const double fontSize = 16.0;

  @override
  Widget build(BuildContext context) {
    final colors = ThemeContext.of(context).colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: kSize1),
          child: AppText.body(
            label,
            color: disabled ? colors.disabledTextColor : colors.textColor,
          ),
        ),
        TextFormField(
          controller: textController,
          focusNode: focusNode,
          maxLines: maxLines,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          onChanged: onChanged,
          style: TextStyle(
            color: disabled ? colors.disabledTextColor : colors.textColor,
            fontSize: fontSize,
          ),
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            enabled: !disabled,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: colors.doodlePrimary,
                width: border,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colors.textColor, width: border),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: colors.disabledTextColor,
                width: border,
              ),
            ),
          ),
        ),
        if (error != null)
          Padding(
            padding: const EdgeInsets.only(top: kSize1),
            child: AppText.caption(error!, color: colors.expenseColor),
          ),
      ],
    );
  }
}

class MoneyInputFormatter extends TextInputFormatter {
  MoneyInputFormatter({this.maxLength = 10});
  final int maxLength;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text == '') {
      return newValue;
    }

    if (newValue.text.contains(',,') || // double tap comma
        newValue.text.contains('..') || // double tap dot
        newValue.text.length > maxLength) {
      return oldValue;
    }

    var valueStr = newValue.text;
    final hasComma = valueStr.contains(',');
    if (hasComma) {
      valueStr = valueStr.replaceFirst(RegExp(r','), '.');
    }

    var valDecimal = double.tryParse(valueStr) ?? 0.0;
    if (valDecimal == 0) {
      return TextEditingValue().copyWith(text: '0');
    }

    return TextEditingValue().copyWith(text: valueStr);
  }
}
