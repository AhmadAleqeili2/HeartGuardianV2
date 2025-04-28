import 'package:app/controller/auth.dart';
import 'package:app/function/push.dart';
import 'package:app/pages/start_page.dart';
import 'package:app/widgets/googel_singin.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:app/widgets/custom_text_field.dart';
import 'package:app/widgets/custom_button.dart';
import 'package:app/widgets/text_button.dart';
import 'package:app/widgets/build_divider.dart';
import 'package:app/colors.dart';

class CreateAcc extends StatefulWidget {
  const CreateAcc({super.key});

  @override
  State<CreateAcc> createState() => _CreateAccState();
}

class _CreateAccState extends State<CreateAcc> {

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  void errmess(){
     ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please Enter a Valid Data'.tr()),
          backgroundColor: Colors.red,
        ),
      );
  }
  // Sign-up function
  Future<void> _signUp() async {
    if(_passwordController.text.trim() != _confirmPasswordController.text.trim()){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Passwords do not match'.tr()),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }else{
    bool result = await AuthService.signUp(
      _emailController.text.trim(), 
      _passwordController.text.trim(),
      _firstNameController.text.trim(), 
      _lastNameController.text.trim()
    );
    if(result) {
      callStartPage();
    }else{errmess();}
  }}

  // Navigate to the start page to reduce context errors
  callStartPage() {
    navigateTo(context, Start());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 50),
            Text(
              'Create Account',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ).tr(),
            const SizedBox(height: 50),

            // Input fields
            CustomTextField(
              labelText: 'First Name'.tr(),
              labelFontSize: 18,
              controller: _firstNameController,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              labelText: 'Last Name'.tr(),
              labelFontSize: 18,
              controller: _lastNameController,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              labelText: 'Email'.tr(),
              labelFontSize: 18,
              controller: _emailController,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              labelText: 'Password'.tr(),
              labelFontSize: 18,
              obscureText: true,
              controller: _passwordController,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              labelText: 'Confirm Password'.tr(),
              labelFontSize: 18,
              obscureText: true,
              controller: _confirmPasswordController,
            ),
            const SizedBox(height: 25),

            // Text Button to go back if the user already has an account
            CustomTextButton(
              label: 'Already have an account?'.tr(),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 25),
      
            // Sign Up Button
            CustomButton(
              label: 'Sign Up'.tr(),
              onPressed: _signUp,
            ),
            const SizedBox(height: 20),

            const SizedBox(height: 20),

            // Divider for "or"
            buildOrDivider(),
            const SizedBox(height: 20),

            // Google Sign-In
            googleSignIn(context),
          ],
        ),
      ),
    );
  }
}
