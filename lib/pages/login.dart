import 'package:app/controller/auth.dart';
import 'package:app/pages/create_account_page.dart';
import 'package:app/pages/start_page.dart';
import 'package:app/widgets/build_divider.dart';
import 'package:app/widgets/custom_button.dart';
import 'package:app/widgets/custom_text_field.dart';
import 'package:app/function/push.dart';
import 'package:app/widgets/googel_singin.dart';
import 'package:app/widgets/text_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:app/pages/forgetpass.dart';
import 'package:app/colors.dart';
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  
  void _signIn() async {
    
    bool result = await AuthService.signIn(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );
    callStartPage(result);
  }

  void callStartPage(result) {
    if (result) {
      navigateTo(context, Start());
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid email or password'.tr()),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            
            children: [
              const SizedBox(height: 80),
              Text(
                'Log in'.tr(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                labelText: "Email".tr(),
                labelFontSize: 18,
                controller: _emailController,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                labelText: "Password".tr(),
                labelFontSize: 18,
                obscureText: true,
                controller: _passwordController,
              ),
              const SizedBox(height: 20),
              CustomTextButton(
                label: "Forget your password?".tr(),
                onPressed: () {
                  navigateTo(context, const Forgetpass());
                },
              ),
                            CustomTextButton(
                label: "You Don't Have An Account? Create Account".tr(),
                onPressed: () {
                  navigateTo(context, const CreateAcc());
                },
              ),
              const SizedBox(height: 50),
              CustomButton(
                label: "Log in".tr(),
                onPressed: _signIn, 
              ),
              const SizedBox(height: 20),
              buildOrDivider(),
              const SizedBox(height: 20),
              googleSignIn(context),
              

              const SizedBox(height: 40),
             
            ],
          ),
        ),
      ),
    );
  }
}

