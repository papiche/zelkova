import 'dart:async';

import 'package:durt/durt.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuple/tuple.dart';

import '../../../data/models/contact.dart';
import '../../../data/models/node_type.dart';
import '../../../data/models/payment_cubit.dart';
import '../../../data/models/transaction.dart';
import '../../../data/models/transaction_type.dart';
import '../../../g1/api.dart';
import '../../../shared_prefs_helper.dart';
import '../data/models/app_cubit.dart';
import '../data/models/bottom_nav_cubit.dart';
import '../data/models/multi_wallet_transaction_cubit.dart';
import '../data/models/node.dart';
import '../data/models/node_manager.dart';
import '../data/models/payment_state.dart';
import '../data/models/utxo.dart';
import '../data/models/utxo_cubit.dart';
import '../g1/currency.dart';
import '../g1/g1_helper.dart';
import 'contacts_cache.dart';
import 'logger.dart';
import 'ui_helpers.dart';
import 'widgets/connectivity_widget_wrapper_wrapper.dart';
import 'widgets/fifth_screen/import_dialog.dart';

Future<bool> payWithRetry(
    {required BuildContext context,
    required List<Contact> recipients,
    required double amount,
    required String comment,
    bool isRetry = false,
    required bool isG1,
    required double currentUd,
    bool useBMA = false}) async {
  assert(amount > 0);
  bool hasPass = false;
  final bool isToMultiple = recipients.length > 1;
  if (!SharedPreferencesHelper().isG1nkgoCard() &&
      !SharedPreferencesHelper().hasVolatile()) {
    hasPass = await showImportCesiumWalletDialog(
            context,
            SharedPreferencesHelper().getPubKey(),
            context.read<BottomNavCubit>().currentIndex) ??
        false;
  } else {
    hasPass = true;
  }
  if (hasPass) {
    if (context.mounted) {
      final MultiWalletTransactionCubit txCubit =
          context.read<MultiWalletTransactionCubit>();
      final PaymentCubit paymentCubit = context.read<PaymentCubit>();
      final AppCubit appCubit = context.read<AppCubit>();
      paymentCubit.sending();
      final String fromPubKey = SharedPreferencesHelper().getPubKey();

      final bool? confirmed = await _confirmSend(context, amount.toString(),
          fromPubKey, recipients, isRetry, appCubit.currency, isToMultiple);
      final Contact fromContact = await ContactsCache().getContact(fromPubKey);
      final CesiumWallet wallet = await SharedPreferencesHelper().getWallet();
      if (!context.mounted) {
        return false;
      }
      final UtxoCubit utxoCubit = context.read<UtxoCubit>();
      final double convertedAmount = toG1(amount, isG1, currentUd);
      if (confirmed == null || !confirmed) {
        paymentCubit.sentFailed();
      } else {
        final Transaction tx = Transaction(
            type: TransactionType.pending,
            from: fromContact,
            to: recipients[0],
            recipients: recipients,
            recipientsAmounts: List<double>.filled(recipients.length, amount),
            amount: -toCG1(convertedAmount).toDouble() * recipients.length,
            comment: comment,
            time: DateTime.now());
        final bool isConnected =
            await ConnectivityWidgetWrapperWrapper.isConnected;
        logger('isConnected: $isConnected');
        if (isConnected != null && !isConnected && !isRetry) {
          paymentCubit.sent();
          if (!context.mounted) {
            return true;
          }
          showAlertDialog(context, tr('payment_waiting_internet_title'),
              tr('payment_waiting_internet_desc_beta'));
          final Transaction pending =
              tx.copyWith(type: TransactionType.waitingNetwork);
          txCubit.addPendingTransaction(pending);
          context.read<BottomNavCubit>().updateIndex(3);
          return true;
        } else {
          // PAY!
          PayResult result;
          if (!useBMA) {
            result = await payWithGVA(
                to: recipients.map((Contact c) => c.pubKey).toList(),
                comment: comment,
                amount: convertedAmount);
          } else {
            await utxoCubit.fetchUtxos(fromPubKey);
            final List<Utxo>? utxos = utxoCubit.consume(convertedAmount);
            final Tuple2<Map<String, dynamic>?, Node> currentBlock =
                await getCurrentBlockGVA();

            if (currentBlock != null && utxos != null) {
              result = await payWithBMA(
                  destPub: recipients[0].pubKey,
                  blockHash: '${currentBlock.item1!['hash']}',
                  blockNumber: '${currentBlock.item1!['number']}',
                  comment: comment,
                  wallet: wallet,
                  utxos: utxos,
                  amount: convertedAmount);
            } else {
              final Node triedNode = currentBlock.item2;
              result = PayResult(
                  message: 'Error retrieving payment data', node: triedNode);
            }
          }

          final Transaction pending = tx.copyWith(
              debugInfo:
                  'Node used: ${result != null && result.node != null ? result.node!.url : 'unknown'}');
          if (result.message == 'success') {
            paymentCubit.sent();
            // ignore: use_build_context_synchronously
            if (!context.mounted) {
              return true;
            }
            showAlertDialog(context, tr('payment_successful'),
                tr('payment_successful_desc'));
            if (!isRetry) {
              // Add here the transaction to the pending list (so we can check it the tx is confirmed)
              txCubit.addPendingTransaction(pending);
            } else {
              // Update the previously failed tx with an update time and type pending
              txCubit.updatePendingTransaction(
                  pending.copyWith(type: TransactionType.pending));
            }
            context.read<BottomNavCubit>().updateIndex(3);
            return true;
          } else {
            paymentCubit.pendingPayment();
            if (!context.mounted) {
              return false;
            }
            final bool failedWithoutBalance =
                result.message == 'insufficient balance' ||
                    result.message == 'Insufficient balance in your wallet';
            showPayError(
                context: context,
                desc: tr('payment_error_desc',
                    namedArgs: <String, String>{'error': tr(result.message)}),
                increaseErrors: !failedWithoutBalance,
                node: result.node);
            if (!isRetry) {
              txCubit.insertPendingTransaction(
                  pending.copyWith(type: TransactionType.failed));
              context.read<BottomNavCubit>().updateIndex(3);
            } else {
              // Update the previously failed tx with an update time and type pending
              txCubit.updatePendingTransaction(
                  pending.copyWith(type: TransactionType.failed));
            }
            return false;
          }
        }
      }
    }
  } else {
    if (context.mounted) {
      showPayError(
          context: context,
          desc: tr('payment_error_no_pass'),
          increaseErrors: false);
    }
    return false;
  }
  return true;
}

