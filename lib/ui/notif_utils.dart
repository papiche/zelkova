import 'package:easy_localization/easy_localization.dart';

import 'currency_helper.dart';
import 'notification_translations_helper.dart';

/// Build notification title using easy_localization context when available.
///
/// Falls back to static translation loading if easy_localization is not available.
///
/// **Important:** easy_localization's tr() function returns the key itself when
/// the translation is not found, instead of throwing an exception. This method
/// detects that scenario and falls back to static translation loading.
String buildTxNotifTitle(String? from, {String? languageCode}) {
  final String key = from != null
      ? 'notification_new_payment_title'
      : 'notification_new_sent_title';

  // Try to use easy_localization first
  try {
    final String translated = tr(key);
    // If tr() returned something different from the key, it's a real translation
    if (translated != key) {
      return translated;
    }
    // If tr() returned the key itself, fall through to static loading
  } catch (e) {
    // Fall through to static translation loading on any exception
  }

  // Fallback to static translation loading
  // This happens in background isolates or web service workers
  if (languageCode != null) {
    return NotificationTranslationsHelper.get(languageCode, key, fallback: key);
  }
  // Last resort: return the key
  return key;
}

/// Build notification description using easy_localization context.
///
/// Falls back to static translation loading if easy_localization is not available.
///
/// **Important:** easy_localization's tr() function returns the key itself when
/// the translation is not found, instead of throwing an exception. This method
/// detects that scenario and falls back to static translation loading.
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

  // Determine which template key to use
  final String templateKey = from != null
      ? 'notification_new_payment_desc'
      : 'notification_new_sent_desc';

  // Build the template string
  String template;
  try {
    // Try easy_localization first
    template = from != null
        ? tr('notification_new_payment_desc', namedArgs: <String, String>{
            'amount': formattedAmount,
            'from': from,
          })
        : tr('notification_new_sent_desc',
            namedArgs: <String, String>{'amount': formattedAmount, 'to': to!});

    // Check if tr() returned the key itself (meaning translation not found)
    final String expectedKey = from != null
        ? 'notification_new_payment_desc'
        : 'notification_new_sent_desc';
    if (template == expectedKey) {
      // Translation not found, fall through to static loading
      throw Exception('Translation key not found: $expectedKey');
    }
  } catch (e) {
    // Fallback to static translation loading
    // Get the template string with placeholders
    final String placeholderTemplate = NotificationTranslationsHelper.get(
        localeLanguageCode, templateKey,
        fallback: templateKey);

    // Replace placeholders manually
    template = placeholderTemplate
        .replaceAll('{amount}', formattedAmount)
        .replaceAll('{from}', from ?? '')
        .replaceAll('{to}', to ?? '');
  }

  return comment != null && comment.isNotEmpty
      ? '$template ($comment)'
      : template;
}
