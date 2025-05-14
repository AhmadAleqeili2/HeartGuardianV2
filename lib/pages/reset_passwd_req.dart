import 'package:app/colors.dart';
import 'package:app/cubit/user_cubit.dart';
import 'package:app/cubit/user_state.dart';
import 'package:app/widgets/custom_button.dart';
import 'package:app/widgets/custom_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswdReq extends StatefulWidget {
  const ResetPasswdReq({super.key,});

  @override
  ResetPasswdReqState createState() => ResetPasswdReqState();
}

class ResetPasswdReqState extends State<ResetPasswdReq> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is ResetPasswordRequestSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message.message),
            ),
          );
          Navigator.pop(context);
        } else if (state is ResetPasswordRequestFailure) {
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
        title: Text('Reset Your Password').tr(),
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              labelText: "Email".tr(),
              labelFontSize: 18,
              controller: context.read<UserCubit>().resetEmail,
            ),
            SizedBox(height: 16.0),
            CustomTextField(
              labelText: "New Password".tr(),
              labelFontSize: 18,
              controller: context.read<UserCubit>().resetPasswd,
            ),
                        CustomTextField(
              labelText: "Reset Code".tr(),
              labelFontSize: 18,
              controller: context.read<UserCubit>().resetCode,
            ),
            SizedBox(height: 24.0),
            BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                if (state is ResetPasswordRequestLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return  CustomButton(
              label: 'Save'.tr(),
              onPressed: () async {
                context.read<UserCubit>().resetPasswordRequest();
              },
            );
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
