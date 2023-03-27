import 'package:backdrop/backdrop.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/node_list_cubit.dart';
import '../../../data/models/transaction.dart';
import '../../../data/models/transaction_cubit.dart';
import '../../../shared_prefs.dart';
import '../../ui_helpers.dart';
import 'transaction_chart.dart';
import 'transaction_item.dart';

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
// Remove in the future
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
    if (_transScrollController.offset == 0) {
      _refreshIndicatorKey.currentState?.show();
    }
  }

  Future<void> _refreshTransactions() async {
    return transCubit.fetchTransactions(nodeListCubit);
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    final String myPubKey = SharedPreferencesHelper().getPubKey();
    return BlocBuilder<TransactionsCubit, TransactionsAndBalanceState>(builder:
        (BuildContext context, TransactionsAndBalanceState transBalanceState) {
      final List<Transaction> transactions = transBalanceState.transactions;
      final double balance = transBalanceState.balance;
      return BackdropScaffold(
          appBar: BackdropAppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(tr('balance')),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  _refreshIndicatorKey.currentState?.show();
                  // _refreshTransactions();
                },
              ),
              const BackdropToggleButton()
              /* IconButton(
                icon: const Icon(Icons.savings),
                onPressed: () => Backdrop.of(context).animationController,
              ) */
            ],
          ),
          backLayer: Center(
              child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.inversePrimary,
              border: Border.all(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  width: 3),
              /* borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ), */
            ),
            child: Scrollbar(
                child: ListView(
              //   controller: scrollController,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Center(
                      child: Text(
                    formatKAmount(context, balance),
                    style: TextStyle(
                        fontSize: 36.0,
                        color:
                            balance == 0 ? Colors.lightBlue : Colors.lightBlue,
                        fontWeight: FontWeight.bold),
                  )),
                ),
                if (!kReleaseMode) TransactionChart()
                /*BalanceChart(
                                    transactions: .transactions),*/
              ],
            )),
          )),
          subHeader: BackdropSubHeader(
            title: Text(tr('transactions')),
            divider: Divider(
              color: Theme.of(context).colorScheme.surfaceVariant,
              height: 0,
            ),
          ),
          frontLayer: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  /* Container(
                      /* color: Theme
                      .of(context)
                      .colorScheme
                      .surfaceVariant, */
                      height: 70,
                      width: double.infinity,
                      child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Header(text: 'transactions'))), */
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
                    child: transactions.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Center(child: Text(tr('no_transactions'))))
                        : RefreshIndicator(
                            key: _refreshIndicatorKey,
                            color: Colors.white,
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            strokeWidth: 4.0,
                            onRefresh: () async {
                              return _refreshTransactions();
                            },
                            // Pull from top to show refresh indicator.
                            child: ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              shrinkWrap: true,
                              controller: _transScrollController,
                              itemCount: transactions.length,
                              // Size of elements
                              // itemExtent: 100,
                              itemBuilder: (BuildContext context, int index) {
                                return TransactionListItem(
                                  pubKey: myPubKey,
                                  index: index,
                                  transaction: transactions[index],
                                );
                                /*
                                   Slidable(

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
                                                  content:
                                                      Text(tr('contact_added')),
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
                                                  myPubKey,
                                                  transactions[index].from),
                                              'to': humanizeFromToPubKey(
                                                  myPubKey,
                                                  transactions[index].to)
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
                                        tileColor: tileColor(index, context),
                                        trailing: Text(
                                            '${transactions[index].amount < 0 ? "" : "+"}${(transactions[index].amount / 100).toStringAsFixed(2)} Ğ1',
                                            style: TextStyle(
                                                color:
                                                    transactions[index].amount <
                                                            0
                                                        ? Colors.red
                                                        : Colors.blue)),
                                      ));
                                      */
                              },
                            )),
                  ))
                ]),
          ));
    });
  }
}
