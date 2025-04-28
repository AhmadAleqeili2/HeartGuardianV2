import 'package:app/controller/add_notification.dart';
import 'package:app/controller/auth.dart';
import 'package:app/function/push.dart';
import 'package:app/pages/first_last_name_page.dart';
import 'package:app/pages/start_page.dart';
import 'package:app/widgets/google.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';

Widget googleSignIn (BuildContext context) {
  void pushPage(page){
    navigateTo(context, page);
  }
  void messemger(){
    ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login Failed').tr()));
  }
  return SizedBox(
    height: 50,
    child: SignInButton(
    Buttons.Google,
    onPressed: () async {
      // Google sign-in process
      final a = await AuthService.signInWithGoogle();

      if (a != null && a.user != null) {
        // Get user data from Firestore
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(a.user!.uid)
            .get();

        if (userDoc.exists) {
          // If the user exists in the database
          addNotification('Logged in successfully');
          pushPage(Start()); // Navigate to the Start page
        } else {
          // If the user is new
          addNotification('Created Account successfully');
          pushPage(NameInputPage(userCredential: a)); // Navigate to the Name input page
        }
      } else {
        // In case of failed login
        messemger();
      }
    },
  ));
}
