import 'dart:io';

import 'package:clipboard/clipboard.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fast_image_resizer/fast_image_resizer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../data/models/app_cubit.dart';
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
  /* final DataWriterItem item = DataWriterItem();
  item.add(Formats.plainText(SharedPreferencesHelper().getPubKey()));
  ClipboardWriter.instance.write(<DataWriterItem>[item]).then((dynamic value) =>
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(tr('key_copied_to_clipboard'))))); */
  FlutterClipboard.copy(SharedPreferencesHelper().getPubKey()).then(
      (dynamic value) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(tr('key_copied_to_clipboard')))));
}

const Color defAvatarBgColor = Colors.grey;
const Color defAvatarColor = Colors.white;
const double defAvatarSize = 24;

Widget avatar(Uint8List? rawAvatar,
    {Color color = defAvatarColor,
    Color bgColor = defAvatarBgColor,
    double avatarSize = defAvatarSize}) {
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

String simplifyPubKey(String address) =>
    address.length <= 8 ? 'WRONG ADDRESS' : address.substring(0, 8);
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
  return formatAmountWithLocale(
      Localizations.localeOf(context).toString(), amount);
}

String formatAmountWithLocale(String locale, double amount) {
  final NumberFormat currencyFormatter = NumberFormat.currency(
    // in English $10 is G110 ... confusing
    symbol: 'Ğ1 ',
    locale: locale,
    decimalDigits: 2,
  );
  return currencyFormatter.format(amount);
}

String formatKAmount(BuildContext context, double amount) =>
    formatAmount(context, amount / 100);

double parseToDoubleLocalized(
        {required String locale, required String number}) =>
    NumberFormat.decimalPattern(locale).parse(number).toDouble();

String localizeNumber(BuildContext context, double amount) =>
    NumberFormat.decimalPattern(context.locale.toString()).format(amount);

Future<Contact> contactFromResultSearch(Map<String, dynamic> record) async {
  final Map<String, dynamic> source = record['_source'] as Map<String, dynamic>;
  final Uint8List? avatarBase64 = await _getAvatarFromResults(source);
  return Contact(
      pubKey: record['_id'] as String,
      name: source['title'] as String,
      avatar: avatarBase64);
}

Future<Uint8List?> _getAvatarFromResults(Map<String, dynamic> source) async {
  Uint8List? avatarBase64;
  if (source['avatar'] != null) {
    final Map<String, dynamic> avatar =
        source['avatar'] as Map<String, dynamic>;
    avatarBase64 = imageFromBase64String(
        'data:${avatar['_content_type']};base64,${avatar['_content']}');
  }
  if (avatarBase64 != null && avatarBase64.isNotEmpty) {
    final Uint8List? avatarBase64resized = await resizeAvatar(avatarBase64);
    return avatarBase64resized;
  } else {
    return null;
  }
}

Future<Uint8List?> resizeAvatar(Uint8List avatarBase64) async {
  final ByteData? bytes =
      await resizeImage(avatarBase64, height: defAvatarSize.toInt() * 2);
  return bytes != null ? Uint8List.view(bytes.buffer) : null;
}

final RegExp basicEnglishCharsRegExp =
    RegExp(r'^[ A-Za-z0-9\s.;:!?()\-_;!@&<>%]*$');
// RegExp(r'^[a-zA-Z0-9-_:/;*\[\]()?!^\\+=@&~#{}|\<>%.]*$');

void fetchTransactions(BuildContext context) {
  final TransactionsCubit transCubit = context.read<TransactionsCubit>();
  final NodeListCubit nodeListCubit = context.read<NodeListCubit>();
  transCubit.fetchTransactions(nodeListCubit);
}

class SlidableContactTile extends StatefulWidget {
  const SlidableContactTile(this.contact,
      {super.key,
      required this.index,
      required this.context,
      this.onTap,
      this.onLongPress,
      this.trailing});

  @override
  State<SlidableContactTile> createState() => _SlidableContactTile();

  final Contact contact;
  final int index;
  final BuildContext context;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Widget? trailing;
}

