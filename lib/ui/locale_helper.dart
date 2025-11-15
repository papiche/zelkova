import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

String currentLocale(BuildContext context) {
  try {
    return context.locale.languageCode;
  } catch (e) {
    // Fallback to Flutter's Localizations when EasyLocalization is not available (e.g., in tests)
    return Localizations.localeOf(context).languageCode;
  }
}
