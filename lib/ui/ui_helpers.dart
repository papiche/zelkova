import 'dart:io';

import 'package:clipboard/clipboard.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fast_image_resizer/fast_image_resizer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

import '../data/models/app_cubit.dart';
import '../data/models/contact.dart';
import '../data/models/node_list_cubit.dart';
import '../data/models/transaction_cubit.dart';
import '../g1/api.dart';
import '../g1/currency.dart';
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

void copyPublicKeyToClipboard(BuildContext context,
    [String? uri, String? feedbackText]) {
  FlutterClipboard.copy(uri ?? SharedPreferencesHelper().getPubKey()).then(
      (dynamic value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(tr(feedbackText ?? 'key_copied_to_clipboard')))));
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

String humanizeContact(String publicAddress, Contact contact,
    [bool addKey = false]) {
  if (contact.pubKey == publicAddress) {
    return tr('your_wallet');
  } else {
    final String pubKey = humanizePubKey(contact.pubKey);
    final bool titleNotTheSameAsPubKey = contact.title != pubKey;
    return addKey && titleNotTheSameAsPubKey
        ? '${contact.title} ($pubKey)'
        : titleNotTheSameAsPubKey
            ? contact.title
            : pubKey;
  }
}

String humanizePubKey(String address) => '\u{1F511} ${simplifyPubKey(address)}';

String simplifyPubKey(String address) =>
    address.length <= 8 ? 'WRONG ADDRESS' : address.substring(0, 8);

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

String _formatAmount(
    {required String locale,
    required double amount,
    required bool isG1,
    required bool useSymbol}) {
  return formatAmountWithLocale(
      locale: locale, amount: amount, isG1: isG1, useSymbol: useSymbol);
}

String formatAmountWithLocale(
    {required String locale,
    required double amount,
    required bool isG1,
    required bool useSymbol}) {
  final NumberFormat currencyFormatter =
      currentNumberFormat(isG1: isG1, locale: locale, useSymbol: useSymbol);
  return currencyFormatter.format(amount);
}

NumberFormat currentNumberFormat(
    {required bool useSymbol, required bool isG1, required String locale}) {
  final NumberFormat currencyFormatter = NumberFormat.currency(
    symbol: useSymbol ? currentCurrency(isG1) : '',
    locale: locale,
    decimalDigits: isG1 ? 2 : 3,
  );
  return currencyFormatter;
}

String currentCurrency(bool isG1) {
  return isG1 ? '${Currency.G1.name()} ' : '${Currency.DU.name()} ';
}

String currentCurrencyTrimmed(bool isG1) {
  return currentCurrency(isG1).trim();
}

String formatKAmountInView(
        {required BuildContext context,
        required double amount,
        required bool isG1,
        required double currentUd,
        required bool useSymbol}) =>
    _formatAmount(
        locale: currentLocale(context),
        amount: convertAmount(isG1, amount, currentUd),
        isG1: isG1,
        useSymbol: useSymbol);

String formatKAmountInViewWithLocale(
        {required String locale,
        required double amount,
        required bool isG1,
        required double currentUd,
        required bool useSymbol}) =>
    _formatAmount(
        locale: locale,
        amount: convertAmount(isG1, amount, currentUd),
        isG1: isG1,
        useSymbol: useSymbol);

double convertAmount(bool isG1, double amount, double currentUd) =>
    isG1 ? amount / 100 : ((amount / 100) / currentUd);

double parseToDoubleLocalized(
        {required String locale, required String number}) =>
    NumberFormat.decimalPattern(locale).parse(number).toDouble();

String localizeNumber(BuildContext context, double amount) =>
    NumberFormat.decimalPattern(currentLocale(context)).format(amount);

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

void fetchTransactions(BuildContext context) {
  final AppCubit appCubit = context.read<AppCubit>();
  final TransactionCubit transCubit = context.read<TransactionCubit>();
  final NodeListCubit nodeListCubit = context.read<NodeListCubit>();
  transCubit.fetchTransactions(nodeListCubit, appCubit);
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
  return NumberFormat.decimalPattern(currentLocale(context))
      .symbols
      .DECIMAL_SEP;
}

Color selectedPatternLock() => Colors.red;

Color notSelectedPatternLock() => Colors.amber;

String ginkgoNetIcon =
    'https://git.duniter.org/vjrj/ginkgo/-/raw/master/web/icons/favicon-32x32.png';

final GlobalKey<ScaffoldMessengerState> globalMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

const Color deleteColor = Color(0xFFFE4A49);
const Color positiveAmountColor = Colors.blue;
const Color negativeAmountColor = Colors.red;

bool isSymbolPlacementBefore(String pattern) {
  final int symbolIndex = pattern.indexOf('\u00A4');
  final int numberIndex = pattern.indexOf('#');

  if (symbolIndex < numberIndex) {
    return true;
  } else {
    return false;
  }
}

String currentLocale(BuildContext context) => context.locale.languageCode;

String? validateDecimal(
    {required String sep, required String locale, required String? amount}) {
  final NumberFormat format = NumberFormat.decimalPattern(locale);
  if (amount == null || amount.isEmpty || amount.startsWith(sep)) {
    return null;
  }
  try {
    final num n = format.parse(amount);
    if (n < 0) {
      return tr('enter_a_positive_number');
    }
    final String formattedAmount = format.format(n);
    if (formattedAmount != amount) {
      return tr('enter_a_valid_number');
    }
  } catch (e) {
    return tr('enter_a_valid_number');
  }
  return null;
}

Future<bool> openUrl(String url) async {
  final Uri uri = Uri.parse(url);
  return await canLaunchUrl(uri)
      ? await launchUrl(uri, mode: LaunchMode.externalNonBrowserApplication)
      : throw Exception('Could not launch $url');
}

void showQrDialog({
  required BuildContext context,
  required String publicKey,
  bool noTitle = false,
  String? feedbackText,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.8,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onTap: () => copyPublicKeyToClipboard(
                        context, publicKey, feedbackText),
                    child: Container(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey[900]
                          : Colors.grey[100],
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: <Widget>[
                          if (!noTitle) Text(tr('show_qr_to_client')),
                          if (!noTitle) const SizedBox(height: 10),
                          Expanded(
                              child: QrImage(
                            data: publicKey,
                            size: MediaQuery.of(context).size.width * 0.8,
                            gapless: false,
                            foregroundColor:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                          )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  maxLines: 2,
                  initialValue: publicKey,
                  readOnly: true,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.content_copy),
                      onPressed: () {
                        copyPublicKeyToClipboard(
                            context, publicKey, feedbackText);
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      );
    },
  );
}

bool get isIOS => !kIsWeb && Platform.isIOS;
