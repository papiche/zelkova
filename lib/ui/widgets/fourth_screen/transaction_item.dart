import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../data/models/contact.dart';
import '../../../data/models/contact_cubit.dart';
import '../../../data/models/transaction.dart';
import '../../../data/models/transaction_balance_state.dart';
import '../../../data/models/transaction_cubit.dart';
import '../../../data/models/transaction_type.dart';
import '../../../shared_prefs.dart';
import '../../contacts_cache.dart';
import '../../ui_helpers.dart';

class TransactionListItem extends StatelessWidget {
  const TransactionListItem({
    super.key,
    required this.pubKey,
    required this.transaction,
    required this.index,
  });

  final String pubKey;
  final Transaction transaction;
  final int index;

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<TransactionsCubit, TransactionsAndBalanceState>(
          builder: (BuildContext context,
                  TransactionsAndBalanceState transBalanceState) =>
              FutureBuilder<List<Contact>>(
                  future: _fetchContact(pubKey, transaction),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Contact>> snapshot) {
                    if (snapshot.hasData) {
                      return _buildTransactionItem(context, snapshot.data!);
                    } else if (snapshot.hasError) {
                      return Text('Error ${snapshot.error}');
                    } else {
                      return _buildTransactionItem(context, <Contact>[
                        Contact(pubKey: transaction.from),
                        Contact(pubKey: transaction.to)
                      ]);
                    }
                  }));

  Slidable _buildTransactionItem(BuildContext context, List<Contact> contacts) {
    IconData? icon;
    Color? iconColor;
    String statusText;
    final String amountS =
        '${transaction.amount < 0 ? "" : "+"}${formatKAmount(context, transaction.amount)}';
    statusText = tr('transaction_${transaction.type.name}');
    switch (transaction.type) {
      case TransactionType.pending:
        icon = Icons.timelapse;
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
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: <SlidableAction>[
            SlidableAction(
              onPressed: (BuildContext c) {
                contactsCubit.addContact(
                    transaction.isIncoming ? contacts[0] : contacts[1]);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(tr('contact_added')),
                  ),
                );
              },
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              icon: Icons.contacts,
              label: tr('add_contact'),
            ),
          ],
        ),
        child: ListTile(
          leading: (icon != null)
              ? Icon(
                  icon,
                  color: iconColor,
                )
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
                          /* TextSpan(
                  text: isIncoming(transaction.type)
                      ? 'Recibido de '
                      : 'Pago a ',
                  style: const TextStyle(
                    fontSize: 14.0,
                    // fontWeight: FontWeight.bold,
                  ),
                ), */
                          /* WidgetSpan(
                  child: avatar != null
                      ? const SizedBox(width: 8.0)
                      : const SizedBox.shrink(),
                ), */
                          WidgetSpan(
                            child: Text(
                              tr('transaction_from_to',
                                  namedArgs: <String, String>{
                                    'from':
                                        humanizeContact(myPubKey, contacts[0]),
                                    'to': humanizeContact(myPubKey, contacts[1])
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
              Text(
                amountS,
                style: TextStyle(
                  // fontWeight: FontWeight.bold,
                  color: transaction.type == TransactionType.received ||
                          transaction.type == TransactionType.receiving
                      ? Colors.blue
                      : Colors.red,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                humanizeTime(transaction.time, context.locale.toString())!,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ));
  }

  Future<List<Contact>> _fetchContact(
      String pubKey, Transaction transaction) async {
    final Contact myContact = await ContactsCache().getContact(pubKey);
    if (pubKey == transaction.from) {
      final Contact to = await ContactsCache().getContact(transaction.to);
      return <Contact>[myContact, to];
    } else {
      final Contact from = await ContactsCache().getContact(transaction.from);
      return <Contact>[from, myContact];
    }
  }
}
