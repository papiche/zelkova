import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import '../../../data/models/contact.dart';
import '../../../data/models/node.dart';
import '../../../data/models/transaction.dart';
import '../../../data/models/transaction_state.dart';
import '../../../g1/api.dart';
import '../../../g1/transaction_parser.dart';
import '../../ui_helpers.dart';
import 'transaction_item.dart';

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
  final Function(double, double, Set<Contact>, String) onResult;
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

  @override
  void initState() {
    super.initState();
    _fetchTransactions();
  }

  Future<void> _fetchTransactions() async {
    final Tuple2<Map<String, dynamic>?, Node> txDataResult =
        await gvaHistoryAndBalance(widget.contact.pubKey,
            pageSize: widget.pageSize, from: widget.from, to: widget.to);

    if (txDataResult.item1 == null) {
      return;
    }

    final Map<String, dynamic> txData = txDataResult.item1!;
    final TransactionState newParsedState = await transactionsGvaParser(
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
    final double totalReceived = transactions
        .where((Transaction tx) => tx.amount > 0)
        .fold(0.0, (double prev, Transaction tx) => prev + tx.amount);
    final double totalSent = transactions
        .where((Transaction tx) => tx.amount < 0)
        .fold(0.0, (double prev, Transaction tx) => prev + tx.amount.abs());

    if (widget.collectOtherContacts) {
      for (final Transaction tx in transactions) {
        otherContacts.addAll(tx.recipients);
        otherContacts.add(tx.from);
      }
      otherContacts.remove(widget.contact);
    }

    final String markdownSummary =
        _generateMarkdownSummary(totalReceived, totalSent);
    widget.onResult(totalReceived, totalSent, otherContacts, markdownSummary);
  }

  String _generateMarkdownSummary(double totalReceived, double totalSent) {
    final StringBuffer markdownBuffer = StringBuffer();
    markdownBuffer.writeln("### ${tr('transaction_summary')}");
    markdownBuffer.writeln("- ${tr('total_received')}: $totalReceived");
    markdownBuffer.writeln("- ${tr('total_sent')}: $totalSent");

    if (widget.collectOtherContacts && otherContacts.isNotEmpty) {
      markdownBuffer.writeln("- ${tr('other_contacts_involved')}:");
      for (final Contact contact in otherContacts) {
        markdownBuffer.writeln("  - ${humanizeContact('', contact, true)}");
      }
    }

    return markdownBuffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    final double totalReceived = transactions
        .where((Transaction tx) => tx.amount > 0)
        .fold(0.0, (double prev, Transaction tx) => prev + tx.amount);
    final double totalSent = transactions
        .where((Transaction tx) => tx.amount < 0)
        .fold(0.0, (double prev, Transaction tx) => prev + tx.amount.abs());

    return ExpansionTile(
      title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text.rich(TextSpan(children: <InlineSpan>[
                  TextSpan(
                    text: tr('total_received'),
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
                    text: tr('total_sent'),
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
        ListView.builder(
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
            );
          },
        ),
      ],
    );
  }
}
