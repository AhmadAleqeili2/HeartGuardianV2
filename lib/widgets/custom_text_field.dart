import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final double labelFontSize;
  final TextAlign labelAlignment;
  final String? hintText;
  final bool obscureText;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType keytype;
  final double? max;

  const CustomTextField({
    super.key,
    this.labelText = '',
    this.labelFontSize = 14.0,
    this.labelAlignment = TextAlign.start,
    this.hintText,
    this.obscureText = false,
    this.controller,
    this.inputFormatters,
    this.keytype = TextInputType.text,
    this.max,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
            color: const Color.fromARGB(150, 255, 255, 255), // خلفية الحقل
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(80, 20, 178, 218),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: TextField(
          keyboardType: keytype,
          controller: controller,
          obscureText: obscureText,
          textAlign: labelAlignment,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 16,
          ),
          inputFormatters: [
            ...?inputFormatters,
            if (max != null) _RangeInputFormatter(max: max),
          ],
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            labelText: labelText.isEmpty ? null : labelText,
            labelStyle: TextStyle(
              color: Colors.blueGrey[700],
              fontSize: labelFontSize,
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.blueGrey[400],
              fontSize: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}

// RangeInputFormatter: Checks if the input is within the range
class _RangeInputFormatter extends TextInputFormatter {
  final double? max;

  _RangeInputFormatter({this.max});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final value = double.tryParse(newValue.text);
    if (value == null || (max != null && value > max!)) {
      return oldValue;
    }

    return newValue;
  }
}
