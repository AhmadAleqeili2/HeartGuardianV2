import 'package:app/cache/cache_helper.dart';
import 'package:app/controller/authintication.dart';
import 'package:app/controller/user_controller.dart';
import 'package:app/core/api/end_ponits.dart';
import 'package:app/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; 
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'pages/home_page.dart';
import 'pages/start_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper().init();
    CacheHelper cacheHelper = CacheHelper();
  runApp(
    
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar'), Locale('fr')],
      path: 'asset/translations',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      child: Phoenix(
        child: BlocProvider(
          create: (context) => UserCubit(AuthinticationController(),UserController(),
          cacheHelper.getDataString(key:ApiKey.token) ?? ''
          ),
          child: const MyApp(),
        ),
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

 final token = context.read<UserCubit>().token;

if (token.split(".").length != 3 || JwtDecoder.isExpired(token)) {
  context.read<UserCubit>().loggedIn = false;
  return const MyHomePage(title: 'Heart Disease');
} else {
  context.read<UserCubit>().loggedIn = true;
  return const Start();
}
  }
}
