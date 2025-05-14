import 'package:app/colors.dart';
import 'package:app/cubit/user_cubit.dart';
import 'package:app/cubit/user_state.dart';
import 'package:app/function/push.dart';
import 'package:app/pages/account_info_page.dart';
import 'package:app/pages/home_page.dart';
import 'package:app/pages/language_page.dart';
import 'package:app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; 

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit,UserState>(
      listener:(context, state) {
        if (state is DeleteAccSuccess) {
          context.read<UserCubit>().loggedIn = false;
         ScaffoldMessenger.of(context).showSnackBar( SnackBar(
            content: Text('account deleted success'.tr()),
            backgroundColor: Colors.green,
          ));
          Navigator.of(context).pushAndRemoveUntil(
  MaterialPageRoute(builder: (context) => MyHomePage(title: "Home Page".tr(),)),
  (Route<dynamic> route) => false,
);

        }
        if (state is DeleteAccFailure) {
        ScaffoldMessenger.of(context).showSnackBar( SnackBar(
            content: Text('account deleted error'.tr()),
            backgroundColor: Colors.red,
          ));
        }
      },
      builder: (context, state) {
        return Scaffold(
      appBar: AppBar(
        title: Text('settings'.tr(), style: const TextStyle(color: Colors.white)), 
        backgroundColor: primaryColor,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          
          ListTile(
            title: Text('language').tr(), 
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              navigateTo(context, LanguagePage());
            },
          ),
          
          ListTile(
            title: Text('account'.tr()), 
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              navigateTo(context, UserInfoPage());
            },
          ),
         
          
         
          CustomButton(
            onPressed: () async {
            if(context.read<UserCubit>().loggedIn){
              await context.read<UserCubit>().deleteAcc();
              }
              else {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Please LogIn First'.tr()),
      backgroundColor: Colors.red,
    ),
  );
}
            },
            label: 'delete_account'.tr(), 
          ),
        ],
      ),
    );
      },
      );
  }
}
