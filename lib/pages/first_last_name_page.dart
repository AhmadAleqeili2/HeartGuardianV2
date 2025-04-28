import 'package:app/colors.dart';
import 'package:app/controller/auth.dart';
import 'package:app/function/push.dart';
import 'package:app/pages/start_page.dart';
import 'package:app/widgets/custom_button.dart';
import 'package:app/widgets/custom_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; 

class NameInputPage extends StatefulWidget {
  final UserCredential userCredential; 

  const NameInputPage({super.key, required this.userCredential});

  @override
  NameInputPageState createState() => NameInputPageState();
}

class NameInputPageState extends State<NameInputPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  void pushPage(page) {
    navigateTo(context, page);
  }

  void showMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('All fields are required').tr()),
    );
  }

  Future<bool> _saveName() async {
    if (_firstNameController.text != '' && _lastNameController.text != '') {
      await AuthService.saveData(widget.userCredential,
          _firstNameController.text, _lastNameController.text);
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Your Name').tr(),
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              labelText: "First Name".tr(),
              labelFontSize: 18,
              controller: _firstNameController,
            ),
            SizedBox(height: 16.0),
            CustomTextField(
              labelText: "Last Name".tr(),
              labelFontSize: 18,
              controller: _lastNameController,
            ),
            SizedBox(height: 24.0),
            CustomButton(
              label: 'Save'.tr(),
              onPressed: () async {
                final result = await _saveName();
                if (result) {
                    pushPage(Start());
                } else {
                  showMessage();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
