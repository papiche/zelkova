import 'dart:typed_data';

import 'package:clipboard/clipboard.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../data/models/contact.dart';
import '../data/models/node_list_cubit.dart';
import '../data/models/transaction_cubit.dart';
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
    {Color color = defAvatarColor,
    Color bgColor = defAvatarBgColor,
    double avatarSize = 24}) {
  return rawAvatar != null && rawAvatar.isNotEmpty
      ? CircleAvatar(
          radius: avatarSize,
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

String humanizeContact(String publicAddress, Contact contact) {
  final bool hasName = contact.name?.isNotEmpty ?? false;
  final bool hasNick = contact.nick?.isNotEmpty ?? false;

  if (contact.pubKey == publicAddress) {
    return tr('your_wallet');
  } else {
    if (hasName && hasNick)
      return '${contact.name} (${contact.nick})';
    else if (hasNick)
      return contact.nick!;
    else if (hasName)
      return contact.name!;
    else
      return humanizePubKey(contact.pubKey);
  }
}

String humanizePubKey(String address) => '\u{1F511} ${simplifyPubKey(address)}';

String simplifyPubKey(String address) => address.substring(0, 8);
/*
Widget humanizePubKeyAsWidget(String pubKey) => Text(
      humanizePubKey(pubKey),
      style: const TextStyle(
        fontSize: 16.0,
      ),
    );
*/
Color tileColor(int index, BuildContext context, [bool inverse = false]) {
  final ColorScheme colorScheme = Theme.of(context).colorScheme;
  final Color selectedColor = colorScheme.primary.withOpacity(0.1);
  final Color unselectedColor = colorScheme.surface;
  return (inverse ? index.isOdd : index.isEven)
      ? selectedColor
      : unselectedColor;
}

// https://github.com/andresaraujo/timeago.dart/pull/142#issuecomment-859661123
String? humanizeTime(DateTime time, String locale) =>
    timeago.format(time.toUtc(), locale: locale, clock: DateTime.now().toUtc());

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

double parseToDoubleLocalized(String locale, String double) =>
    NumberFormat.decimalPattern(locale).parse(double).toDouble();

String getAppVersion() => '0.0.11';

String localizeNumber(BuildContext context, double amount) =>
    NumberFormat.decimalPattern(context.locale.toString()).format(amount);

Contact contactFromResultSearch(Map<String, dynamic> record) {
  final Map<String, dynamic> source = record['_source'] as Map<String, dynamic>;
  final Uint8List? avatarBase64 = _getAvatarFromResults(source);
  return Contact(
      pubKey: record['_id'] as String,
      name: source['title'] as String,
      avatar: avatarBase64);
}

/*
Contact contactFromUserProfile(Map<String, dynamic> source) {
  final Uint8List? avatarBase64 = _getAvatarFromResults(source);
  return Contact(
      pubKey: source['issuer'] as String,
      name: source['title'] as String,
      avatar: avatarBase64);
} */

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

final RegExp basicEnglishCharsRegExp =
    RegExp(r'^[ A-Za-z0-9\s.;:!?()\-_;!@&<>%]*$');
// RegExp(r'^[a-zA-Z0-9-_:/;*\[\]()?!^\\+=@&~#{}|\<>%.]*$');

void fetchTransactions(BuildContext context) {
  final TransactionsCubit transCubit = context.read<TransactionsCubit>();
  final NodeListCubit nodeListCubit = context.read<NodeListCubit>();
  transCubit.fetchTransactions(nodeListCubit);
}

ListTile contactToListItem(Contact contact, int index, BuildContext context,
    [VoidCallback? onTap, Widget? trailing]) {
  final String title = contact.title;
  final Widget? subtitle =
      contact.subtitle != null ? Text(contact.subtitle!) : null;
  return ListTile(
      title: Text(title),
      subtitle: subtitle,
      tileColor: tileColor(index, context),
      onTap: onTap,
      leading: avatar(
        contact.avatar,
        bgColor: tileColor(index, context),
        color: tileColor(index, context, true),
      ),
      trailing: trailing);
}
