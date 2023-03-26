import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ginkgo/data/models/transaction.dart';
import 'package:ginkgo/data/models/transaction_type.dart';
import 'package:ginkgo/g1/transaction_parser.dart';

void main() {
  test('Test parsing', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final String txData = await rootBundle.loadString('assets/tx.json');
    final TransactionsAndBalanceState result = transactionParser(txData);
    expect(result.balance, equals(6700));
    final List<Transaction> txs = result.transactions;
    for (final Transaction tx in txs) {
      expect(tx.from != tx.to, equals(true));
    }
    expect(txs.first.to == '9Bcx5JV3swCQBEeH3PcuNcBVperLscWtN78hjFVx1yzG',
        equals(true));
    expect(txs.first.from != '9Bcx5JV3swCQBEeH3PcuNcBVperLscWtN78hjFVx1yzG',
        equals(true));
    expect(txs[txs.length - 2].amount < 0, equals(true));
    expect(txs.last.amount > 0, equals(true));
  });

  test('Test gva history parsing', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final String txData = await rootBundle.loadString('assets/gva-tx.json');
    final TransactionsAndBalanceState result = transactionsGvaParser(
        (jsonDecode(txData) as Map<String, dynamic>)['data']
            as Map<String, dynamic>);
    expect(result.balance, equals(3));
    final List<Transaction> txs = result.transactions;
    for (final Transaction tx in txs) {
      expect(tx.from != tx.to, equals(true));
    }
    expect(
        txs.first.from, equals('BrgsSYK3xUzDyztGBHmxq69gfNxBfe2UKpxG21oZUBr5'));
    expect(
        txs.first.to, equals('6DrGg8cftpkgffv4Y4Lse9HSjgc8coEQor3yvMPHAnVH'));
    expect(txs.first.type, equals(TransactionType.receiving));
    expect(txs.first.amount, equals(100));
    expect(txs[1].to, equals('EDB7chzCBdtUCnqFZquVeto4a65FjeRkPrqcV8NwVbTx'));
    expect(txs[1].from, equals('6DrGg8cftpkgffv4Y4Lse9HSjgc8coEQor3yvMPHAnVH'));
    expect(txs[1].amount, equals(-1200));
    expect(txs[1].type, equals(TransactionType.sent));

    expect(
        txs.last.from, equals('A1Fc1VoCLKHyPYmXimYECSmjmsceqwRSZcTBXfgG9JaB'));
    expect(txs.last.to, equals('6DrGg8cftpkgffv4Y4Lse9HSjgc8coEQor3yvMPHAnVH'));
    expect(txs.last.type, equals(TransactionType.received));
    expect(txs.last.amount, equals(10000));

    const String emptyTx = '''
    {
  "data": {
    "balance": null,
    "currentUd": {
      "amount": 1068,
      "base": 0
    },
    "txsHistoryBc": {
      "both": {
        "edges": [],
        "pageInfo": {
          "endCursor": null,
          "hasNextPage": false,
          "hasPreviousPage": false,
          "startCursor": null
        }
      }
    },
    "txsHistoryMp": {
      "receiving": [],
      "sending": []
    }
  }
}''';
    final TransactionsAndBalanceState emptyResult = transactionsGvaParser(
        (jsonDecode(emptyTx) as Map<String, dynamic>)['data']
            as Map<String, dynamic>);
    expect(emptyResult.balance, equals(0));
    final List<Transaction> emptyTxs = emptyResult.transactions;
    expect(emptyTxs.length, equals(0));
  });
}
