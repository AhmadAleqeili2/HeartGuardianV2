import 'package:app/cubit/user_cubit.dart';
import 'package:app/cubit/user_state.dart';
import 'package:app/pages/reset_passwd_req.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:app/colors.dart';
import 'package:app/widgets/custom_button.dart';
import 'package:app/widgets/custom_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Forgetpass extends StatefulWidget {
  const Forgetpass({super.key});

  @override
  State<Forgetpass> createState() => _ForgetpassState();
}

class _ForgetpassState extends State<Forgetpass> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit,UserState>( listener:(context , state){
      if (state is ForgotPasswordSuccess){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.message.message),
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ResetPasswdReq(),
          ),
        );
      }
      if(state is ForgotPasswordFailure){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.message.message),
          ),
        );
      }
    },
    builder: (context , state){
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
            CustomTextField(labelText: "Enter Your Email".tr(), controller: context.read<UserCubit>().resetEmail),
            const SizedBox(height: 20),
            BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                if (state is ForgotPasswordLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return CustomButton(label: "Send Code".tr(), onPressed: (){
              context.read<UserCubit>().forgotPassword();
            });
              },
            ),
            
          ],
        ),
      ),
    );
    },
    );
  }
}
