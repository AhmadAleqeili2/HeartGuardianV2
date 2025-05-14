import 'package:app/cache/cache_helper.dart';
import 'package:app/core/api/end_ponits.dart';
import 'package:app/cubit/user_cubit.dart';
import 'package:app/pages/home_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget buildDrawerItem(BuildContext context, {
  required IconData icon,
  required String text,
  required Widget page,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    child: Material(
      color: const Color.fromARGB(40, 255, 255, 255),
      borderRadius: BorderRadius.circular(30),
      child: SizedBox(
        height: 60,
        child: ListTile(
          leading: Icon(icon, color: Colors.white),
          title: Text(text.tr(), style: const TextStyle(color: Colors.white)),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => page));
          },
        ),
      ),
    ),
  );
}


  Widget buildLogoutItem(BuildContext context) {
  bool isLoggedIn = context.read<UserCubit>().loggedIn;
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    child: Material(
      color: const Color.fromARGB(80, 255, 81, 81),
      borderRadius: BorderRadius.circular(30),
      child: ListTile(
        leading: Icon(isLoggedIn ? Icons.logout : Icons.arrow_back, color: Colors.white),
        title: Text(
          isLoggedIn ? 'Log Out'.tr() : 'Back'.tr(),
          style: const TextStyle(color: Colors.white),
        ),
        onTap: () {
          if (!isLoggedIn) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => MyHomePage(title: '')),
              (Route<dynamic> route) => false,
            );
          } else {
            CacheHelper cacheHelper = CacheHelper();
            cacheHelper.removeData(key: ApiKey.token);
            context.read<UserCubit>().loggedIn = false;
            context.read<UserCubit>().token = '';
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => MyHomePage(title: '')),
              (Route<dynamic> route) => false,
            );
          }
        },
      ),
    ),
  );
}

