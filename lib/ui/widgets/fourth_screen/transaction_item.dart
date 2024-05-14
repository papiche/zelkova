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
import '../contact_menu.dart';
import '../contacts_actions.dart';

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
      required this.isExternalAccount,
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
  final bool isExternalAccount;

  final VoidCallback? afterCancel;
  final VoidCallback? afterRetry;
  static const Color grey = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Transaction>(
      future: _enrichTransaction(context, transaction),
      builder: (BuildContext context, AsyncSnapshot<Transaction> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildTransactionItem(
              context: context,
              origTransaction: transaction,
              transaction: transaction);
        } else if (snapshot.hasError) {
          return _buildTransactionItem(
              context: context,
              origTransaction: transaction,
              transaction: transaction);
        } else {
          final Transaction enrichedTx = snapshot.data!;
          return BlocBuilder<MultiWalletTransactionCubit,
                  MultiWalletTransactionState>(
              builder: (BuildContext context,
                      MultiWalletTransactionState transBalanceState) =>
                  _buildTransactionItem(
                      context: context,
                      origTransaction: transaction,
                      transaction: enrichedTx));
        }
      },
    );
  }

  Widget _buildTransactionItem(
      {required BuildContext context,
      required Transaction origTransaction,
      required Transaction transaction}) {
    IconData? icon;
    Color? iconColor;
    String statusText;

    String debugText;
    transaction.debugInfo == null
        ? debugText = ''
        : debugText = ' [DEBUG ${transaction.debugInfo!}]';
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

    // Swap the text of pending by sending
    statusText = transaction.type == TransactionType.pending
        ? tr('transaction_sending')
        : statusText;

    switch (transaction.type) {
      case TransactionType.waitingNetwork:
        icon = Icons.schedule_send;
        iconColor = grey;
        break;
      case TransactionType.pending:
        icon = Icons.flight_takeoff;
        iconColor = Colors.grey;
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
    final Contact to = transaction.recipientsWithoutCashBack[0];

    const double txFontSize = 14.0;

    const FontWeight fromToWeight = FontWeight.w400;
    const FontStyle fromToStyle = FontStyle.normal;
    final Color fromToColor = Theme.of(context).hintColor;
    final Color linkColor = Theme.of(context).colorScheme.primary;

    return Slidable(
        // Specify a key if the Slidable is dismissible.

        key: ValueKey<int>(index),
        // The end action pane is the one at the right or the bottom side.
        startActionPane:
            ActionPane(motion: const ScrollMotion(), children: <SlidableAction>[
          if (transaction.isPending)
            SlidableAction(
              onPressed: (BuildContext c) {
                _cancel(context, origTransaction);
              },
              backgroundColor: deleteColor,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: tr('cancel_payment'),
            ),
          if (transaction.type == TransactionType.sent && !isExternalAccount)
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
              _showPopupMenu(
                  context: context,
                  origTransaction: origTransaction,
                  transaction: transaction);
            },
            // https://stackoverflow.com/questions/75577429/flutter-why-is-my-listtile-color-being-overwritten-by-the-container-color
            child: Material(
                elevation: 3.0,
                child: ListTile(
                  leading: (icon != null)
                      ? Padding(
                          padding: const EdgeInsets.fromLTRB(10, 16, 0, 16),
                          child: Icon(
                            icon,
                            color: iconColor,
                          ))
                      : null,
                  // tileColor: tileColor(index, context),
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
                              softWrap: true,
                              TextSpan(
                                children: <InlineSpan>[
                                  TextSpan(
                                    text: tr('transaction_from'),
                                    style: TextStyle(
                                      fontSize: txFontSize,
                                      fontWeight: fromToWeight,
                                      fontStyle: fromToStyle,
                                      color: fromToColor,
                                    ),
                                  ),
                                  lineSeparator(),
                                  WidgetSpan(
                                      alignment: PlaceholderAlignment.top,
                                      child: ContactMenu(
                                        contact: transaction.from,
                                        onEdit: () => onEditContact(
                                            context, transaction.from),
                                        onSent: () => onSentContact(
                                            context, transaction.from),
                                        onCopy: () => onShowContactQr(
                                            context, transaction.from),
                                        onDelete: () => onDeleteContact(
                                            context, transaction.from),
                                        parent: Text(
                                          humanizeContact(
                                              myPubKey, transaction.from),
                                          style: TextStyle(
                                              fontSize: txFontSize,
                                              color: linkColor
                                              // fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      )),
                                  lineSeparator(),
                                  TextSpan(
                                    text: tr('transaction_to').toLowerCase(),
                                    style: TextStyle(
                                      fontSize: txFontSize,
                                      fontWeight: fromToWeight,
                                      fontStyle: fromToStyle,
                                      color: fromToColor,
                                    ),
                                  ),
                                  lineSeparator(),
                                  WidgetSpan(
                                      alignment: PlaceholderAlignment.top,
                                      child: ContactMenu(
                                        contact: to,
                                        onEdit: () =>
                                            onEditContact(context, to),
                                        onSent: () =>
                                            onSentContact(context, to),
                                        onCopy: () =>
                                            onShowContactQr(context, to),
                                        onDelete: () {
                                          return onDeleteContact(context, to);
                                        },
                                        disable: transaction.isToMultiple,
                                        parent: Text(
                                          humanizeContacts(
                                              publicAddress: myPubKey,
                                              contacts: transaction
                                                  .recipientsWithoutCashBack),
                                          style: TextStyle(
                                              fontSize: txFontSize,
                                              color: linkColor),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  subtitle: transaction.comment == ''
                      ? null
                      : Padding(
                          padding: const EdgeInsets.fromLTRB(8, 6, 0, 5),
                          child: Text(
                              inDevelopment
                                  ? '${transaction.comment}$debugText'
                                  : transaction.comment,
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
                            currencyBalanceWidget(
                                isG1, currentSymbol, txFontSize),
                          if (isCurrencyBefore) separatorSpan(),
                          TextSpan(
                            text: amountS,
                            style: TextStyle(
                              // fontWeight: FontWeight.bold,
                              fontSize: txFontSize,
                              color: transaction.type ==
                                          TransactionType.received ||
                                      transaction.type ==
                                          TransactionType.receiving
                                  ? positiveAmountColor
                                  : negativeAmountColor,
                            ),
                          ),
                          if (!isCurrencyBefore) separatorSpan(),
                          if (!isCurrencyBefore)
                            currencyBalanceWidget(
                                isG1, currentSymbol, txFontSize)
                        ],
                      )),
                      const SizedBox(height: 4.0),
                      Tooltip(
                          message: DateFormat.yMd(currentLocale(context))
                              .add_Hm()
                              .format(transaction.time),
                          child: Text(
                            humanizeTime(
                                transaction.time, currentLocale(context))!,
                            style: const TextStyle(
                              fontSize: 12.0,
                              color: grey,
                            ),
                          )),
                    ],
                  ),
                ))));
  }

  WidgetSpan lineSeparator() {
    return const WidgetSpan(
      alignment: PlaceholderAlignment.top,
      child: SizedBox(width: 5.0),
    );
  }

  void _addContact(Transaction transaction, ContactsCubit contactsCubit,
      BuildContext context) {
    final Contact newContact = transaction.isIncoming
        ? transaction.from
        : transaction.recipientsWithoutCashBack[0];
    addContact(contactsCubit, newContact, context);
  }

  void _selectUserToPay(BuildContext context, Transaction transaction) {
    context.read<PaymentCubit>().selectUsers(
          transaction.recipientsWithoutCashBack,
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
    final double amount = transaction.amount.abs() / // positive
        transaction.recipientsWithoutCashBack.length;
    await payWithRetry(
        context: context,
        recipients: transaction.recipientsWithoutCashBack,
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
      alignment: PlaceholderAlignment.top,
      child: SizedBox(width: 3),
    );
  }

  void _showPopupMenu(
      {required BuildContext context,
      required Transaction origTransaction,
      required Transaction transaction}) {
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
      items: _getMenuItems(
          context: context,
          origTransaction: origTransaction,
          transaction: transaction),
    );
  }

  List<PopupMenuEntry<dynamic>> _getMenuItems(
      {required BuildContext context,
      required Transaction origTransaction,
      required Transaction transaction}) {
    final List<PopupMenuEntry<dynamic>> menuItems = <PopupMenuEntry<dynamic>>[];

    if (transaction.isPending) {
      menuItems.add(PopupMenuItem<dynamic>(
        child: ListTile(
          leading: const Icon(Icons.delete),
          title: Text(tr('cancel_payment')),
          onTap: () {
            _cancel(context, origTransaction);
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

    return menuItems;
  }

  Future<Transaction> _enrichTransaction(
      BuildContext context, Transaction tx) async {
    final ContactsCubit contactsCubit = context.read<ContactsCubit>();
    final String fromKey = tx.from.pubKey;
    final Contact fromContact = await retrieveContact(contactsCubit, fromKey);
    final Contact toContact =
        // ignore: deprecated_member_use_from_same_package
        await retrieveContact(contactsCubit, tx.to.pubKey);
    final List<Contact> recipients = <Contact>[];
    for (final Contact recipient in tx.recipients) {
      final Contact recipientNew =
          await retrieveContact(contactsCubit, recipient.pubKey);
      recipients.add(recipientNew);
    }
    return transaction.copyWith(
        from: fromContact, to: toContact, recipients: recipients);
  }

  Future<Contact> retrieveContact(
      ContactsCubit contactsCubit, String pubKey) async {
    final Contact? cubitContact = contactsCubit.getContact(pubKey);
    return cubitContact ?? await ContactsCache().getContact(pubKey);
  }
}