bool weHaveBalance(BuildContext context, double amount) {
  final double balance = getBalance(context);
  final bool weHave = balance >= toCG1(amount);
  return weHave;
}

double getBalance(BuildContext context) =>
    context.read<MultiWalletTransactionCubit>().balance();

Future<bool?> _confirmSend(
    BuildContext context,
    String amount,
    String fromPubKey,
    List<Contact> recipients,
    bool isRetry,
    Currency currency,
    bool isPayToMultiple) async {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(tr('please_confirm_sent')),
        content: isPayToMultiple
            ? Text(tr('please_confirm_sent_multi_desc',
                namedArgs: <String, String>{
                    'amount': amount,
                    'currency': currency.name(),
                    'people': recipients.length.toString()
                  }))
            : Text(tr(
                isRetry
                    ? 'please_confirm_retry_sent_desc'
                    : 'please_confirm_sent_desc',
                namedArgs: <String, String>{
                    'amount': amount,
                    'to': humanizeContact(fromPubKey, recipients[0], true),
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

void showPayError(
    {required BuildContext context,
    required String desc,
    required bool increaseErrors,
    Node? node}) {
  showAlertDialog(context, tr('payment_error'), desc);
  context.read<PaymentCubit>().sentFailed();
  if (node != null && increaseErrors) {
    NodeManager().increaseNodeErrors(NodeType.gva, node);
  }
}

const Duration paymentTimeRange = Duration(minutes: 60);

Future<void> onKeyScanned(BuildContext context, String scannedKey) async {
  final PaymentState? pay = parseScannedUri(scannedKey);
  final PaymentCubit paymentCubit = context.read<PaymentCubit>();
  if (pay != null) {
    logger('Scanned $pay');
    final String result = extractPublicKey(pay.contacts[0].pubKey);

    final Contact contact = await ContactsCache().getContact(result);
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
