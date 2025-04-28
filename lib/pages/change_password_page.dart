import 'package:app/widgets/custom_button.dart';
import 'package:app/widgets/custom_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  ChangePasswordPageState createState() => ChangePasswordPageState();
}

class ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? _errorMessage;

  // Function to change the password
  Future<void> _changePassword() async {
    setState(() {
      _errorMessage = null; 
    });

    // Validate if passwords match
    if (_newPasswordController.text != _confirmPasswordController.text) {
      setState(() {
        _errorMessage = 'Passwords do not match!'.tr();
      });
      return;
    }

    try {
      User? user = _auth.currentUser;
      if (user != null) {
        // Change password for the current user
        await user.updatePassword(_newPasswordController.text);
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Password changed successfully!").tr()),
        );
        // Clear inputs after successful change
        _newPasswordController.clear();
        _confirmPasswordController.clear();
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error changing password: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Change Password',
          style: TextStyle(color: Colors.white),
        ).tr(),
        backgroundColor: const Color.fromARGB(255, 76, 200, 209),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            CustomTextField(
              controller: _newPasswordController,
              labelText: "New Password".tr(),
              labelFontSize: 18,
              obscureText: true,
            ),
            const SizedBox(height: 20), 
            CustomTextField(
              controller: _confirmPasswordController,
              labelText: "Confirm New Password".tr(),
              labelFontSize: 18,
              obscureText: true,
            ),
            const SizedBox(height: 40),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            const SizedBox(height: 20),
            CustomButton(
              label: "Set".tr(),
              onPressed: _changePassword,
            ),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255), 
    );
  }
}
