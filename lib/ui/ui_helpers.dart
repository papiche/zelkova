import 'dart:typed_data';

import 'package:clipboard/clipboard.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../data/models/contact.dart';
import '../data/models/transaction_type.dart';
import '../g1/api.dart';
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

String humanizePubKey(String address) => '\u{1F511} ${simplifyPubKey(address)}';

String simplifyPubKey(String address) => address.substring(0, 8);

Widget humanizePubKeyAsWidget(String pubKey) => Text(
      humanizePubKey(pubKey),
      style: const TextStyle(
        fontSize: 16.0,
      ),
    );

Color tileColor(int index, BuildContext context, [bool inverse = false]) {
  final ColorScheme colorScheme = Theme.of(context).colorScheme;
  final Color selectedColor = colorScheme.primary.withOpacity(0.1);
  final Color unselectedColor = colorScheme.surface;
  return (inverse ? index.isOdd : index.isEven)
      ? selectedColor
      : unselectedColor;
}

String? humanizeTime(DateTime time, String locale) =>
    timeago.format(time, locale: locale, clock: DateTime.now());

const bool txDebugging = false;

const int smallScreenWidth = 360;

bool bigScreen(BuildContext context) =>
    MediaQuery.of(context).size.width > smallScreenWidth;

bool smallScreen(BuildContext context) =>
    MediaQuery.of(context).size.width <= smallScreenWidth;

String formatAmount(BuildContext context, double amount) {
  final NumberFormat currencyFormatter = NumberFormat.currency(
    symbol: 'Ğ1',
    locale: Localizations.localeOf(context).toString(),
    decimalDigits: 2,
  );
  return currencyFormatter.format(amount);
}

String formatKAmount(BuildContext context, double amount) =>
    formatAmount(context, amount / 100);

String getAppVersion() => '0.0.8';

String localizeNumber(BuildContext context, double amount) =>
    NumberFormat.decimalPattern(context.locale.toString()).format(amount);

bool isOutgoing(TransactionType type) {
  return type == TransactionType.sending || type == TransactionType.sent;
}

bool isIncoming(TransactionType type) {
  return type == TransactionType.receiving || type == TransactionType.received;
}

Contact contactFromResultSearch(Map<String, dynamic> record) {
  final Map<String, dynamic> source = record['_source'] as Map<String, dynamic>;
  final Uint8List? avatarBase64 = _getAvatarFromResults(source);
  return Contact(
      pubkey: record['_id'] as String,
      name: source['title'] as String,
      avatar: avatarBase64);
}

Contact contactFromUserProfile(Map<String, dynamic> source) {
  final Uint8List? avatarBase64 = _getAvatarFromResults(source);
  return Contact(
      pubkey: source['issuer'] as String,
      name: source['title'] as String,
      avatar: avatarBase64);
}

Uint8List? _getAvatarFromResults(Map<String, dynamic> source) {
  Uint8List? avatarBase64;
  if (source['avatar'] != null) {
    final Map<String, dynamic> avatar =
        source['avatar'] as Map<String, dynamic>;
    avatarBase64 = imageFromBase64String(
        'data:${avatar['_content_type']};base64,${avatar['_content']}');
  }
  return avatarBase64;
}
