import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/contact.dart';
import '../../../data/models/node_list_cubit.dart';
import '../../../data/models/node_type.dart';
import '../../../data/models/payment_cubit.dart';
import '../../../data/models/transaction.dart';
import '../../../data/models/transaction_type.dart';
import '../../../g1/api.dart';
import '../../../shared_prefs_helper.dart';
import '../data/models/app_cubit.dart';
import '../data/models/bottom_nav_cubit.dart';
import '../data/models/multi_wallet_transaction_cubit.dart';
import '../data/models/payment_state.dart';
import '../g1/currency.dart';
import '../g1/g1_helper.dart';
import 'contacts_cache.dart';
import 'logger.dart';
import 'ui_helpers.dart';
import 'widgets/connectivity_widget_wrapper_wrapper.dart';

Future<void> payWithRetry(
    {required BuildContext context,
    required Contact to,
    required double amount,
    required String comment,
    bool isRetry = false,
    bool useMempool = false,
    required bool isG1,
    required double currentUd}) async {
  logger('Trying to pay state with useMempool: $useMempool');

  assert(amount > 0);

  final MultiWalletTransactionCubit txCubit =
      context.read<MultiWalletTransactionCubit>();
  final PaymentCubit paymentCubit = context.read<PaymentCubit>();
  final AppCubit appCubit = context.read<AppCubit>();
  paymentCubit.sending();
  final String fromPubKey = SharedPreferencesHelper().getPubKey();
  final String contactPubKey = to.pubKey;
  final bool? confirmed = await _confirmSend(context, amount.toString(),
      humanizeContact(fromPubKey, to, true), isRetry, appCubit.currency);
  final Contact fromContact = await ContactsCache().getContact(fromPubKey);
  final double convertedAmount = toG1(amount, isG1, currentUd);

  if (confirmed == null || !confirmed) {
    paymentCubit.sentFailed();
  } else {
    final Transaction tx = Transaction(
        type: TransactionType.pending,
        from: fromContact,
        to: to,
        amount: -toCG1(convertedAmount).toDouble(),
        comment: comment,
        time: DateTime.now());
    final bool isConnected = await ConnectivityWidgetWrapperWrapper.isConnected;
    logger('isConnected: $isConnected');
    if (isConnected != null && !isConnected && !isRetry) {
      paymentCubit.sent();
      if (!context.mounted) {
        return;
      }
      showTooltip(context, tr('payment_waiting_internet_title'),
          tr('payment_waiting_internet_desc_beta'));
      final Transaction pending =
          tx.copyWith(type: TransactionType.waitingNetwork);
      txCubit.addPendingTransaction(pending);
      context.read<BottomNavCubit>().updateIndex(3);
      return;
    } else {
      final PayResult result = await pay(
          to: contactPubKey, comment: comment, amount: convertedAmount);
      final Transaction pending = tx.copyWith(
          debugInfo:
              'Node used: ${result.node != null ? result.node!.url : 'unknown'}');
      if (result.message == 'success') {
        paymentCubit.sent();
        // ignore: use_build_context_synchronously
        if (!context.mounted) {
          return;
        }
        showTooltip(
            context, tr('payment_successful'), tr('payment_successful_desc'));

        if (!isRetry) {
          // Add here the transaction to the pending list (so we can check it the tx is confirmed)
          txCubit.addPendingTransaction(pending);
        } else {
          // Update the previously failed tx with an update time and type pending
          txCubit.updatePendingTransaction(pending);
        }
      } else {
        /* this retry didn't work
        if (!useMempool) {
          throw RetryException();
        } */
        paymentCubit.pendingPayment();
        if (!context.mounted) {
          return;
        }
        final bool failedWithBalance =
            result.message == 'insufficient balance' &&
                weHaveBalance(context, amount);
        showPayError(
            context,
            failedWithBalance
                ? tr('payment_error_retry')
                : tr('payment_error_desc', namedArgs: <String, String>{
                    // We try to translate the error, like "insufficient balance"
                    'error': tr(result.message)
                  }));
        if (!isRetry) {
          txCubit.insertPendingTransaction(
              pending.copyWith(type: TransactionType.failed));
          context.read<BottomNavCubit>().updateIndex(3);
        } else {
          // Update the previously failed tx with an update time and type pending
          txCubit.updatePendingTransaction(
              pending.copyWith(type: TransactionType.failed));
        }
      }
    }
  }
}

bool weHaveBalance(BuildContext context, double amount) {
  final double balance = getBalance(context);
  final bool weHave = balance >= toCG1(amount);
  return weHave;
}

double getBalance(BuildContext context) =>
    context.read<MultiWalletTransactionCubit>().balance;

Future<bool?> _confirmSend(BuildContext context, String amount, String to,
    bool isRetry, Currency currency) async {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(tr('please_confirm_sent')),
        content: Text(tr(
            isRetry
                ? 'please_confirm_retry_sent_desc'
                : 'please_confirm_sent_desc',
            namedArgs: <String, String>{
              'amount': amount,
              'to': to,
              'currency': currency.name()
            })),
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

const Duration paymentTimeRange = Duration(minutes: 60);

Future<void> onKeyScanned(BuildContext context, String scannedKey) async {
  final PaymentState? pay = parseScannedUri(scannedKey);
  final PaymentCubit paymentCubit = context.read<PaymentCubit>();
  if (pay != null) {
    logger('Scanned $pay');
    final String result = extractPublicKey(pay.contact!.pubKey);
    final Contact contact = Contact(pubKey: result);
    final double? currentAmount = paymentCubit.state.amount;
    paymentCubit.selectUser(contact);
    if (pay.amount != null) {
      paymentCubit.selectKeyAmount(contact, pay.amount);
    } else {
      paymentCubit.selectKeyAmount(contact, currentAmount);
    }
    if (pay.comment != null) {
      paymentCubit.setComment(pay.comment);
    }
  } else {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(tr('qr_invalid_payment'))));
  }
}
