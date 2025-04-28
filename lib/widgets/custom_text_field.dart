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
    this.labelAlignment = TextAlign.center, 
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
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        keyboardType: keytype,
        controller: controller, 
        obscureText: obscureText, 
        textAlign: labelAlignment, 
        inputFormatters: [
          ...?inputFormatters, 
          if ( max != null) _RangeInputFormatter( max: max), 
        ],
        decoration: InputDecoration(
          labelText: labelText.isEmpty ? null : labelText, 
          labelStyle: TextStyle(
            color: Color.fromARGB(90, 0, 0, 0),
            fontSize: labelFontSize, 
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Color.fromARGB(90, 0, 0, 0),
            fontSize: 14,
          ),
          border: InputBorder.none,
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          alignLabelWithHint: true, 
        ),
      ),
    );
  }
}

// RangeInputFormatter: Checks if the input is within the range
class _RangeInputFormatter extends TextInputFormatter {

  final double? max;

  _RangeInputFormatter({ this.max});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue; // Allow empty values
    }

    try {
      final value = double.tryParse(newValue.text);
      if (value == null) {
        // If the input is null, ignore the change
        return newValue;
      }

      // Check the boundaries if they are present
      if ( (max != null && value > max!)) {
        return oldValue; // Ignore the input if it is outside the range
      }
    } catch (e) {
      return oldValue; // In case of error, ignore the change
    }

    return newValue;
  }
}
