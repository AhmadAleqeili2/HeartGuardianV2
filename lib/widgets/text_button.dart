import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const CustomTextButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          label,
          style: const TextStyle(
            color: Color.fromARGB(200, 0, 0, 0),
          ),
        ),
      ),
    );
  }
}
