import 'package:app/pages/login.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app/colors.dart';
import 'package:app/function/push.dart';
import 'package:app/widgets/custom_button.dart';
import 'package:app/widgets/custom_text_field.dart';

class Forgetpass extends StatefulWidget {
  const Forgetpass({super.key});

  @override
  State<Forgetpass> createState() => _ForgetpassState();
}

class _ForgetpassState extends State<Forgetpass> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  // Function to send the password reset link
  Future<void> _sendResetCode() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text);
     
      if (context.mounted) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('A reset code has been sent to your email.'.tr())),
        );
        navigateTo(context, const Login()); 
      }
    } catch (e) {
      
      if (context.mounted) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'.tr())),
        );
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        title: Text('Reset your password'.tr()),
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            CustomTextField(labelText: "Enter Your Email".tr(), controller: _emailController),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator() // Show loading indicator while sending the code
                : CustomButton(label: "Send Code".tr(), onPressed: _sendResetCode)
          ],
        ),
      ),
    );
  }
}
