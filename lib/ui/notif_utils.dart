import 'package:easy_localization/easy_localization.dart';

import 'currency_helper.dart';
import 'notification_translations_helper.dart';

/// Build notification title using easy_localization context.
///
/// Falls back to static translation loading if easy_localization is not available.
String buildTxNotifTitle(String? from, {String? languageCode}) {
  final String key = from != null
      ? 'notification_new_payment_title'
      : 'notification_new_sent_title';

  // Try to use easy_localization first (if available)
  try {
    return tr(key);
  } catch (e) {
    // Fallback to static translation loading
    // This happens in background isolates or web service workers
    if (languageCode != null) {
      return NotificationTranslationsHelper.get(languageCode, key,
          fallback: key);
    }
    // Last resort: return the key
    return key;
  }
}

/// Build notification description using easy_localization context.
///
/// Falls back to static translation loading if easy_localization is not available.
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
