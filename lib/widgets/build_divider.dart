import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Widget buildOrDivider() {
    return Row(
      children: [
        Expanded(child: Divider(thickness: 1, color: Colors.black)),
        Padding(padding: EdgeInsets.symmetric(horizontal: 8.0), child: Text('OR').tr()),
        Expanded(child: Divider(thickness: 1, color: Colors.black)),
      ],
    );
  }