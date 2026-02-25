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
import '../../contacts_helper.dart';
import '../../currency_helper.dart';
import '../../in_dev_helper.dart';
import '../../locale_helper.dart';
import '../../logger.dart';
import '../../pay_helper.dart';
import '../../ui_helpers.dart';
import '../avatar_badge.dart';
import '../avatar_dialog.dart';
import '../contact_menu.dart';
import '../contacts_actions.dart';
import 'transaction_item_time.dart';

class TransactionListItem extends StatefulWidget {
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
      this.customPositiveAmountColor = positiveAmountColor,
      this.afterCancel,
      this.afterRetry});

  final GlobalKey _menuKey = GlobalKey(debugLabel: 'txListItem-menu');
  final String pubKey;
  final Transaction transaction;
  final int index;
  final bool isG1;
  final double currentUd;
  final String currentSymbol;
  final bool isCurrencyBefore;
  final bool isExternalAccount;
  final Color customPositiveAmountColor;

  final VoidCallback? afterCancel;
  final VoidCallback? afterRetry;
  static const Color grey = Colors.grey;

  @override
  State<TransactionListItem> createState() => _TransactionListItemState();
}

class _TransactionListItemState extends State<TransactionListItem> {
  late Transaction _displayTransaction;
  bool _isEnriching = false;

  @override
  void initState() {
    super.initState();
    // Enrich immediately synchronously from cache
    _displayTransaction = _enrichTransactionSync(widget.transaction);
    // Enrich in background if necessary
    _enrichTransactionAsync();
  }

