import 'package:app/colors.dart';
import 'package:app/controller/delete_account.dart';
import 'package:app/function/push.dart';
import 'package:app/pages/account_info_page.dart';
import 'package:app/pages/language_page.dart';
import 'package:app/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart'; 

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
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
              navigateTo(context, const UserInfoPage());
            },
          ),
         
          
         
          CustomButton(
            onPressed: () async {
            
              await deleteAccount(context);
            },
            label: 'delete_account'.tr(), 
          ),
        ],
      ),
    );
  }
}
