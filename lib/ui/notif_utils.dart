import 'package:easy_localization/easy_localization.dart';

import 'currency_helper.dart';

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
