import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../data/models/contact.dart';
import '../../../data/models/contact_cubit.dart';
import '../../../data/models/node_list_cubit.dart';
import '../../../data/models/transaction.dart';
import '../../../data/models/transaction_cubit.dart';
import '../../../shared_prefs.dart';
import '../../ui_helpers.dart';
import '../header.dart';
import '../loading_box.dart';
import '../third_screen/contacts_page.dart';
import 'transaction_chart.dart';

class TransactionsAndBalanceWidget extends StatefulWidget {
  const TransactionsAndBalanceWidget({super.key});

  @override
  State<TransactionsAndBalanceWidget> createState() =>
      _TransactionsAndBalanceWidgetState();
}

class _TransactionsAndBalanceWidgetState
    extends State<TransactionsAndBalanceWidget>
    with SingleTickerProviderStateMixin {
  final ScrollController _transScrollController = ScrollController();
  late NodeListCubit nodeListCubit;
  late TransactionsCubit transCubit;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _transScrollController.addListener(_scrollListener);
    transCubit = context.read<TransactionsCubit>();
    nodeListCubit = context.read<NodeListCubit>();
    transCubit.fetchTransactions(nodeListCubit);
  }

  @override
  void dispose() {
    _transScrollController.removeListener(_scrollListener);
    _transScrollController.dispose();
    super.dispose();
  }

  Future<void> _scrollListener() async {
    if (_transScrollController.position.pixels ==
            _transScrollController.position.maxScrollExtent ||
        _transScrollController.offset == 0) {
      setState(() {
        isLoading = true;
      });
      await transCubit.fetchTransactions(nodeListCubit);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final String myPubKey = !txDebugging
        ? SharedPreferencesHelper().getPubKey()
        : '6DrGg8cftpkgffv4Y4Lse9HSjgc8coEQor3yvMPHAnVH';
    return BlocBuilder<TransactionsCubit, TransactionsAndBalanceState>(builder:
        (BuildContext context, TransactionsAndBalanceState transBalanceState) {
      // Fetch transactions
      // TODO(vjrj): Only fetch last transactions and used persisted ones
      final ContactsCubit contactsCubit = context.read<ContactsCubit>();
      final List<Transaction> transactions = transBalanceState.transactions;
      final int balance = transBalanceState.balance;
      if (!isLoading) {
        return Stack(children: <Widget>[
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
              Widget>[
            Container(
                color: Theme.of(context).colorScheme.surfaceVariant,
                height: 90,
                width: double.infinity,
                child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Header(text: 'transactions'))),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
                  child: transactions.isEmpty
                      ? Column(children: const <Widget>[
                          NoElements(text: 'no_transactions')
                        ])
                      : ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          controller: _transScrollController,
                          itemCount: transactions.length,
                          // Size of elements
                          // itemExtent: 100,
                          itemBuilder: (BuildContext context, int index) {
                            return Slidable(
                                // Specify a key if the Slidable is dismissible.
                                key: const ValueKey<int>(0),
                                // The end action pane is the one at the right or the bottom side.
                                endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: <SlidableAction>[
                                    SlidableAction(
                                      onPressed: (BuildContext c) {
                                        _addContact(transactions, index,
                                            myPubKey, contactsCubit);
                                        // FIXME i18n
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(tr('contact_added')),
                                          ),
                                        );
                                      },
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      foregroundColor: Colors.white,
                                      icon: Icons.contacts,
                                      label: tr('add_contact'),
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                  title: Text(tr('transaction_from_to',
                                      namedArgs: <String, String>{
                                        'from': humanizeFromToPubKey(
                                            myPubKey, transactions[index].from),
                                        'to': humanizeFromToPubKey(
                                            myPubKey, transactions[index].to)
                                      })),
                                  subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        if (transactions[index]
                                            .comment
                                            .isNotEmpty)
                                          Text(
                                            transactions[index].comment,
                                            style: const TextStyle(
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                        Text(humanizeTime(
                                            transactions[index].time,
                                            context.locale.toString())!)
                                      ]),
                                  tileColor: tileColor(index),
                                  trailing: Text(
                                      '${transactions[index].amount < 0 ? "" : "+"}${(transactions[index].amount / 100).toStringAsFixed(2)} Ğ1',
                                      style: TextStyle(
                                          color: transactions[index].amount < 0
                                              ? Colors.red
                                              : Colors.blue)),
                                ));
                          },
                        )),
            )
          ]),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: DraggableScrollableSheet(
                  initialChildSize: 0.12,
                  minChildSize: 0.12,
                  maxChildSize: 0.9,
                  builder: (BuildContext context,
                          ScrollController scrollController) =>
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          border: Border.all(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                              width: 3),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                        ),
                        child: Scrollbar(
                            child: ListView(
                          controller: scrollController,
                          children: <Widget>[
                            const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Header(
                                  text: 'balance',
                                  // topPadding: 0,
                                )),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Center(
                                  child: Text(
                                '${(balance / 100).toStringAsFixed(2)} Ğ1',
                                style: TextStyle(
                                    fontSize: 36.0,
                                    color: balance == 0
                                        ? Colors.lightBlue
                                        : Colors.lightBlue,
                                    fontWeight: FontWeight.bold),
                              )),
                            ),
                            if (!kReleaseMode) TransactionChart()
                            /*BalanceChart(
                                    transactions: .transactions),*/
                          ],
                        )),
                      )))
        ]);
      } else {
        return const LoadingScreen();
      }
    });
  }

  void _addContact(List<Transaction> transactions, int index, String myPubKey,
      ContactsCubit contactsCubit) {
    final Transaction tx = transactions[index];
    final String fromPubKey = tx.from;
    final String toPubKey = tx.to;
    final bool useFrom = fromPubKey != myPubKey;
    contactsCubit.addContact(Contact(
        pubkey: useFrom ? fromPubKey : toPubKey,
        nick: useFrom ? tx.fromNick : tx.toNick,
        avatar: useFrom ? tx.fromAvatar : tx.toAvatar));
  }
}
