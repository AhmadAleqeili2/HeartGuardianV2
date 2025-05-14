import 'package:app/cubit/user_cubit.dart';
import 'package:app/cubit/user_state.dart';
import 'package:app/function/push.dart';
import 'package:app/pages/start_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:app/widgets/custom_text_field.dart';
import 'package:app/widgets/custom_button.dart';
import 'package:app/widgets/text_button.dart';
import 'package:app/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateAcc extends StatefulWidget {
  const CreateAcc({super.key});

  @override
  State<CreateAcc> createState() => _CreateAccState();
}

class _CreateAccState extends State<CreateAcc> {



  void errmess(){
     ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please Enter a Valid Data'.tr()),
          backgroundColor: Colors.red,
        ),
      );
  }
  // Sign-up function
  

  // Navigate to the start page to reduce context errors
  callStartPage() {
    navigateTo(context, Start());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is SignUpSuccess) {
            context.read<UserCubit>().sentNotification("Account Created");
            context.read<UserCubit>().token = state.message;
            context.read<UserCubit>().loggedIn = true;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
              
                
              
            ));
            callStartPage();
        } else if (state is SignUpFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
            ));
          }
        },
        builder: (context, state) {
        return Scaffold(
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
                controller: context.read<UserCubit>().signUpFirstName,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                labelText: 'Last Name'.tr(),
                labelFontSize: 18,
                controller: context.read<UserCubit>().signUpLastName,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                labelText: 'Email'.tr(),
                labelFontSize: 18,
                controller: context.read<UserCubit>().signUpEmail,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                labelText: 'Password'.tr(),
                labelFontSize: 18,
                obscureText: true,
                controller: context.read<UserCubit>().signUpPassword,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                labelText: 'Confirm Password'.tr(),
                labelFontSize: 18,
                obscureText: true,
                controller: context.read<UserCubit>().signUpConfirmPassword,
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
              BlocBuilder<UserCubit, UserState>(
                builder: (context, state) {
                  return state is SignUpLoading
                      ? const CircularProgressIndicator()
                      : CustomButton(
                          label: 'Sign Up'.tr(),
                          onPressed:() async {
                            context.read<UserCubit>().signUp();
                          },
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );});
  }
}
