import 'package:app/cubit/user_cubit.dart';
import 'package:app/cubit/user_state.dart';
import 'package:app/widgets/custom_button.dart';
import 'package:app/widgets/custom_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  ChangePasswordPageState createState() => ChangePasswordPageState();
}

class ChangePasswordPageState extends State<ChangePasswordPage> {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit,UserState>( listener: (context, state){
      if (state is UpdatePasswordSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.message.message),
          ),
        );
        Navigator.pop(context);
      } else if (state is UpdatePasswordFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.message.message),
          ),
        );
      }
    }, 
    builder: (context, state) {
      
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
              controller: context.read<UserCubit>().updatPasswordCont,
              labelText: "New Password".tr(),
              labelFontSize: 18,
              obscureText: true,
            ),
            const SizedBox(height: 20), 
            CustomTextField(
              controller: context.read<UserCubit>().confirmUpdatPassowrdCont,
              labelText: "Confirm New Password".tr(),
              labelFontSize: 18,
              obscureText: true,
            ),
            const SizedBox(height: 40),

            const SizedBox(height: 20),
            BlocBuilder<UserCubit,UserState>(builder: (context, state) {
              if (state is UpdatePasswordLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
              return
            CustomButton(
              label: "Set".tr(),
              onPressed:(){ context.read<UserCubit>().updatePassword();},
            );}),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255), 
    ); 
    } );}
  }

