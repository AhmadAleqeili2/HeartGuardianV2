import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:easy_localization/easy_localization.dart';
import '../colors.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('language'.tr(), style: TextStyle(color: Colors.white)), 
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('العربية'),
            onTap: () {
              context.setLocale(const Locale('ar'));
              Phoenix.rebirth(context); // Restart the app
            },
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('English'),
            onTap: () {
              context.setLocale(const Locale('en'));
              Phoenix.rebirth(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Français'),
            onTap: () {
              context.setLocale(const Locale('fr'));
              Phoenix.rebirth(context); 
            },
          ),
        ],
      ),
    );
  }
}
