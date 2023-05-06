import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/contact.dart';
import '../../../data/models/node_list_cubit.dart';
import '../../../data/models/node_type.dart';
import '../../../data/models/payment_cubit.dart';
import '../../../data/models/transaction.dart';
import '../../../data/models/transaction_cubit.dart';
import '../../../data/models/transaction_type.dart';
import '../../../g1/api.dart';
import '../../../shared_prefs.dart';
import 'contacts_cache.dart';
import 'logger.dart';
import 'ui_helpers.dart';

Future<void> payWithRetry(BuildContext context, Contact to, double amount,
    String comment, bool useMempool,
    [bool addPending = false]) async {
  logger('Trying to pay state with useMempool: $useMempool');
  final TransactionCubit txCubit = context.read<TransactionCubit>();
  final PaymentCubit paymentCubit = context.read<PaymentCubit>();
  paymentCubit.sending();
  final String contactPubKey = to.pubKey;
  final bool? confirmed = await _confirmSend(
      context, amount.toString(), humanizePubKey(contactPubKey));
  final Contact fromContact =
      await ContactsCache().getContact(SharedPreferencesHelper().getPubKey());

  if (confirmed == null || !confirmed) {
    paymentCubit.sentFailed();
  } else {
    final String response =
        await pay(to: contactPubKey, comment: comment, amount: amount);
    if (response == 'success') {
      paymentCubit.sent();
      if (!context.mounted) {
        return;
      }
      showTooltip(
          context, tr('payment_successful'), tr('payment_successful_desc'));

      // Add here the transaction to the pending list (so we can check it the tx is confirmed)
      if (inDevelopment && addPending) {
        txCubit.addPendingTransaction(Transaction(
            type: TransactionType.pending,
            from: fromContact,
            to: to,
            amount: amount,
            comment: comment,
            time: DateTime.now()));
      }
    } else {
      /* this retry didn't work
        if (!useMempool) {
          throw RetryException();
        } */
      if (!context.mounted) {
        return;
      }
      final bool failedWithBalance =
          response == 'insufficient balance' && weHaveBalance(context, amount);
      showPayError(
          context,
          failedWithBalance
              ? tr('payment_error_retry')
              : tr('payment_error_desc', namedArgs: <String, String>{
                  // We try to translate the error, like "insufficient balance"
                  'error': tr(response)
                }));
    }
  }
}

bool weHaveBalance(BuildContext context, double amount) {
  final double balance = getBalance(context);
  final bool weHave = balance >= amount * 100;
  return weHave;
}

double getBalance(BuildContext context) =>
    context.read<TransactionCubit>().balance;

Future<bool?> _confirmSend(
    BuildContext context, String amount, String to) async {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(tr('please_confirm_sent')),
        content: Text(tr('please_confirm_sent_desc',
            namedArgs: <String, String>{'amount': amount, 'to': to})),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(tr('cancel')),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(tr('yes_sent')),
          ),
        ],
      );
    },
  );
}

void showPayError(BuildContext context, String desc) {
  showTooltip(context, tr('payment_error'), desc);
  context.read<PaymentCubit>().sentFailed();
  // Shuffle the nodes so we can retry with other
  context.read<NodeListCubit>().shuffle(NodeType.gva, true);
}
