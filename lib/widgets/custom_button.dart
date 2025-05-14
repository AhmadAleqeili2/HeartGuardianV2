import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: SizedBox(
        width: screenWidth * 0.9,
        height: 50,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(30, 20, 178, 218), // لون الزر
            foregroundColor: const Color.fromARGB(255, 5, 26, 146), // لون النص
            elevation: 7,
            
            shadowColor: const Color.fromARGB(66, 0, 17, 255),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            textStyle: GoogleFonts.cairo( // أو Cairo، حسب التفضيل
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
          ),
          child: Text(label),
        ),
      ),
    );
  }
}
