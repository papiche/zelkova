import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sn_progress_dialog/options/completed.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../data/models/bottom_nav_cubit.dart';
import '../data/models/contact.dart';
import '../data/models/multi_wallet_transaction_cubit.dart';
import '../data/models/node.dart';
import '../data/models/node_manager.dart';
import '../data/models/node_type.dart';
import '../data/models/payment_cubit.dart';
import '../data/models/payment_state.dart';
import '../data/models/transaction.dart';
import '../data/models/transaction_type.dart';
import '../g1/api.dart';
import '../g1/currency.dart';
import '../g1/g1_helper.dart';
import '../g1/pay_result.dart';
import '../shared_prefs_helper.dart';
import 'contacts_cache.dart';
import 'logger.dart';
import 'secure_unlock_widget.dart';
import 'ui_helpers.dart';
import 'widgets/connectivity_widget_wrapper_wrapper.dart';
import 'widgets/default_progress_dialog.dart';

Future<bool> payWithRetry(
    {required BuildContext context,
    required List<Contact> recipients,
    required double amount,
    required String comment,
    bool isRetry = false,
    required bool isG1,
    required double currentUd,
    Currency? currency,
    bool useBMA = false}) async {
  assert(amount > 0);
  final bool isToMultiple = recipients.length > 1;
  final bool hasPass = await walletAuth(context);
  if (hasPass) {
    if (context.mounted) {
      final MultiWalletTransactionCubit txCubit =
          context.read<MultiWalletTransactionCubit>();
      final PaymentCubit paymentCubit = context.read<PaymentCubit>();
      paymentCubit.sending();
      final String fromPubKey = SharedPreferencesHelper().getPubKey();

      final Currency paymentCurrency = currency ?? Currency.ZEN;
      final bool? confirmed = await _confirmSend(context, amount.toString(),
          fromPubKey, recipients, isRetry, paymentCurrency, isToMultiple,
          isG1: isG1, currentUd: currentUd);

      if (confirmed == null || !confirmed) {
        paymentCubit.sentFailed();
        return false;
      }

      // Show progress dialog immediately after confirmation
      if (!context.mounted) {
        return false;
      }
      final ProgressDialog pd = ProgressDialog(context: context);
      pd.show(
        progressType: defProgressType,
        msg: tr('tx_processing'),
        hideValue: defProgressHideValue,
        progressBgColor: defProgressBgColor,
        barrierDismissible: defProgressBarrierDismissible,
        msgMaxLines: defProgressMsgMaxLines,
        completed: Completed(),
      );

      try {
        final Contact fromContact =
            await ContactsCache().getContact(fromPubKey);

        if (!context.mounted) {
          pd.close();
          return false;
        }
        final double convertedAmount = toG1(amount, isG1, currentUd, currency: currency);

        // For v2 payments with multiple recipients, create separate pending transactions
        // for each recipient to match on-chain batch transactions
        final List<Transaction> pendingTransactions =
            recipients.map((Contact recipient) {
          return Transaction(
              type: TransactionType.pending,
              from: fromContact,
              recipients: <Contact>[recipient],
              recipientsAmounts: <double>[amount],
              amount: -toCG1(convertedAmount).toDouble(),
              comment: comment,
              time: DateTime.now());
        }).toList();

        final bool isConnected =
            await ConnectivityWidgetWrapperWrapper.isConnected;
        logger('isConnected: $isConnected');
        if (isConnected != null && !isConnected && !isRetry) {
          pd.close();
          paymentCubit.sent();
          if (!context.mounted) {
            return true;
          }
          showAlertDialog(context, tr('payment_waiting_internet_title'),
              tr('payment_waiting_internet_desc_beta'));
          for (final Transaction pending in pendingTransactions) {
            txCubit.addPendingTransaction(
                pending.copyWith(type: TransactionType.waitingNetwork));
          }
          context.read<BottomNavCubit>().updateIndex(3);
          return true;
        } else {
          // PAY!
          logger('Starting payment process...');
          PayResult result;

          logger(
              'Calling pay() with recipients: ${recipients.map((Contact c) => c.pubKey).toList()}');
          result = await pay(
              to: recipients.map((Contact c) => c.pubKey).toList(),
              comment: comment,
              amount: convertedAmount);
          logger('pay() returned with result: ${result.message}');

          // Update pending transactions with debug info
          final List<Transaction> updatedPendingTxs =
              pendingTransactions.map((Transaction tx) {
            return tx.copyWith(
                debugInfo:
                    'Node used: ${result != null && result.node != null ? result.node!.url : 'unknown'}');
          }).toList();

          if (result.progressStream != null) {
            // Progress dialog already shown, just listen to stream updates
            result.progressStream!.listen(
              (String progressMessage) {
                pd.update(msg: progressMessage);
              },
              onDone: () async {
                await Future<dynamic>.delayed(
                    const Duration(milliseconds: 1000));
                if (!context.mounted) {
                  return;
                }
                _onPaymentWIthProgressDone(
                    pd, context, isRetry, txCubit, updatedPendingTxs);
              },
              onError: (dynamic error) {
                if (!context.mounted) {
                  return;
                }
                _onPaymentWithProgressError(
                    pd, isRetry, txCubit, updatedPendingTxs, context, error);
              },
            );
          } else {
            if (result.message == 'success') {
              pd.close();
              paymentCubit.sent();
              // ignore: use_build_context_synchronously
              if (!context.mounted) {
                return true;
              }
              showAlertDialog(context, tr('payment_successful'),
                  tr('payment_successful_desc'));
              if (!isRetry) {
                // Add here the transactions to the pending list (so we can check if they are confirmed)
                updatedPendingTxs.forEach(txCubit.addPendingTransaction);
              } else {
                // Update the previously failed txs with an update time and type pending
                for (final Transaction pending in updatedPendingTxs) {
                  txCubit.updatePendingTransaction(
                      pending.copyWith(type: TransactionType.pending));
                }
              }
              // Refresh transactions to ensure pending transactions are shown
              txCubit.fetchTransactions(pubKey: fromContact.pubKey);
              context.read<BottomNavCubit>().updateIndex(3);
              return true;
            } else {
              pd.close();
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
              _addPending(isRetry, txCubit, updatedPendingTxs, context);
              return false;
            }
          }
        }
      } catch (e) {
        pd.close();
        rethrow;
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

void _onPaymentWIthProgressDone(
    ProgressDialog pd,
    BuildContext context,
    bool isRetry,
    MultiWalletTransactionCubit txCubit,
    List<Transaction> pendingTransactions) {
  pd.close();

  // Mark payment as sent in the UI state
  context.read<PaymentCubit>().sent();

  // Add the transactions to the pending list
  if (!isRetry) {
    pendingTransactions.forEach(txCubit.addPendingTransaction);
  } else {
    for (final Transaction pending in pendingTransactions) {
      txCubit.updatePendingTransaction(
          pending.copyWith(type: TransactionType.pending));
    }
  }

  // Refresh transactions to ensure pending transactions are shown
  if (pendingTransactions.isNotEmpty) {
    final String fromPubKey = pendingTransactions.first.from.pubKey;
    txCubit.fetchTransactions(pubKey: fromPubKey);
  }

  context.read<BottomNavCubit>().updateIndex(3);
}

void _onPaymentWithProgressError(
    ProgressDialog pd,
    bool isRetry,
    MultiWalletTransactionCubit txCubit,
    List<Transaction> pendingTransactions,
    BuildContext context,
    dynamic error) {
  pd.close();
  _addPending(isRetry, txCubit, pendingTransactions, context);
  showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(tr('payment_error')),
      content: Text(error is String ? error : 'Unknown error'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(tr('accept')),
        ),
      ],
    ),
  );
}

void _addPending(bool isRetry, MultiWalletTransactionCubit txCubit,
    List<Transaction> pendingTransactions, BuildContext context) {
  if (!isRetry) {
    for (final Transaction pending in pendingTransactions) {
      txCubit.insertPendingTransaction(
          pending.copyWith(type: TransactionType.failed));
    }
    context.read<BottomNavCubit>().updateIndex(3);
  } else {
    // Update the previously failed txs with type pending
    for (final Transaction pending in pendingTransactions) {
      txCubit.updatePendingTransaction(
          pending.copyWith(type: TransactionType.failed));
    }
  }
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
    bool isPayToMultiple,
    {required bool isG1,
    required double currentUd}) async {
  // Validate that user is not trying to pay to themselves
  for (final Contact recipient in recipients) {
    if (extractPublicKey(recipient.pubKey) == extractPublicKey(fromPubKey)) {
      if (context.mounted) {
        showAlertDialog(context, tr('payment_error'),
            tr("You can't send money to yourself."));
      }
      return false;
    }
  }

  final String amountWithCurrency = '$amount ${currency.name()}';

  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(tr('please_confirm_sent')),
        content: isPayToMultiple
            ? Text(tr('please_confirm_sent_multi_desc',
                namedArgs: <String, String>{
                    'amount': amountWithCurrency,
                    'currency': '',
                    'people': recipients.length.toString()
                  }))
            : Text(tr(
                isRetry
                    ? 'please_confirm_retry_sent_desc'
                    : 'please_confirm_sent_desc',
                namedArgs: <String, String>{
                    'amount': amountWithCurrency,
                    'to': humanizeContact(fromPubKey, recipients[0], true),
                    'currency': ''
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
    NodeManager().increaseNodeErrors(NodeType.endpoint, node,
        cause: 'Payment error: $desc');
  }
}

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