class _SlidableContactTile extends State<SlidableContactTile> {
  @override
  void initState() {
    super.initState();
    _start();
  }

  // Based in https://github.com/letsar/flutter_slidable/issues/288
  Future<void> _start() async {
    if (widget.index == 0 &&
        !context.read<AppCubit>().wasTutorialShown(tutorialId)) {
      await Future<void>.delayed(const Duration(seconds: 1));
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(tr('slidable_tutorial')),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              context.read<AppCubit>().onFinishTutorial(tutorialId);
              // context.read<AppCubit>().warningViewed();
            },
          ),
        ),
      );
      final SlidableController? slidable = Slidable.of(context);

      slidable?.openEndActionPane(
        duration: const Duration(milliseconds: 300),
        curve: Curves.decelerate,
      );

      Future<void>.delayed(const Duration(seconds: 1), () {
        slidable?.close(
          duration: const Duration(milliseconds: 300),
          curve: Curves.bounceInOut,
        );
      });
    }
  }

  static String tutorialId = 'slidable_tutorial';

  @override
  Widget build(_) =>
      contactToListItem(widget.contact, widget.index, widget.context,
          onTap: widget.onTap,
          onLongPress: widget.onLongPress,
          trailing: widget.trailing);
}

ListTile contactToListItem(Contact contact, int index, BuildContext context,
    {VoidCallback? onTap, VoidCallback? onLongPress, Widget? trailing}) {
  final String title = contact.title;
  final Widget? subtitle =
      contact.subtitle != null ? Text(contact.subtitle!) : null;
  return ListTile(
      title: Text(title),
      subtitle: subtitle ?? Container(),
      tileColor: tileColor(index, context),
      onTap: onTap,
      onLongPress: onLongPress,
      leading: avatar(
        contact.avatar,
        bgColor: tileColor(index, context),
        color: tileColor(index, context, true),
      ),
      trailing: trailing);
}

bool showShare() => onlyInDevelopment || !kIsWeb;

bool get onlyInDevelopment => !inProduction;

bool get inDevelopment => !inProduction;

bool get onlyInProduction => kReleaseMode;

bool get inProduction => onlyInProduction;

String assets(String str) =>
    (kIsWeb && kReleaseMode) || (!kIsWeb && Platform.isAndroid)
        ? 'assets/$str'
        : str;

Future<Directory?> getAppSpecificExternalFilesDirectory(
    [bool ext = false]) async {
  if (ext) {
    final Directory? appSpecificExternalFilesDir =
        await getExternalStorageDirectory();
    return appSpecificExternalFilesDir;
  }
  return getExternalStorageDirectory();
}

ImageIcon get g1nkgoIcon => ImageIcon(
      AssetImage(ginkgoIconLocation),
      size: 24,
    );

String get ginkgoIconLocation => assets('img/favicon.png');

String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

double calculate({required String textInTerminal, required String decimalSep}) {
  String operation = textInTerminal;
  double sum = 0.0;
  operation = operation.replaceAll(
      decimalSep, '.'); // change decimal separator to a dot
  final RegExp regex = RegExp(r'[\d.]+'); // regular expression to find numbers
  final Iterable<Match> matches =
      regex.allMatches(operation); // find all numbers in the input
  for (final Match? match in matches) {
    try {
      if (match != null) {
        final String? g1 = match.group(0);
        if (g1 != null) {
          sum += double.parse(g1); // add the number to the sum
        }
      }
    } catch (e) {
      // could not convert the number to a double value, ignore it
    }
  }
  // logger(numberFormat.format(sum)); // print the formatted sum
  return sum;
}

String decimalSep(BuildContext context) {
  return NumberFormat.decimalPattern(context.locale.toString())
      .symbols
      .DECIMAL_SEP;
}

Color selectedPatternLock(BuildContext context) => Colors.red;

Color notSelectedPatternLock(BuildContext context) => Colors.amber;

String ginkgoNetIcon =
    'https://git.duniter.org/vjrj/ginkgo/-/raw/master/web/icons/favicon-32x32.png';

final GlobalKey<ScaffoldMessengerState> globalMessengerKey =
    GlobalKey<ScaffoldMessengerState>();
