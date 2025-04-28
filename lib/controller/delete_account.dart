import 'package:app/function/push.dart';
import 'package:app/pages/home_page.dart';
import 'package:app/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<void> deleteAccount(BuildContext context) async {
  try {
    final User? user = FirebaseAuth.instance.currentUser;
    await GoogleSignIn().signOut();

    if (user == null) {
      // If no user is logged in
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No user is logged in.')),
        );
      }
      return;
    }

    // Delete data from the "user_history" collection
    await FirebaseFirestore.instance
        .collection('notifications')
        .doc(user.uid)
        .collection('user_history')
        .get()
        .then((snapshot) {
          for (var doc in snapshot.docs) {
            doc.reference.delete(); // Delete each document in the "user_history" collection
          }
        });

    // Delete data from the "user_notifications" collection
    await FirebaseFirestore.instance
        .collection('notifications')
        .doc(user.uid)
        .collection('user_notifications')
        .get()
        .then((snapshot) {
          for (var doc in snapshot.docs) {
            doc.reference.delete(); // Delete each document in the "user_notifications" collection
          }
        });

    // Delete data from the "notifications" collection (main document)
    await FirebaseFirestore.instance
        .collection('notifications')
        .doc(user.uid)
        .delete(); // Delete the entire "notifications" document

    // Delete data from the "users" collection
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .delete(); 
        
        // Delete data from the "images" collection
        await FirebaseFirestore.instance
        .collection('user_images')
        .doc(user.uid)
        .delete(); // Delete the user document from the "users" collection
    // Delete the account
    await user.delete();

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account and associated data deleted successfully.')),
      );
    }

    // Sign out and navigate the user to the login page
    await FirebaseAuth.instance.signOut();
    if (context.mounted) {
      navigateTo(context, MyHomePage(title: '')); 
    }

  } catch (e) {
    
    if (e.toString().contains('requires-recent-login')) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Reauthentication required. Logging out...')),
        );
      }

      // Sign out and redirect to login page
      await FirebaseAuth.instance.signOut();
      if (context.mounted) {
        navigateTo(context, Login()); 
      }
    } else {
      // In case of any other error
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete account: $e')),
        );
      }
    }
  }
}
