import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:fast_image_resizer/fast_image_resizer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

import '../data/models/contact.dart';
import '../data/models/theme_cubit.dart';
import '../g1/currency.dart';
import '../g1/g1_helper.dart';
import 'basic_avatar.dart';
import 'currency_helper.dart';
import 'image_utils.dart';
import 'in_dev_helper.dart';
import 'ipfs_image.dart';
import 'locale_helper.dart';
import 'logger.dart';

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

const Color defAvatarBgColor = Colors.grey;
const Color defAvatarColor = Colors.white;
const double defAvatarStoreSize = 44;
const double defAvatarUiSize = 24;

Widget avatar(Contact c,
    {Color color = defAvatarColor,
    Color bgColor = defAvatarBgColor,
    double avatarSize = defAvatarUiSize,
    bool useIpfs = false}) {
  if (useIpfs && c.avatarCid != null) {
    return CircleAvatar(
      radius: avatarSize,
      child: ClipOval(
        child: IpfsImage(path: c.avatarCid!),
        // fit: BoxFit.cover,
      ),
    );
  }
  return c.avatar != null && c.avatar!.isNotEmpty
      ? CircleAvatar(
          radius: avatarSize,
          child: ClipOval(
              child: Image.memory(
            c.avatar!,
            fit: BoxFit.cover,
          )))
      : const BasicAvatar();
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
    // Use humanizeAddress for V2 contacts, humanizePubKey for V1
    final String addressOrPubKey = contact.createdOnV2
        ? humanizeAddress(contact.address, minimal)
        : humanizePubKey(contact.pubKey, minimal);
    final bool titleNotTheSameAsPubKey = contact.title != addressOrPubKey;
    return addKey && titleNotTheSameAsPubKey
        ? minimal
            ? '${contact.title} $addressOrPubKey'
            : '${contact.title} ($addressOrPubKey)'
        : titleNotTheSameAsPubKey
            ? contact.title
            : addressOrPubKey;
  }
}

Color tileColor(int index, BuildContext context, [bool inverse = false]) {
  final ColorScheme colorScheme = Theme.of(context).colorScheme;
  final Color selectedColor = colorScheme.primary.withValues(alpha: 0.1);
  final Color unselectedColor = colorScheme.surface;
  return (inverse ? index.isOdd : index.isEven)
      ? selectedColor
      : unselectedColor;
}

String humanizeTime(DateTime time, String locale, [DateTime? now]) {
  final DateTime localTime = time.isUtc ? time.toLocal() : time;
  return timeago.format(localTime,
      locale: locale, clock: now ?? DateTime.now());
}

String humanizeTimeFull(
    {required String locale, required DateTime utcDateTime}) {
  return DateFormat.yMd(locale).add_Hm().format(utcDateTime.toLocal());
}

const bool txDebugging = false;

const int smallScreenWidth = 360;

bool bigScreen(BuildContext context) =>
    MediaQuery.of(context).size.width > smallScreenWidth;

bool smallScreen(BuildContext context) =>
    MediaQuery.of(context).size.width <= smallScreenWidth;

