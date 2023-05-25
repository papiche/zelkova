import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../data/models/contact.dart';
import '../../../data/models/contact_cubit.dart';
import '../../../data/models/transaction.dart';
import '../../../data/models/transaction_cubit.dart';
import '../../../data/models/transaction_state.dart';
import '../../../data/models/transaction_type.dart';
import '../../../shared_prefs.dart';
import '../../contacts_cache.dart';
import '../../pay_helper.dart';
import '../../ui_helpers.dart';
import '../third_screen/contact_form.dart';

class TransactionListItem extends StatelessWidget {
  const TransactionListItem(
      {super.key,
      required this.pubKey,
      required this.transaction,
      required this.index,
      required this.isG1,
      required this.currentUd,
      required this.currentSymbol,
      required this.isCurrencyBefore,
      this.afterCancel,
      this.afterRetry});

  final String pubKey;
  final Transaction transaction;
  final int index;
  final bool isG1;
  final double currentUd;
  final String currentSymbol;
  final bool isCurrencyBefore;

  final VoidCallback? afterCancel;
  final VoidCallback? afterRetry;

  @override
  Widget build(BuildContext context) {
    // logger('TransactionListItem build');
    return BlocBuilder<TransactionCubit, TransactionState>(
        builder: (BuildContext context, TransactionState transBalanceState) =>
            _buildTransactionItem(context, transaction));
  }

  Slidable _buildTransactionItem(
      BuildContext context, Transaction transaction) {
    IconData? icon;
    Color? iconColor;
    String statusText;

    final String amountWithSymbol = formatKAmountInView(
        context: context,
        amount: transaction.amount,
        isG1: isG1,
        currentUd: currentUd,
        useSymbol: false);

    final String amountS =
        '${transaction.amount < 0 ? "" : "+"}$amountWithSymbol';
    statusText = tr('transaction_${transaction.type.name}');
    switch (transaction.type) {
      case TransactionType.pending:
        icon = Icons.schedule;
        iconColor = Colors.grey;
        break;
      case TransactionType.sending:
        icon = Icons.flight_takeoff;
        iconColor = Colors.grey;
        break;
      case TransactionType.receiving:
        icon = Icons.flight_land;
        iconColor = Colors.grey;
        break;
      case TransactionType.failed:
        icon = Icons.warning_amber_rounded;
        iconColor = Colors.red;
        break;
      case TransactionType.sent:
        break;
      case TransactionType.received:
        break;
    }
    final String myPubKey = SharedPreferencesHelper().getPubKey();

    final ContactsCubit contactsCubit = context.read<ContactsCubit>();

    return Slidable(
        // Specify a key if the Slidable is dismissible.
        key: ValueKey<int>(index),
        // The end action pane is the one at the right or the bottom side.
        startActionPane:
            ActionPane(motion: const ScrollMotion(), children: <SlidableAction>[
          if (transaction.isPending)
            SlidableAction(
              onPressed: (BuildContext c) {
                context
                    .read<TransactionCubit>()
                    .removePendingTransaction(transaction);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(tr('payment_canceled')),
                    duration: const Duration(seconds: 3),
                  ),
                );
                afterCancel!();
              },
              backgroundColor: deleteColor,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: tr('cancel_payment'),
            ),
        ]),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: <SlidableAction>[
            if (transaction.type == TransactionType.failed)
              SlidableAction(
                onPressed: (BuildContext c) async {
                  await _retryFailed(context, transaction);
                },
                backgroundColor: Theme.of(context).primaryColorDark,
                foregroundColor: Colors.white,
                icon: Icons.replay,
                label: tr('retry_payment'),
              ),
            if (transaction.type != TransactionType.pending)
              SlidableAction(
                onPressed: (BuildContext c) {
                  final Contact newContact = transaction.isIncoming
                      ? transaction.from
                      : transaction.to;
                  contactsCubit.addContact(newContact);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(tr('contact_added')),
                    ),
                  );
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return ContactEditDialog(
                          contact: newContact,
                          onSave: (Contact c) {
                            context.read<ContactsCubit>().updateContact(c);
                            ContactsCache().saveContact(c);
                          });
                    },
                  );
                },
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                icon: Icons.contacts,
                label: tr('add_contact'),
              ),
          ],
        ),
        child: GestureDetector(
            onLongPress: () {
              if (transaction.isFailed) {
                _retryFailed(context, transaction);
              }
            },
            child: ListTile(
              leading: (icon != null)
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(10, 16, 0, 16),
                      child: Icon(
                        icon,
                        color: iconColor,
                      ))
                  : null,
              tileColor: tileColor(index, context),
              title: Row(
                children: <Widget>[
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          statusText,
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text.rich(
                          TextSpan(
                            children: <InlineSpan>[
                              WidgetSpan(
                                child: Text(
                                  tr('transaction_from_to',
                                      namedArgs: <String, String>{
                                        'from': humanizeContact(
                                            myPubKey, transaction.from),
                                        'to': humanizeContact(
                                            myPubKey, transaction.to)
                                      }),
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              subtitle: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 0, 10),
                child: Text(transaction.comment,
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                    )),
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text.rich(TextSpan(
                    children: <InlineSpan>[
                      if (isCurrencyBefore)
                        currencyBalanceWidget(isG1, currentSymbol),
                      if (isCurrencyBefore) separatorSpan(),
                      TextSpan(
                        text: amountS,
                        style: TextStyle(
                          // fontWeight: FontWeight.bold,
                          color: transaction.type == TransactionType.received ||
                                  transaction.type == TransactionType.receiving
                              ? Colors.blue
                              : Colors.red,
                        ),
                      ),
                      if (!isCurrencyBefore) separatorSpan(),
                      if (!isCurrencyBefore)
                        currencyBalanceWidget(isG1, currentSymbol),
                    ],
                  )),
                  const SizedBox(height: 4.0),
                  Tooltip(
                      message: DateFormat.yMd(currentLocale(context))
                          .add_Hm()
                          .format(transaction.time),
                      child: Text(
                        humanizeTime(transaction.time, currentLocale(context))!,
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey,
                        ),
                      )),
                ],
              ),
            )));
  }

  Future<void> _retryFailed(
      BuildContext context, Transaction transaction) async {
    final double amount = transaction.amount / -100;
    await payWithRetry(
        context: context,
        to: transaction.to,
        amount: isG1 ? amount : amount / currentUd,
        comment: transaction.comment,
        isG1: isG1,
        currentUd: currentUd,
        isRetry: true);
    afterRetry!();
  }
}

WidgetSpan separatorSpan() {
  return const WidgetSpan(
    child: SizedBox(width: 3),
  );
}

InlineSpan currencyBalanceWidget(bool isG1, String currentSymbol) {
  return TextSpan(children: <InlineSpan>[
    TextSpan(
      text: currentSymbol,
      style: const TextStyle(
        color: Colors.black54,
      ),
    ),
    if (!isG1)
      WidgetSpan(
          child: Transform.translate(
              offset: const Offset(1, 4),
              child: const Text(
                'Ğ1',
                style: TextStyle(
                  fontSize: 12,
                  // fontWeight: FontWeight.w500,
                  // fontFeatures: <FontFeature>[FontFeature.subscripts()],
                  color: Colors.black54,
                ),
              )))
  ]);
}
