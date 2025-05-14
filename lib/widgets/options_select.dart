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
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(160, 255, 255, 255),
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(80, 20, 178, 218),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: DropdownButtonFormField<String>(
          value: controller.text.isNotEmpty
              ? options[int.tryParse(controller.text) ?? -1]
              : null,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down, color: Colors.blueGrey),
          hint: Text(label).tr(),
          items: options.asMap().entries.map((entry) {
            String value = entry.value;
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value.tr(),
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            );
          }).toList(),
          onChanged: (value) {
            int index = options.indexOf(value ?? '');
            controller.text = index.toString();
          },
          decoration: InputDecoration(
            labelText: label.tr(),
            labelStyle: TextStyle(
              color: Colors.blueGrey[700],
              fontSize: 14,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
          dropdownColor: Colors.white,
        ),
      ),
    );
  }
}
