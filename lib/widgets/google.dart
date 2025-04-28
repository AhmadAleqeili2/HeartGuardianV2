import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:easy_localization/easy_localization.dart'; 

class SignInButton extends StatelessWidget {
  final Function onPressed;
  final Buttons button;
  final bool mini;
  final ShapeBorder? shape;
  final String? text;
  final EdgeInsets padding;
  final double elevation;

  const SignInButton(
    this.button, {super.key, 
    required this.onPressed,
    this.mini = false,
    this.padding = const EdgeInsets.all(0),
    this.shape,
    this.text,
    this.elevation = 2.0,
  }) : assert(
            mini != true ||
                !(button == Buttons.Google || button == Buttons.GoogleDark),
            "Google buttons do not support mini mode");

  @override
  Widget build(BuildContext context) {
    if (button == Buttons.Google || button == Buttons.GoogleDark) {
      return SignInButtonBuilder(
        elevation: elevation,
        key: ValueKey("Google"),
        text: text ?? '\t\t${'Sign in with Google'.tr()}',
        textColor: Colors.white,
        image: Container(
          margin: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image(
              image: AssetImage(
                button == Buttons.Google
                    ? 'assets/logos/google_light.png'
                    : 'assets/logos/google_dark.png',
                package: 'flutter_signin_button',
              ),
              height: 36.0,
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(90, 0, 0, 0),
        onPressed: onPressed,
        padding: padding,
        innerPadding: EdgeInsets.all(0),
        shape: shape,
        height: 36.0,
      );
    } else {
      throw Exception("Only Google buttons are supported in this implementation.");
    }
  }
}
