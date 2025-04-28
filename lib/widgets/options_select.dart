import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';


class OptionsDropdown extends StatelessWidget {
  final String label; 
  final List<String> options; 
  final TextEditingController controller; 

 
  const OptionsDropdown({
    super.key,
    required this.label,
    required this.options,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: controller.text.isNotEmpty
            ? options[int.tryParse(controller.text) ?? -1]
            : null,
        hint: Text(label).tr(),
        items: options.asMap().entries.map((entry) {
          String value = entry.value;
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value).tr(),
          );
        }).toList(),
        onChanged: (value) {
         
          int index = options.indexOf(value ?? '');
          controller.text = index.toString(); 
        },
        decoration: InputDecoration(
          labelText: label.tr(),
          border: const OutlineInputBorder(), 
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
      ),
    );
  }
}
