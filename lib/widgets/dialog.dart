import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

void dialog(
  BuildContext context,
  String title, 
  Color colorT,
  String alert, 
  Color colorA, 
  { 
  String? end,
  Color colorE = Colors.black,
  String? imagePath,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (imagePath != null)
              Center(
                child: Image.asset(imagePath, height: 80),
              ),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(color: colorT, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            Text(
              alert,
              style: TextStyle(color: colorA, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            if (end != null) ...[
              const SizedBox(height: 5),
              Text(
                end,
                style: TextStyle(color: colorE, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK').tr(),
          ),
        ],
      );
    },
  );
}
