import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../data/models/bottom_nav_cubit.dart';
import '../../../data/models/contact.dart';
import '../../../data/models/contact_cubit.dart';
import '../../../data/models/multi_wallet_transaction_cubit.dart';
import '../../../data/models/multi_wallet_transaction_state.dart';
import '../../../data/models/payment_cubit.dart';
import '../../../data/models/transaction.dart';
import '../../../data/models/transaction_type.dart';
import '../../../g1/g1_helper.dart';
import '../../../shared_prefs_helper.dart';
import '../../contacts_cache.dart';
import '../../pay_helper.dart';
import '../../ui_helpers.dart';
import '../third_screen/contact_form_dialog.dart';

class TransactionListItem extends StatelessWidget {
  TransactionListItem(
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

  final GlobalKey _menuKey = GlobalKey();
  final String pubKey;
  final Transaction transaction;
  final int index;
  final bool isG1;
  final double currentUd;
  final String currentSymbol;
  final bool isCurrencyBefore;

  final VoidCallback? afterCancel;
  final VoidCallback? afterRetry;
  static const Color grey = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Transaction>(
      future: _enrichTransaction(transaction),
      builder: (BuildContext context, AsyncSnapshot<Transaction> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildTransactionItem(context, transaction);
        } else if (snapshot.hasError) {
          return _buildTransactionItem(context, transaction);
        } else {
          final Transaction transaction = snapshot.data!;
          return BlocBuilder<MultiWalletTransactionCubit,
                  MultiWalletTransactionState>(
              builder: (BuildContext context,
                      MultiWalletTransactionState transBalanceState) =>
                  _buildTransactionItem(context, transaction));
        }
      },
    );
  }

  Widget _buildTransactionItem(BuildContext context, Transaction transaction) {
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
    statusText = transaction.type != TransactionType.waitingNetwork
        ? tr('transaction_${transaction.type.name}')
        : tr('transaction_waiting_network');

    switch (transaction.type) {
      case TransactionType.waitingNetwork:
        icon = Icons.schedule_send;
        iconColor = grey;
        break;
      case TransactionType.pending:
        icon = Icons.flight_takeoff;
        iconColor = Colors.grey[400];
        break;
      case TransactionType.sending:
        icon = Icons.flight_takeoff;
        iconColor = grey;
        break;
      case TransactionType.receiving:
        icon = Icons.flight_land;
        iconColor = grey;
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

    const double txFontSize = 14.0;

    return Slidable(
        // Specify a key if the Slidable is dismissible.

        key: ValueKey<int>(index),
        // The end action pane is the one at the right or the bottom side.
        startActionPane:
            ActionPane(motion: const ScrollMotion(), children: <SlidableAction>[
          if (transaction.isPending)
            SlidableAction(
              onPressed: (BuildContext c) {
                _cancel(context, transaction);
              },
              backgroundColor: deleteColor,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: tr('cancel_payment'),
            ),
          if (transaction.type == TransactionType.sent)
            SlidableAction(
              onPressed: (BuildContext c) async {
                _selectUserToPay(context, transaction);
              },
              backgroundColor: Theme.of(context).primaryColorDark,
              foregroundColor: Colors.white,
              icon: Icons.replay,
              label: tr('pay_again'),
            ),
        ]),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: <SlidableAction>[
            if (transaction.type == TransactionType.waitingNetwork)
              SlidableAction(
                onPressed: (BuildContext c) async {
                  await _payAgain(context, transaction, true);
                },
                backgroundColor: Theme.of(context).primaryColorDark,
                foregroundColor: Colors.white,
                icon: Icons.replay,
                label: tr('retry_payment'),
              ),
            if (transaction.type == TransactionType.failed)
              SlidableAction(
                onPressed: (BuildContext c) async {
                  await _payAgain(context, transaction, true);
                },
                backgroundColor: Theme.of(context).primaryColorDark,
                foregroundColor: Colors.white,
                icon: Icons.replay,
                label: tr('retry_payment'),
              ),
            if (transaction.type != TransactionType.pending &&
                !transaction.isToMultiple)
              SlidableAction(
                onPressed: (BuildContext c) {
                  _addContact(transaction, contactsCubit, context);
                },
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                icon: Icons.contacts,
                label: tr('add_contact'),
              ),
          ],
        ),
        child: GestureDetector(
            key: _menuKey,
            onLongPress: () {
              /* if (transaction.isFailed) {
                _payAgain(context, transaction, true);
              } */
              _showPopupMenu(context, transaction);
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
              // FIXME: this does not work
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
                            color: grey,
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
                                        'from':
                                            '${humanizeContact(myPubKey, transaction.from)} 🫴 ',
                                        'to': transaction.isToMultiple
                                            ? humanizeContacts(
                                                fromAddress:
                                                    transaction.from.pubKey,
                                                contacts:
                                                    transaction.recipients)
                                            : humanizeContact(
                                                myPubKey, transaction.to)
                                      }),
                                  style: const TextStyle(
                                    fontSize: txFontSize,
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
                      color: grey,
                    )),
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text.rich(TextSpan(
                    children: <InlineSpan>[
                      if (isCurrencyBefore)
                        currencyBalanceWidget(isG1, currentSymbol, txFontSize),
                      if (isCurrencyBefore) separatorSpan(),
                      TextSpan(
                        text: amountS,
                        style: TextStyle(
                          // fontWeight: FontWeight.bold,
                          fontSize: txFontSize,
                          color: transaction.type == TransactionType.received ||
                                  transaction.type == TransactionType.receiving
                              ? positiveAmountColor
                              : negativeAmountColor,
                        ),
                      ),
                      if (!isCurrencyBefore) separatorSpan(),
                      if (!isCurrencyBefore)
                        currencyBalanceWidget(isG1, currentSymbol, txFontSize)
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
                          color: grey,
                        ),
                      )),
                ],
              ),
            )));
  }

  void _addContact(Transaction transaction, ContactsCubit contactsCubit,
      BuildContext context) {
    final Contact newContact =
        transaction.isIncoming ? transaction.from : transaction.to;
    contactsCubit.addContact(newContact);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(tr('contact_added')),
      ),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ContactFormDialog(
            contact: newContact,
            onSave: (Contact c) {
              context.read<ContactsCubit>().updateContact(c);
              ContactsCache().saveContact(c);
            });
      },
    );
  }

  void _selectUserToPay(BuildContext context, Transaction transaction) {
    context.read<PaymentCubit>().selectUser(
          transaction.to,
        );
    context.read<BottomNavCubit>().updateIndex(0);
  }

  void _cancel(BuildContext context, Transaction transaction) {
    context
        .read<MultiWalletTransactionCubit>()
        .removePendingTransaction(transaction);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(tr('payment_canceled')),
        duration: const Duration(seconds: 3),
      ),
    );
    afterCancel!();
  }

  Future<void> _payAgain(
      BuildContext context, Transaction transaction, bool isRetry) async {
    final double amount = transaction.amount.abs(); // positive
    await payWithRetry(
        context: context,
        recipients: transaction.recipients,
        amount:
            isG1 ? amount / 100 : ((amount / currentUd) / 100).toPrecision(3),
        comment: transaction.comment,
        isG1: isG1,
        currentUd: currentUd,
        isRetry: isRetry);
    if (afterRetry != null) {
      afterRetry!();
    }
  }

  InlineSpan currencyBalanceWidget(
      bool isG1, String currentSymbol, double txFontSize) {
    return TextSpan(children: <InlineSpan>[
      TextSpan(
        text: currentSymbol,
        style: TextStyle(
          fontSize: txFontSize,
          color: grey,
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
                    color: grey,
                  ),
                )))
    ]);
  }

  WidgetSpan separatorSpan() {
    return const WidgetSpan(
      child: SizedBox(width: 3),
    );
  }

  void _showPopupMenu(BuildContext context, Transaction transaction) {
    final RenderBox renderBox =
        _menuKey.currentContext!.findRenderObject()! as RenderBox;
    final Offset position = renderBox.localToGlobal(Offset.zero);
    final double height = renderBox.size.height;

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy + height,
        position.dx,
        position.dy,
      ),
      items: _getMenuItems(context, transaction),
    );
  }

  List<PopupMenuEntry<dynamic>> _getMenuItems(
      BuildContext context, Transaction transaction) {
    final List<PopupMenuEntry<dynamic>> menuItems = <PopupMenuEntry<dynamic>>[];

    if (transaction.isPending) {
      menuItems.add(PopupMenuItem<dynamic>(
        child: ListTile(
          leading: const Icon(Icons.delete),
          title: Text(tr('cancel_payment')),
          onTap: () {
            _cancel(context, transaction);
            Navigator.pop(context);
          },
        ),
      ));
    }

    if (transaction.type == TransactionType.sent) {
      menuItems.add(PopupMenuItem<dynamic>(
        child: ListTile(
          leading: const Icon(Icons.replay),
          title: Text(tr('pay_again')),
          onTap: () {
            _payAgain(context, transaction, false);
            Navigator.pop(context);
          },
        ),
      ));
    }

    if (transaction.type == TransactionType.waitingNetwork) {
      menuItems.add(PopupMenuItem<dynamic>(
        child: ListTile(
          leading: const Icon(Icons.replay),
          title: Text(tr('retry_payment')),
          onTap: () {
            _payAgain(context, transaction, true);
            Navigator.pop(context);
          },
        ),
      ));
    }

    if (transaction.type != TransactionType.pending &&
        !transaction.isToMultiple) {
      menuItems.add(PopupMenuItem<dynamic>(
        child: ListTile(
          leading: const Icon(Icons.contacts),
          title: Text(tr('add_contact')),
          onTap: () {
            _addContact(transaction, context.read<ContactsCubit>(), context);
            Navigator.pop(context);
          },
        ),
      ));
    }

    return menuItems;
  }

  Future<Transaction> _enrichTransaction(Transaction tx) async {
    final Contact fromContact =
        await ContactsCache().getContact(tx.from.pubKey);
    final Contact toContact = await ContactsCache().getContact(tx.to.pubKey);
    final List<Contact> recipients = <Contact>[];
    for (final Contact recipient in tx.recipients) {
      final Contact recipientNew =
          await ContactsCache().getContact(recipient.pubKey);
      recipients.add(recipientNew);
    }
    return transaction.copyWith(
        from: fromContact, to: toContact, recipients: recipients);
  }
}
