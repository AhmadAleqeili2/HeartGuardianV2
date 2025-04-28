import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_localization/easy_localization.dart'; 
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'pages/home_page.dart';
import 'pages/start_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(  
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar'), Locale('fr')],
      path: 'asset/translations', // Path to the translation files
      fallbackLocale: const Locale('en'), // Default language
      startLocale: const Locale('en'),
      child: Phoenix(
        child: const MyApp()
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: context.locale, // Current language
      supportedLocales: context.supportedLocales, // Supported languages
      localizationsDelegates: context.localizationDelegates, // Localization files
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      return const Start();
    } else {
      return const MyHomePage(title: 'Heart Disease');
    }
  }
}
