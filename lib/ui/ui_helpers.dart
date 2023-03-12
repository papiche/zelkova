import 'dart:typed_data';

import 'package:clipboard/clipboard.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../shared_prefs.dart';
import 'widgets/first_screen/circular_icon.dart';

void showTooltip(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              tr('close').toUpperCase(),
            ),
          ),
        ],
      );
    },
  );
}

void copyPublicKeyToClipboard(BuildContext context) {
  FlutterClipboard.copy(SharedPreferencesHelper().getPubKey()).then(
      (dynamic value) => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('key-copied-to-clipboard'))));
}

const Color defAvatarBgColor = Colors.grey;
const Color defAvatarColor = Colors.white;

Widget avatar(bool hasAvatar, Uint8List? rawAvatar,
    {Color color = defAvatarColor, Color bgColor = defAvatarBgColor}) {
  return hasAvatar
      ? CircleAvatar(
          radius: 24,
          child: ClipOval(
              child: Image.memory(
            rawAvatar!,
            fit: BoxFit.cover,
          )))
      : CircularIcon(
          iconData: Icons.person, backgroundColor: color, iconColor: bgColor);
}
