import 'package:app/function/push.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_button.dart'; // استيراد زر مخصص
import '../pages/login.dart';
import '../pages/create_account_page.dart';
import 'start_page.dart';
import 'package:app/colors.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 @override
Widget build(BuildContext context) {
  return Scaffold(
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
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
          
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 40),
                Image.asset(
                  'asset/Image/welcom.png',
                  width: 250,
                  height: 250,
                ),
                const SizedBox(height: 10),
                Image.asset(
                  'asset/Image/heart_no_bg.gif',
                  width: 150,
                  height: 150,
                ),
                const SizedBox(height: 50),
                CustomButton(
                  label: 'Log in'.tr(),
                  onPressed: () => navigateTo(context, const Login()),
                ),
                const SizedBox(height: 20),
                CustomButton(
                  label: 'Create a new Account'.tr(),
                  onPressed: () => navigateTo(context, const CreateAcc()),
                ),
                const SizedBox(height: 20),
                CustomButton(
                  label: 'Guest'.tr(),
                  onPressed: () => navigateTo(context, const Start()),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}



}
