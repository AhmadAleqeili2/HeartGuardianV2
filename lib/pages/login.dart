import 'package:app/cubit/user_cubit.dart';
import 'package:app/cubit/user_state.dart';
import 'package:app/pages/create_account_page.dart';
import 'package:app/pages/start_page.dart';
import 'package:app/widgets/custom_button.dart';
import 'package:app/widgets/custom_text_field.dart';
import 'package:app/function/push.dart';
import 'package:app/widgets/text_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:app/pages/forgetpass.dart';
import 'package:app/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  void _signIn() async {
    
    context.read<UserCubit>().logIn();

  }

  void callStartPage() {
      navigateTo(context, Start());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is SignInSuccess) {
            context.read<UserCubit>().sentNotification("LoggedIn");
            context.read<UserCubit>().token = state.message;
            context.read<UserCubit>().loggedIn = true;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
              
              
            ));
            callStartPage();
          } else if (state is SignInFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
            ));
          }
        },
        builder: (context, state) {
          return  Scaffold(
      backgroundColor: secondaryColor,
      body: Container(
        decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFE1F5FE), // لون أزرق فاتح جداً
            Color(0xFFB3E5FC), // أزرق سماوي ناعم
            secondaryColor,   // اللون الحالي الموجود لديك
          ],
        ),
      ),
        child: SingleChildScrollView(
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
                  controller: context.read<UserCubit>().signInEmail,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  labelText: "Password".tr(),
                  labelFontSize: 18,
                  obscureText: true,
                  controller: context.read<UserCubit>().signInPassword,
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
                
        
                const SizedBox(height: 40),
               
              ],
            ),
          ),
        ),
      ),
    );
  });
}
}