  @override
  void didUpdateWidget(TransactionListItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.transaction != widget.transaction) {
      _displayTransaction = _enrichTransactionSync(widget.transaction);
      _enrichTransactionAsync();
    }
  }

  Transaction _enrichTransactionSync(Transaction tx) {
    final ContactsCache cache = ContactsCache();
    final String fromKey = tx.from.pubKey;
    final Contact? fromContact = cache.getCachedContact(fromKey, false, true);

    final List<Contact> recipients = <Contact>[];
    for (final Contact recipient in tx.recipients) {
      final Contact? recipientCached =
          cache.getCachedContact(recipient.pubKey, false, true);
      recipients.add(recipientCached ?? recipient);
    }

    return tx.copyWith(
      from: fromContact ?? tx.from,
      recipients: recipients.isNotEmpty ? recipients : tx.recipients,
    );
  }

  Future<void> _enrichTransactionAsync() async {
    if (_isEnriching) {
      return;
    }
    _isEnriching = true;

    try {
      final ContactsCubit contactsCubit = context.read<ContactsCubit>();
      final String fromKey = widget.transaction.from.pubKey;
      final Contact fromContact = fromKey.isNotEmpty
          ? await retrieveContactFromCubitOrCache(contactsCubit, fromKey)
          : widget.transaction.from;

      final List<Contact> recipients = <Contact>[];
      for (final Contact recipient in widget.transaction.recipients) {
        if (recipient.pubKey.isNotEmpty) {
          final Contact recipientNew = await retrieveContactFromCubitOrCache(
              contactsCubit, recipient.pubKey);
          recipients.add(recipientNew);
        } else {
          recipients.add(recipient);
        }
      }

      if (mounted) {
        setState(() {
          _displayTransaction = widget.transaction.copyWith(
            from: fromContact,
            recipients: recipients,
          );
        });
      }
    } finally {
      _isEnriching = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MultiWalletTransactionCubit,
            MultiWalletTransactionState>(
        builder: (BuildContext context,
                MultiWalletTransactionState transBalanceState) =>
            _buildTransactionItem(
                context: context,
                origTransaction: widget.transaction,
                transaction: _displayTransaction));
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
        isG1: widget.isG1,
        currentUd: widget.currentUd,
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
        iconColor = TransactionListItem.grey;
        break;
      case TransactionType.pending:
        icon = Icons.flight_takeoff;
        iconColor = Colors.grey;
        break;
      case TransactionType.sending:
        icon = Icons.flight_takeoff;
        iconColor = TransactionListItem.grey;
        break;
      case TransactionType.receiving:
        icon = Icons.flight_land;
        iconColor = TransactionListItem.grey;
        break;
      case TransactionType.failed:
        icon = Icons.warning_amber_rounded;
        iconColor = Colors.red;
        break;
      case TransactionType.dividendReceived:
        icon = Icons.water_drop_outlined;
        iconColor = TransactionListItem.grey;
        break;
      case TransactionType.sent:
        break;
      case TransactionType.received:
        break;
    }
    final String myPubKey = SharedPreferencesHelper().getPubKey();

    final ContactsCubit contactsCubit = context.read<ContactsCubit>();
    final Contact to = transaction.recipientsWithoutCashBack.isNotEmpty
        ? transaction.recipientsWithoutCashBack[0]
        : Contact.empty();

    const double txFontSize = 14.0;

    const FontWeight fromToWeight = FontWeight.w400;
    const FontStyle fromToStyle = FontStyle.normal;
    final Color fromToColor = Theme.of(context).hintColor;
    final Color linkColor = Theme.of(context).colorScheme.primary;

    final TextStyle linkTextStyle = TextStyle(
      fontSize: txFontSize,
      color: linkColor,
      decoration: TextDecoration.underline,
      decorationStyle: TextDecorationStyle.dotted,
      decorationThickness: 1,
      decorationColor: linkColor,
    );

    final bool isDividend =
        transaction.type == TransactionType.dividendReceived;

    final Widget gestureDetectorWidget = GestureDetector(
        onLongPress: () {
          _showPopupMenu(
              context: context,
              origTransaction: origTransaction,
              transaction: transaction);
        },
        // https://stackoverflow.com/questions/75577429/flutter-why-is-my-listtile-color-being-overwritten-by-the-container-color
        child: Material(
            elevation: 3.0,
            child: ListTile(
              leading: (icon != null &&
                      transaction.type != TransactionType.dividendReceived)
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(10, 16, 0, 16),
                      child: Icon(
                        icon,
                        color: iconColor,
                      ))
                  : null,
              // Disable the tile color
              // tileColor: tileColor(widget.index, context),
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
                            color: TransactionListItem.grey,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        if (transaction.type ==
                            TransactionType.dividendReceived)
                          Row(
                            children: <Widget>[
                              Text(
                                tr('transaction_dividendReceived_desc'),
                                style: TextStyle(
                                  fontSize: txFontSize, color: fromToColor,
                                  // color: TransactionListItem.grey,
                                  //   fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 3.0),
                              const Padding(
                                  padding: EdgeInsetsGeometry.only(bottom: 2),
                                  child: Icon(
                                    Icons.water_drop,
                                    // Symbols.water_do,
                                    color: TransactionListItem.grey,
                                    size: 16.0,
                                  )),
                            ],
                          )
                        else
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
                                    alignment: PlaceholderAlignment.middle,
                                    child: ConstrainedBox(
                                      constraints:
                                          const BoxConstraints(maxWidth: 200),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        spacing: 4,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Flexible(
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
                                                style: linkTextStyle,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                          AvatarBadge(
                                            contact: transaction.from,
                                            radius: 12,
                                            onTap: transaction.from.hasAvatar
                                                ? () {
                                                    logger(
                                                        '[TransactionItem] FROM avatar tapped');
                                                    showAvatarDialog(
                                                        context,
                                                        transaction
                                                            .from.avatar!);
                                                  }
                                                : null,
                                          ),
                                        ],
                                      ),
                                    )),
                                tinyLineSeparator(),
                                TextSpan(
                                  text: tr('transaction_to').toLowerCase(),
                                  style: TextStyle(
                                    fontSize: txFontSize,
                                    fontWeight: fromToWeight,
                                    fontStyle: fromToStyle,
                                    color: fromToColor,
                                  ),
                                ),
                                tinyLineSeparator(),
                                tinyLineSeparator(),
                                WidgetSpan(
                                    alignment: PlaceholderAlignment.middle,
                                    child: ConstrainedBox(
                                      constraints:
                                          const BoxConstraints(maxWidth: 200),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        spacing: 4,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Flexible(
                                            child: ContactMenu(
                                              contact: to,
                                              onEdit: () =>
                                                  onEditContact(context, to),
                                              onSent: () =>
                                                  onSentContact(context, to),
                                              onCopy: () =>
                                                  onShowContactQr(context, to),
                                              onDelete: () {
                                                return onDeleteContact(
                                                    context, to);
                                              },
                                              disable: transaction.isToMultiple,
                                              parent: Text(
                                                humanizeContacts(
                                                    publicAddress: myPubKey,
                                                    contacts: transaction
                                                        .recipientsWithoutCashBack),
                                                style: linkTextStyle,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                          AvatarBadge(
                                            contact: to,
                                            radius: 12,
                                            onTap: to.hasAvatar
                                                ? () {
                                                    logger(
                                                        '[TransactionItem] TO avatar tapped');
                                                    showAvatarDialog(
                                                        context, to.avatar!);
                                                  }
                                                : null,
                                          ),
                                        ],
                                      ),
                                    )),
                                const WidgetSpan(
                                  alignment: PlaceholderAlignment.top,
                                  child: SizedBox(width: 2.0),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              subtitle: transaction.comment == '' ||
                      transaction.type == TransactionType.dividendReceived
                  ? null
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(8, 6, 0, 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Icon(Icons.mode_comment_outlined,
                              size: 18, color: TransactionListItem.grey),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              inDevelopment
                                  ? '${transaction.comment}$debugText'
                                  : transaction.comment,
                              style: const TextStyle(
                                color: TransactionListItem.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text.rich(TextSpan(
                    children: <InlineSpan>[
                      if (widget.isCurrencyBefore)
                        currencyBalanceWidget(
                            widget.isG1, widget.currentSymbol, txFontSize),
                      if (widget.isCurrencyBefore) separatorSpan(),
                      TextSpan(
                        text: amountS,
                        style: TextStyle(
                          // fontWeight: FontWeight.bold,
                          fontSize: txFontSize,
                          color: transaction.type == TransactionType.received ||
                                  transaction.type ==
                                      TransactionType.receiving ||
                                  transaction.type ==
                                      TransactionType.dividendReceived
                              ? widget.customPositiveAmountColor
                              : negativeAmountColor,
                        ),
                      ),
                      if (!widget.isCurrencyBefore) separatorSpan(),
                      if (!widget.isCurrencyBefore)
                        currencyBalanceWidget(
                            widget.isG1, widget.currentSymbol, txFontSize)
                    ],
                  )),
                  const SizedBox(height: 4.0),
                  TransactionItemTime(
                    transactionTime: transaction.time,
                    locale: currentLocale(context),
                  ),
                ],
              ),
            )));

    // If it's a dividend, return the widget directly without Slidable
    if (isDividend) {
      return gestureDetectorWidget;
    }

    // For other transaction types, wrap with Slidable
    return Slidable(
      key: ValueKey<int>(widget.index),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: <SlidableAction>[
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
          if (transaction.type == TransactionType.sent &&
              !widget.isExternalAccount)
            SlidableAction(
              onPressed: (BuildContext c) async {
                _selectUserToPay(context, transaction);
              },
              backgroundColor: Theme.of(context).primaryColorDark,
              foregroundColor: Colors.white,
              icon: Icons.replay,
              label: tr('pay_again'),
            ),
        ],
      ),
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
      child: gestureDetectorWidget,
    );
  }

  WidgetSpan lineSeparator() {
    return const WidgetSpan(
      alignment: PlaceholderAlignment.top,
      child: SizedBox(width: 5.0),
    );
  }

  WidgetSpan tinyLineSeparator() {
    return const WidgetSpan(
      alignment: PlaceholderAlignment.top,
      child: SizedBox(width: 2.0),
    );
  }

  void _addContact(Transaction transaction, ContactsCubit contactsCubit,
      BuildContext context) {
    final Contact newContact = transaction.isIncoming
        ? transaction.from
        : transaction.recipientsWithoutCashBack[0];
    addContact(context, newContact);
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
    if (widget.afterCancel != null) {
      widget.afterCancel!();
    }
  }

  Future<void> _payAgain(
      BuildContext context, Transaction transaction, bool isRetry) async {
    final double amount = transaction.amount.abs() / // positive
        transaction.recipientsWithoutCashBack.length;
    await payWithRetry(
        context: context,
        recipients: transaction.recipientsWithoutCashBack,
        amount: widget.isG1
            ? amount / 100
            : ((amount / widget.currentUd) / 100).toPrecision(3),
        comment: transaction.comment,
        isG1: widget.isG1,
        currentUd: widget.currentUd,
        isRetry: isRetry);
    if (widget.afterRetry != null) {
      widget.afterRetry!();
    }
  }

  InlineSpan currencyBalanceWidget(
      bool isG1, String currentSymbol, double txFontSize) {
    return TextSpan(children: <InlineSpan>[
      TextSpan(
        text: currentSymbol,
        style: TextStyle(
          fontSize: txFontSize,
          color: TransactionListItem.grey,
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
                    color: TransactionListItem.grey,
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
        widget._menuKey.currentContext!.findRenderObject()! as RenderBox;
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

    if (transaction.type != TransactionType.dividendReceived) {
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
}
