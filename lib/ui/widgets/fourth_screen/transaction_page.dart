import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/node_list_cubit.dart';
import '../../../data/models/node_list_state.dart';
import '../../../g1/api.dart';
import '../../../g1/transaction.dart';
import '../../../g1/transaction_parser.dart';
import '../../../shared_prefs.dart';
import '../../ui_helpers.dart';
import '../header.dart';
import '../loading_box.dart';

class TransactionsAndBalanceWidget extends StatefulWidget {
  const TransactionsAndBalanceWidget({super.key});

  @override
  State<TransactionsAndBalanceWidget> createState() =>
      _TransactionsAndBalanceWidgetState();
}

class _TransactionsAndBalanceWidgetState
    extends State<TransactionsAndBalanceWidget>
    with SingleTickerProviderStateMixin {
  late ScrollController _transactionListController;

  /* late double _balanceAmount;
  List<Transaction> _transactions = <Transaction>[];
  bool _isLoading = true; */

  @override
  void initState() {
    super.initState();
    _transactionListController = ScrollController();
  }

  @override
  void dispose() {
    _transactionListController.dispose();
    super.dispose();
  }

  Future<TransactionsAndBalance> _loadTransactions(NodeListCubit cubit) async {
    // carga de datos asíncrona
    // ...
    // disabled, as we have to change the nodes
    // https://g1.asycn.io/gva
    // https://duniter.pini.fr/gva
    /* Gva(node: 'https://g1.asycn.io/gva')
        .balance(SharedPreferencesHelper().getPubKey())
        .then((double currentBal) => setState(() {
              _balanceAmount = currentBal;
            })); */

    final String txData = await getTxHistory(
        cubit, '6DrGg8cftpkgffv4Y4Lse9HSjgc8coEQor3yvMPHAnVH');
    final TransactionsAndBalance result = transactionParser(txData);
    /*  .then((String txData) {
    final TransactionsAndBalance result = transactionParser(txData);
    setState(() {
      _balanceAmount = result.balance / 100;
      _transactions = result.transactions;
      _isLoading = false;
    });
  });  */
    return result;
  }

  @override
  Widget build(BuildContext context) {
    String pubKey = SharedPreferencesHelper().getPubKey();
    pubKey = '6DrGg8cftpkgffv4Y4Lse9HSjgc8coEQor3yvMPHAnVH';
    return BlocBuilder<NodeListCubit, NodeListState>(
        builder: (BuildContext context, NodeListState state) => FutureBuilder<
                TransactionsAndBalance>(
            future: _loadTransactions(context.read<NodeListCubit>()),
            builder: (BuildContext context,
                AsyncSnapshot<TransactionsAndBalance> results) {
              if (results.hasData) {
                return Stack(children: <Widget>[
                  const Header(text: 'transactions'),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    controller: _transactionListController,
                    itemCount: results.data!.transactions.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(tr('transaction_from_to',
                            namedArgs: <String, String>{
                              'from': humanizeFromToPubKey(pubKey,
                                  results.data!.transactions[index].from),
                              'to': humanizeFromToPubKey(
                                  pubKey, results.data!.transactions[index].to)
                            })),
                        subtitle:
                            results.data!.transactions[index].comment.isNotEmpty
                                ? Text(
                                    results.data!.transactions[index].comment,
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                    ),
                                  )
                                : null,
                        tileColor:
                            index.isEven ? Colors.grey[200] : Colors.white,
                        trailing: Text(
                            '${results.data!.transactions[index].amount < 0 ? "" : "+"}${(results.data!.transactions[index].amount / 100).toStringAsFixed(2)} Ğ1',
                            style: TextStyle(
                                color:
                                    results.data!.transactions[index].amount < 0
                                        ? Colors.red
                                        : Colors.blue)),
                      );
                    },
                  ),
                  DraggableScrollableSheet(
                      initialChildSize: 0.1,
                      minChildSize: 0.1,
                      maxChildSize: 0.9,
                      builder: (BuildContext context,
                              ScrollController scrollController) =>
                          Container(
                            decoration: BoxDecoration(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                              border: Border.all(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
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
                                const Header(text: 'balance'),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20.0),
                                  child: Center(
                                      child: Text(
                                    '${(results.data!.balance / 100).toStringAsFixed(2)} Ğ1',
                                    style: const TextStyle(
                                        fontSize: 36.0,
                                        fontWeight: FontWeight.bold),
                                  )),
                                ),
                                /*
                          Expanded(
                              child: BalanceChart(transactions: _transactions)),
                          */
                              ],
                            )),
                          ))
                ]);
              } else if (results.hasError) {
                // FIXME
                return const Text('Error al cargar los datos.');
              } else {
                return const LoadingBox();
              }
            }));
  }
}
