import 'dart:typed_data';

import 'package:clipboard/clipboard.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

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
          SnackBar(content: Text(tr('key_copied_to_clipboard')))));
}

const Color defAvatarBgColor = Colors.grey;
const Color defAvatarColor = Colors.white;

Widget avatar(Uint8List? rawAvatar,
    {Color color = defAvatarColor, Color bgColor = defAvatarBgColor}) {
  return rawAvatar != null && rawAvatar.isNotEmpty
      ? CircleAvatar(
          radius: 24,
          child: ClipOval(
              child: Image.memory(
            rawAvatar,
            fit: BoxFit.cover,
          )))
      : CircularIcon(
          iconData: Icons.person, backgroundColor: color, iconColor: bgColor);
}

String humanizeFromToPubKey(String publicAddress, String address) {
  if (address == publicAddress) {
    return tr('your_wallet');
  } else {
    return humanizePubKey(address);
  }
}

String humanizePubKey(String address) => '\u{1F511} ${address.substring(0, 8)}';

Widget humanizePubKeyAsWidget(String pubKey) => Text(
      humanizePubKey(pubKey),
      style: const TextStyle(
        fontSize: 16.0,
      ),
    );

Color tileColor(int index, [bool inverse = false]) =>
    (inverse ? index.isOdd : index.isEven) ? Colors.grey[200]! : Colors.white;

String? humanizeTime(DateTime time, String locale) =>
    timeago.format(time, locale: locale, clock: DateTime.now());

bool txDebugging = false;