Future<Contact> contactFromResultSearch(Map<String, dynamic> record,
    {bool resize = true}) async {
  final Map<String, dynamic> source = record['_source'] as Map<String, dynamic>;
  final Uint8List? avatarBase64 = await _getAvatarFromResults(source, resize);
  return Contact(
      pubKey: record['_id'] as String,
      name: source['title'] as String,
      description: source['description'] as String?,
      city: source['city'] as String?,
      geoLoc: source['geoPoint'] is Map<String, dynamic>
          ? LatLng(
              (source['geoPoint'] as Map<String, dynamic>)['lat'] as double,
              (source['geoPoint'] as Map<String, dynamic>)['lon'] as double,
            )
          : null,
      socials: (source['socials'] as List<dynamic>?)
          ?.map((dynamic social) =>
              Map<String, String>.from(social as Map<String, dynamic>))
          .toList(),
      time: source['time'] != null
          ? DateTime.fromMillisecondsSinceEpoch((source['time'] as int) * 1000)
          : null,
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
  return checkAndResizeAvatar(avatarBase64, resize);
}

Future<Uint8List?> checkAndResizeAvatar(
    Uint8List? avatarBase64, bool resize) async {
  try {
    if (avatarBase64 != null && avatarBase64.isNotEmpty) {
      final Uint8List? avatarBase64resized =
          resize ? await resizeAvatar(avatarBase64) : avatarBase64;
      return avatarBase64resized;
    } else {
      return null;
    }
  } catch (e) {
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

bool showShare() => onlyInDevelopment || !kIsWeb;

String assets(String str) =>
    kIsWeb || isAndroid() || (!kIsWeb && Platform.isLinux)
        ? 'assets/$str'
        : str;

Future<Directory?> getAppSpecificExternalFilesDirectory(
    [bool ext = false]) async {
  try {
    if (ext) {
      return await getExternalStorageDirectory();
    }
    // FilePicker uses SAF on Android which doesn't need directory access
    return await getDownloadsDirectory();
  } catch (e) {
    loggerDev('Error getting external storage directory: $e');
    // Fallback to app documents directory
    return getApplicationDocumentsDirectory();
  }
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
    'https://astroport.one/zelkova/icons/favicon-32x32.png';

final GlobalKey<ScaffoldMessengerState> globalMessengerKey =
    GlobalKey<ScaffoldMessengerState>(debugLabel: 'globalMessengerKey');

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

    if (amount.contains(sep) && amount.endsWith('0')) {
      // remove trailing zeros in 0.10 == 0.1
      amount = amount.replaceAll(RegExp(r'0*$'), '');
    }
    final String normalizedInput =
        amount.replaceAll(format.symbols.GROUP_SEP, '');
    final String formattedAmount = format.format(n);
    final String normalizedFormattedAmount =
        formattedAmount.replaceAll(format.symbols.GROUP_SEP, '');

    if (normalizedInput != normalizedFormattedAmount) {
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

Future<void> resetBrightness() async {
  try {
    await ScreenBrightness.instance.resetApplicationScreenBrightness();
  } catch (e) {
    loggerDev('Error setting brightness: $e');
  }
}

Future<void> setHighBrightness() async {
  try {
    // Per-app window brightness; does not require WRITE_SETTINGS.
    await ScreenBrightness.instance.setApplicationScreenBrightness(1.0);
  } catch (e) {
    loggerDev('Error setting brightness: $e');
  }
}

bool isBrightnessSupported() {
  return !kIsWeb &&
      (Platform.isAndroid ||
          Platform.isIOS ||
          Platform.isMacOS ||
          Platform.isWindows);
}

bool isDark(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark;

bool get isIOS => !kIsWeb && Platform.isIOS;

// Hide paste button on web platforms due to clipboard API limitations
// Users can still paste manually using browser's context menu
bool isIOSWeb() {
  return kIsWeb;
}

@Deprecated('Not useful in v2')
const String g1nkgoUserNameSuffix = ' ❥';
@Deprecated('Not useful in v2')
const String protectedUserNameSuffix = ' 🔒'; // lock
const double cardAspectRatio = 1.58;

Future<bool> requestStoragePermission(BuildContext context) async {
  // Storage Access Framework (SAF) handles file access on Android without needing
  // READ/WRITE_EXTERNAL_STORAGE permissions. FilePicker and file operations
  // use SAF automatically on Android 11+.
  // This function is kept for backward compatibility but doesn't need to do anything.
  return true;
}

Future<Directory?> getGinkgoDownloadDirectory() async {
  try {
    // Try to get Downloads directory first
    final Directory? downloadsDir = await getDownloadsDirectory();
    if (downloadsDir != null) {
      return downloadsDir;
    }
  } catch (e) {
    loggerDev('Failed to get downloads directory: $e');
  }

  try {
    // Fallback to app-specific external storage
    return await getExternalStorageDirectory();
  } catch (e) {
    loggerDev('Failed to get external storage directory: $e');
  }

  // Last resort: app documents directory
  try {
    return await getApplicationDocumentsDirectory();
  } catch (e) {
    loggerDev('Failed to get application documents directory: $e');
    return null;
  }
}

bool isAndroid() => !kIsWeb && Platform.isAndroid;

bool isDesktopPlatform() =>
    !kIsWeb && (Platform.isLinux || Platform.isMacOS || Platform.isWindows);

Future<Directory> getAppDataDirectory() async {
  if (isDesktopPlatform()) {
    return getApplicationSupportDirectory();
  }
  return getApplicationDocumentsDirectory();
}

String truncateName(String name) =>
    name.length > 15 ? '${name.substring(0, 15)}…' : name;

String removeNewlines(String input) {
  return input.replaceAll('\n', ' ').replaceAll('\r', ' ');
}

WidgetSpan separatorSpan() {
  return const WidgetSpan(
    alignment: PlaceholderAlignment.top,
    child: SizedBox(width: 3),
  );
}

TextSpan humanizeAmount(
    bool isCurrencyBefore,
    BuildContext context,
    bool isG1,
    bool small,
    String currentSymbol,
    double balanceFontSize,
    double balance,
    double currentUd,
    {Color? color,
    Currency? currency,
    bool isBalance = false}) {
  return TextSpan(
    children: <InlineSpan>[
      if (isCurrencyBefore)
        currencyBalanceWidget(
            context, isG1, currentSymbol, balanceFontSize, small),
      if (isCurrencyBefore) separatorAmountSpan(small),
      TextSpan(
        text: formatKAmountInView(
            context: context,
            amount: balance,
            isG1: isG1,
            currentUd: currentUd,
            useSymbol: false,
            currency: currency,
            isBalance: isBalance),
        style: TextStyle(
            fontSize: balanceFontSize,
            color: color ??
                (context.read<ThemeCubit>().isDark()
                    ? Colors.white
                    : positiveAmountColor),
            fontWeight: small ? FontWeight.normal : FontWeight.bold),
      ),
      if (!isCurrencyBefore) separatorAmountSpan(small),
      if (!isCurrencyBefore)
        currencyBalanceWidget(
            context, isG1, currentSymbol, balanceFontSize, small),
    ],
  );
}

String humanizeAmountS(
    bool isCurrencyBefore,
    BuildContext context,
    bool isG1,
    bool small,
    String currentSymbol,
    double balanceFontSize,
    double balance,
    double currentUd,
    [Color? color]) {
  final StringBuffer result = StringBuffer();
  if (isCurrencyBefore) {
    result.write(currencyBalanceWidget(
            context, isG1, currentSymbol, balanceFontSize, small)
        .toPlainText());
    result.write(' ');
  }
  result.write(formatKAmountInView(
      context: context,
      amount: balance,
      isG1: isG1,
      currentUd: currentUd,
      useSymbol: false));
  if (!isCurrencyBefore) {
    result.write(' ');
    result.write(currencyBalanceWidget(
            context, isG1, currentSymbol, balanceFontSize, small)
        .toPlainText());
  }
  return result.toString();
}

extension DateTimeExtension on DateTime {
  DateTime startOfDay() {
    return DateTime(year, month, day);
  }
}

InlineSpan currencyBalanceWidget(BuildContext context, bool isG1,
    String currentSymbol, double balanceFontSize, bool small) {
  const Color currencyColor = Colors.grey;
  return TextSpan(children: <InlineSpan>[
    TextSpan(
      text: currentSymbol,
      style: TextStyle(
        fontSize: balanceFontSize,
        fontWeight: FontWeight.w500,
        color: currencyColor,
      ),
    ),
    if (!isG1)
      WidgetSpan(
          child: Transform.translate(
              offset: Offset(2, small ? 8 : 16),
              child: Text(
                'Ğ1',
                style: TextStyle(
                  fontSize: balanceFontSize - (small ? 5 : 10),
                  fontWeight: FontWeight.w500,
                  // fontFeatures: <FontFeature>[FontFeature.subscripts()],
                  color: currencyColor,
                ),
              )))
  ]);
}

InlineSpan separatorAmountSpan(bool small) {
  return WidgetSpan(
    child: SizedBox(width: small ? 4 : 7),
  );
}

String todayS(DateTime now) => DateFormat('yyyyMMddHHmm').format(now);

double calcWidthWithResponsive(BuildContext context) {
  return ResponsiveBreakpoints.of(context).largerThan(MOBILE)
      ? MediaQuery.of(context).size.width / 2
      : MediaQuery.of(context).size.width;
}

String? humanizeTimeFuture(String locale, int expireOn) {
  final DateTime expiryDate = DateTime.now().add(Duration(seconds: expireOn));

  return timeago.format(expiryDate,
      locale: locale, clock: DateTime.now(), allowFromNow: true);
}

// https://stackoverflow.com/a/79303317
int colorToValue(Color color) {
  final int a = (color.a * 255).round();
  final int r = (color.r * 255).round();
  final int g = (color.g * 255).round();
  final int b = (color.b * 255).round();

  // Combine the components into a single int using bit shifting
  return (a << 24) | (r << 16) | (g << 8) | b;
}
