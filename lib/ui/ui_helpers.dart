import 'dart:io';

import 'package:clipboard/clipboard.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fast_image_resizer/fast_image_resizer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

import '../data/models/app_cubit.dart';
import '../data/models/cesium_card.dart';
import '../data/models/contact.dart';
import '../data/models/multi_wallet_transaction_cubit.dart';
import '../data/models/node_list_cubit.dart';
import '../data/models/utxo_cubit.dart';
import '../g1/api.dart';
import '../g1/currency.dart';
import '../g1/g1_helper.dart';
import '../shared_prefs_helper.dart';
import 'logger.dart';
import 'notification_controller.dart';
import 'widgets/first_screen/circular_icon.dart';

Future<dynamic> showAlertDialog(
    BuildContext context, String title, String message) {
  return showDialog(
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

void copyToClipboard(
    {required BuildContext context,
    required String uri,
    required String feedbackText}) {
  FlutterClipboard.copy(uri).then((dynamic value) =>
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(tr(feedbackText)))));
}

const Color defAvatarBgColor = Colors.grey;
const Color defAvatarColor = Colors.white;
const double defAvatarStoreSize = 44;
const double defAvatarUiSize = 24;

Widget avatar(Uint8List? rawAvatar,
    {Color color = defAvatarColor,
    Color bgColor = defAvatarBgColor,
    double avatarSize = defAvatarUiSize}) {
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

String humanizeContacts(
    {required String publicAddress, required List<Contact> contacts}) {
  if (contacts.length > 3) {
    return '${contacts.take(3).map((Contact contact) => humanizeContact(publicAddress, contact)).join(', ')}...';
  } else if (contacts.length > 1) {
    final String lastContact = humanizeContact(publicAddress, contacts.last);
    final String otherContacts = contacts
        .take(contacts.length - 1)
        .map((Contact contact) => humanizeContact(publicAddress, contact))
        .join(', ');
    return tr('others_and_someone', namedArgs: <String, String>{
      'others': otherContacts,
      'someone': lastContact,
    });
  } else {
    return contacts
        .map((Contact contact) => humanizeContact(publicAddress, contact))
        .join(', ');
  }
}

String humanizeContact(String publicAddress, Contact contact,
    [bool addKey = false,
    bool minimal = false,
    String Function(String s) trf = tr]) {
  if (isMe(contact, publicAddress)) {
    return trf('your_wallet');
  } else {
    final String pubKey = humanizePubKey(contact.pubKey);
    final String pubKeyMin = humanizePubKey(contact.pubKey, minimal);
    final bool titleNotTheSameAsPubKey = contact.title != pubKey;
    return addKey && titleNotTheSameAsPubKey
        ? minimal
            ? '${contact.title} $pubKeyMin'
            : '${contact.title} ($pubKey)'
        : titleNotTheSameAsPubKey
            ? contact.title
            : pubKey;
  }
}

bool isMe(Contact contact, String publicAddress) =>
    extractPublicKey(contact.pubKey) == extractPublicKey(publicAddress);

String humanizePubKey(String rawAddress, [bool minimal = false]) {
  final String address = extractPublicKey(rawAddress);
  return minimal
      ? '\u{1F511} ${simplifyPubKey(address).substring(0, 4)}'
      : '\u{1F511} ${simplifyPubKey(address)}';
}

String simplifyPubKey(String address) => address.length <= 8
    ? 'WRONG ADDRESS'
    : '${address.substring(0, 4)}…${address.substring(address.length - 4)}';

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
    locale: eo(locale),
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

// NumberFormat does not work with esperanto nowadays, so we use
// this fallback
// https://en.wikipedia.org/wiki/Decimal_separator
// The three most spoken international auxiliary languages, Ido, Esperanto, and
// Interlingua, all use the comma as the decimal separator.
String eo(String locale) => locale == 'eo' ? 'es' : locale;

double parseToDoubleLocalized(
        {required String locale, required String number}) =>
    NumberFormat.decimalPattern(eo(locale)).parse(number).toDouble();

String localizeNumber(BuildContext context, double amount) =>
    NumberFormat.decimalPattern(eo(currentLocale(context))).format(amount);

Future<Contact> contactFromResultSearch(Map<String, dynamic> record,
    {bool resize = true}) async {
  final Map<String, dynamic> source = record['_source'] as Map<String, dynamic>;
  final Uint8List? avatarBase64 = await _getAvatarFromResults(source, resize);
  return Contact(
      pubKey: record['_id'] as String,
      name: source['title'] as String,
      avatar: avatarBase64);
}

Future<Uint8List?> _getAvatarFromResults(
    Map<String, dynamic> source, bool resize) async {
  Uint8List? avatarBase64;
  if (source['avatar'] != null) {
    final Map<String, dynamic> avatar =
        source['avatar'] as Map<String, dynamic>;
    avatarBase64 = imageFromBase64String(
        'data:${avatar['_content_type']};base64,${avatar['_content']}');
  }
  if (avatarBase64 != null && avatarBase64.isNotEmpty) {
    final Uint8List? avatarBase64resized =
        resize ? await resizeAvatar(avatarBase64) : avatarBase64;
    return avatarBase64resized;
  } else {
    return null;
  }
}

Future<Uint8List?> resizeAvatar(Uint8List avatarBase64) async {
  final ByteData? bytes =
      await resizeImage(avatarBase64, height: defAvatarStoreSize.toInt() * 2);
  return bytes != null ? Uint8List.view(bytes.buffer) : null;
}

final RegExp basicEnglishCharsRegExp =
    RegExp(r'^[ A-Za-z0-9\s.;:!?()\-_;!@&<>%]*$');
final RegExp basicEnglishCharsRegExpNegative =
    RegExp(r'[^ A-Za-z0-9\s.;:!?()\-_;!@&<>%]');

String cleanComment(String? comment) {
  return comment == null
      ? ''
      : comment.replaceAllMapped(
          basicEnglishCharsRegExpNegative, (Match match) => ' ');
}

void initGetItAll() {
  final GetIt getIt = GetIt.instance;
  if (!getIt.isRegistered<MultiWalletTransactionCubit>()) {
    getIt.registerSingleton<MultiWalletTransactionCubit>(
        MultiWalletTransactionCubit());
    getIt.registerSingleton<AppCubit>(AppCubit());
    getIt.registerSingleton<NodeListCubit>(NodeListCubit());
    getIt.registerSingleton<UtxoCubit>(UtxoCubit());
  }
}

Future<void> fetchTransactionsFromBackground([bool init = true]) async {
  try {
    if (init) {
      await hydratedInit();
      if (SharedPreferencesHelper().cards.isEmpty) {
        await SharedPreferencesHelper().init();
      }
      try {
        initGetItAll();
        await NotificationController.initializeLocalNotifications();
      } catch (e) {
        // We should try to do this better
        loggerDev(e.toString());
        if (inDevelopment) {
          NotificationController.notify(
              title: 'Background process failed',
              desc: e.toString(),
              id: DateTime.now().toIso8601String());
        }
      }
    }
    loggerDev('Initialized background context');
    final GetIt getIt = GetIt.instance;
    final AppCubit appCubit = getIt.get<AppCubit>();
    final MultiWalletTransactionCubit transCubit =
        getIt.get<MultiWalletTransactionCubit>();
    final NodeListCubit nodeListCubit = getIt.get<NodeListCubit>();
    for (final CesiumCard card in SharedPreferencesHelper().cards) {
      loggerDev('Fetching transactions for ${card.pubKey} in background');
      transCubit.fetchTransactions(nodeListCubit, appCubit,
          pubKey: card.pubKey);
    }
    if (inDevelopment) {
      NotificationController.notify(
          title: 'Background process ended correctly',
          desc: '',
          id: DateTime.now().toIso8601String());
    }
  } catch (e) {
    // We should try to do this better
    loggerDev(e.toString());
  }
}

Future<void> fetchTransactions(BuildContext context) async {
  final AppCubit appCubit = context.read<AppCubit>();
  final MultiWalletTransactionCubit transCubit =
      context.read<MultiWalletTransactionCubit>();
  final NodeListCubit nodeListCubit = context.read<NodeListCubit>();
  for (final CesiumCard card in SharedPreferencesHelper().cards) {
    transCubit.fetchTransactions(nodeListCubit, appCubit, pubKey: card.pubKey);
  }
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
    // Disable for now
    //   _start();
  }

  // Based in https://github.com/letsar/flutter_slidable/issues/288
  // ignore: unused_element
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

Widget contactToListItem(Contact contact, int index, BuildContext context,
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
  return NumberFormat.decimalPattern(eo(currentLocale(context)))
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
    {required String sep,
    required String locale,
    required String? amount,
    required String Function(String s) tr}) {
  final NumberFormat format = NumberFormat.decimalPattern(eo(locale));
  if (amount == null || amount.isEmpty || amount.startsWith(sep)) {
    return null;
  }
  try {
    final num n = format.parse(amount);
    if (n < 0) {
      return tr('enter_a_positive_number');
    }
    final String formattedAmount = format.format(n);
    if (amount.contains(sep) && amount.endsWith('0')) {
      // remove trailing zeros in 0.10 == 0.1
      amount = amount.replaceAll(RegExp(r'0*$'), '');
    }
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
                      color:
                          isDark(context) ? Colors.grey[900] : Colors.grey[100],
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: <Widget>[
                          if (!noTitle) Text(tr('show_qr_to_client')),
                          if (!noTitle) const SizedBox(height: 10),
                          Expanded(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                QrImageView(
                                  // version: QrVersions.auto,
                                  data: publicKey,
                                  size: MediaQuery.of(context).size.width * 0.5,
                                  // gapless: false,
                                  /* embeddedImage: const AssetImage(
                                    'assets/img/gbrevedot_color.png',
                                  ),
                                  embeddedImageStyle:
                                      const QrEmbeddedImageStyle(
                                    size: Size(80, 80),
                                  ), */
                                  eyeStyle: QrEyeStyle(
                                      eyeShape: QrEyeShape.square,
                                      color: isDark(context)
                                          ? Theme.of(context).hintColor
                                          : Theme.of(context).primaryColor),
                                  dataModuleStyle: QrDataModuleStyle(
                                      dataModuleShape: QrDataModuleShape.square,
                                      color: isDark(context)
                                          ? Colors.white
                                          : Colors.black),
                                )
                              ])),
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

bool isDark(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark;

bool get isIOS => !kIsWeb && Platform.isIOS;

const String g1nkgoUserNameSuffix = ' ❥';
const String protectedUserNameSuffix = ' 🔒';
const double cardAspectRatio = 1.58;

Future<void> hydratedInit() async {
  await Hive.initFlutter();

  // Reset hive old keys
  if (kIsWeb) {
    final Box<dynamic> box = await Hive.openBox('hydrated_box',
        path: HydratedStorage.webStorageDirectory.path);
    final List<dynamic> keysToDelete =
        box.keys.where((dynamic key) => '$key'.startsWith('minified')).toList();
    box.deleteAll(keysToDelete);
    // This should we done after init
    // await HydratedBloc.storage.clear();
    box.close();
  }

  if (kIsWeb) {
    HydratedBloc.storage = await HydratedStorage.build(
        storageDirectory: HydratedStorage.webStorageDirectory);
  } else {
    final Directory tmpDir = await getTemporaryDirectory();
    Hive.init(tmpDir.toString());
    HydratedBloc.storage =
        await HydratedStorage.build(storageDirectory: tmpDir);
  }
}

String buildTxNotifTitle(String? from) {
  final String title = from != null
      ? tr('notification_new_payment_title')
      : tr('notification_new_sent_title');
  return title;
}

String buildTxNotifDescription({
  required String? from,
  required String? to,
  required String? comment,
  required String localeLanguageCode,
  required double amount,
  required bool isG1,
  required double currentUd,
}) {
  final String formattedAmount = formatKAmountInViewWithLocale(
    locale: localeLanguageCode,
    amount: amount,
    isG1: isG1,
    currentUd: currentUd,
    useSymbol: true,
  );
  final String desc = from != null
      ? tr('notification_new_payment_desc', namedArgs: <String, String>{
          'amount': formattedAmount,
          'from': from,
        })
      : tr('notification_new_sent_desc',
          namedArgs: <String, String>{'amount': formattedAmount, 'to': to!});

  return comment != null && comment.isNotEmpty ? '$desc ($comment)' : desc;
}
