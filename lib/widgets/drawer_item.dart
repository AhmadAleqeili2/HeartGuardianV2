import 'package:app/function/push.dart';
import 'package:app/pages/home_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

Widget buildDrawerItem(BuildContext context, {required IconData icon, required String text, required Widget page}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text).tr(),
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => page)),
    );
  }

  Widget buildLogoutItem(BuildContext context) {
    void callMyHomePage(){navigateTo(context, const MyHomePage(title: '',));}
    User? user = FirebaseAuth.instance.currentUser;

    // If the user is not logged in show Back instead of Log Out
    return ListTile(
      leading: Icon(user == null ? Icons.arrow_back : Icons.logout),
      title: Text(user == null ? 'Back'.tr() : 'Log Out'.tr()),
      onTap: () async {
        if (user == null) {
          // Return to the previous page if the user is not logged in
          navigateTo(context, const MyHomePage(title: ""));
        } else {
          // Sign out from Firebase
          await FirebaseAuth.instance.signOut();
          await GoogleSignIn().signOut();

          // Navigate to MyHomePage after logging out
        callMyHomePage(); 
        }
      },
    );
  }
