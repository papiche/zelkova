import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

import '../../../data/models/contact.dart';
import '../../../data/models/node.dart';
import '../../../data/models/transaction.dart';
import '../../../data/models/transaction_state.dart';
import '../../../g1/api.dart';
import '../../ui_helpers.dart';
import '../connectivity_widget_wrapper_wrapper.dart';
import '../fourth_screen/transaction_item.dart';

class SimpleTransactionsPanel extends StatefulWidget {
  const SimpleTransactionsPanel({
    super.key,
    required this.from,
    required this.to,
    required this.contact,
    required this.pageSize,
    required this.initiallyExpanded,
    required this.onResult,
    required this.currentUd,
    required this.isG1,
    required this.isCurrencyBefore,
    required this.currentSymbol,
    required this.collectOtherContacts,
  });

  final int from;
  final int to;
  final Contact contact;
  final int pageSize;
  final bool initiallyExpanded;
  final Function(double, double, int, int, Set<Contact>, String) onResult;
  final double currentUd;
  final bool isG1;
  final bool isCurrencyBefore;
  final String currentSymbol;
  final bool collectOtherContacts;

  @override
  State<SimpleTransactionsPanel> createState() =>
      _SimpleTransactionsPanelState();
}

class _SimpleTransactionsPanelState extends State<SimpleTransactionsPanel> {
  List<Transaction> transactions = <Transaction>[];
  bool hasMore = true;
  Set<Contact> otherContacts = <Contact>{};

  double totalReceived = 0.0;

  double totalSent = 0.0;
  int totalReceivedNumber = 0;
  int totalSentNumber = 0;

  @override
  void initState() {
    super.initState();
    _fetchTransactions();
  }

  Future<void> _fetchTransactions() async {
    final bool isConnected = await ConnectivityWidgetWrapperWrapper.isConnected;
    final Tuple2<Map<String, dynamic>?, Node> txDataResult =
        await getHistoryAndBalance(widget.contact.pubKey,
            pageSize: widget.pageSize,
            from: widget.from,
            to: widget.to,
            isConnected: isConnected);

    if (txDataResult.item1 == null) {
      return;
    }

    final Map<String, dynamic> txData = txDataResult.item1!;
    final TransactionState newParsedState = await transactionsParser(
      txData,
      TransactionState.emptyState,
      widget.contact.pubKey,
    );
    final List<Transaction> txs = newParsedState.transactions;

    setState(() {
      transactions.addAll(txs);
      if (txs.length < widget.pageSize) {
        hasMore = false;
      }
      _collectAndReturnResults();
    });
  }

  void _collectAndReturnResults() {
    final Iterable<Transaction> totalReceivedTxs =
        transactions.where((Transaction tx) => tx.amount > 0);
    totalReceived = totalReceivedTxs.fold(
        0.0, (double prev, Transaction tx) => prev + tx.amount);
    final Iterable<Transaction> totalSentTxs =
        transactions.where((Transaction tx) => tx.amount < 0);
    totalSent = totalSentTxs.fold(
        0.0, (double prev, Transaction tx) => prev + tx.amount.abs());
    totalReceivedNumber = totalReceivedTxs.length;
    totalSentNumber = totalSentTxs.length;

    if (widget.collectOtherContacts) {
      for (final Transaction tx in transactions) {
        otherContacts.addAll(tx.recipients);
        otherContacts.add(tx.from);
      }
      otherContacts.remove(widget.contact);
    }

    final String markdownSummary =
        _generateMarkdownSummary(totalReceived, totalSent);
    widget.onResult(totalReceived, totalSent, totalSentNumber,
        totalReceivedNumber, otherContacts, markdownSummary);
  }

  String _generateMarkdownSummary(double totalReceived, double totalSent) {
    final StringBuffer markdownBuffer = StringBuffer();
    markdownBuffer.writeln("### ${tr('transaction_summary')}");
    markdownBuffer.writeln(
        "- ${tr('total_received', namedArgs: <String, String>{
          'number': totalReceived.toString()
        })} ${humanizeAmountS(widget.isCurrencyBefore, context, widget.isG1, true, widget.currentSymbol, 16, totalReceived, widget.currentUd, Colors.green)})");
    markdownBuffer.writeln("- ${tr('total_sent', namedArgs: <String, String>{
          'number': totalSent.toString()
        })} ${humanizeAmountS(widget.isCurrencyBefore, context, widget.isG1, true, widget.currentSymbol, 16, totalSent, widget.currentUd, Colors.red)})");

    markdownBuffer.writeln("- ${tr('total_sent')}: $totalSent");

    markdownBuffer.writeln("- ${tr('transactions')}:");
    for (final Transaction tx in transactions) {
      markdownBuffer.writeln('  - $tx');
    }
    /* if (widget.collectOtherContacts && otherContacts.isNotEmpty) {
      markdownBuffer.writeln("- ${tr('other_contacts_involved')}:");
      for (final Contact contact in otherContacts) {
        markdownBuffer.writeln("  - ${humanizeContact('', contact, true)}");
      }
    } */

    return markdownBuffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text.rich(TextSpan(children: <InlineSpan>[
                  TextSpan(
                    text: tr('total_received', namedArgs: <String, String>{
                      'number': totalReceivedNumber.toString()
                    }),
                    style: const TextStyle(fontSize: 16, color: Colors.green),
                  ),
                  separatorSpan(),
                  humanizeAmount(
                      widget.isCurrencyBefore,
                      context,
                      widget.isG1,
                      true,
                      widget.currentSymbol,
                      16,
                      totalReceived,
                      widget.currentUd,
                      Colors.green)
                ]))),
            Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text.rich(TextSpan(children: <InlineSpan>[
                  TextSpan(
                    text: tr('total_sent', namedArgs: <String, String>{
                      'number': totalSentNumber.toString()
                    }),
                    style: const TextStyle(fontSize: 16, color: Colors.red),
                  ),
                  separatorSpan(),
                  humanizeAmount(
                      widget.isCurrencyBefore,
                      context,
                      widget.isG1,
                      true,
                      widget.currentSymbol,
                      16,
                      totalSent,
                      widget.currentUd,
                      Colors.red)
                ]))),
          ]),
      initiallyExpanded: widget.initiallyExpanded,
      children: <Widget>[
        SizedBox(
          height: transactions.length * 80.0,
          // Approximate height per transaction
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: transactions.length,
            itemBuilder: (BuildContext context, int index) {
              final Transaction tx = transactions[index];
              return TransactionListItem(
                pubKey: widget.contact.pubKey,
                currentUd: widget.currentUd,
                isG1: widget.isG1,
                isCurrencyBefore: widget.isCurrencyBefore,
                currentSymbol: widget.currentSymbol,
                isExternalAccount: true,
                index: index,
                transaction: tx,
                customPositiveAmountColor: Colors.green,
              );
            },
          ),
        ),
      ],
    );
  }
}
