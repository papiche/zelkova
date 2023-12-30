import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ginkgo/data/models/transaction.dart';
import 'package:ginkgo/data/models/transaction_state.dart';
import 'package:ginkgo/data/models/transaction_type.dart';
import 'package:ginkgo/g1/transaction_parser.dart';
import 'package:ginkgo/ui/contacts_cache.dart';

void main() {
  setUpAll(() {
    ContactsCache().init(true);
  });

  test('test put', () async {
    final MemoryFallbackBox<String> fallbackBox = MemoryFallbackBox<String>();

    await fallbackBox.put('key', 'value');
    final String? value = fallbackBox.get('key');

    expect(value, 'value');
  });

  test('Test parsing', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final String txData = await rootBundle.loadString('assets/tx.json');
    final TransactionState result =
        await transactionParser(txData, <Transaction>[]);
    expect(result.balance, equals(6700));
    final List<Transaction> txs = result.transactions;
    for (final Transaction tx in txs) {
      expect(tx.recipientsWithoutCashBack.contains(tx.from), equals(false));
    }
    expect(
        txs.first.recipients[0].pubKey ==
            '9Bcx5JV3swCQBEeH3PcuNcBVperLscWtN78hjFVx1yzG',
        equals(true));
    expect(
        txs.first.from.pubKey != '9Bcx5JV3swCQBEeH3PcuNcBVperLscWtN78hjFVx1yzG',
        equals(true));
    expect(txs[txs.length - 2].amount < 0, equals(true));
    expect(txs.last.amount > 0, equals(true));
  });

  test('Test gva history parsing', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final String txData = await rootBundle.loadString('assets/gva-tx.json');
    final TransactionState result = await transactionsGvaParser(
        (jsonDecode(txData) as Map<String, dynamic>)['data']
            as Map<String, dynamic>,
        TransactionState.emptyState,
        '6DrGg8cftpkgffv4Y4Lse9HSjgc8coEQor3yvMPHAnVH');
    expect(result.balance, equals(3));
    final List<Transaction> txs = result.transactions;
    for (final Transaction tx in txs) {
      expect(tx.recipientsWithoutCashBack.contains(tx.from), equals(false));
    }
    expect(txs.first.from.pubKey,
        equals('BrgsSYK3xUzDyztGBHmxq69gfNxBfe2UKpxG21oZUBr5'));
    expect(txs.first.recipients[0].pubKey,
        equals('6DrGg8cftpkgffv4Y4Lse9HSjgc8coEQor3yvMPHAnVH'));
    expect(txs.first.type, equals(TransactionType.receiving));
    expect(txs.first.amount, equals(100));
    expect(txs[1].recipients[0].pubKey,
        equals('EDB7chzCBdtUCnqFZquVeto4a65FjeRkPrqcV8NwVbTx'));
    expect(txs[1].from.pubKey,
        equals('6DrGg8cftpkgffv4Y4Lse9HSjgc8coEQor3yvMPHAnVH'));
    expect(txs[1].amount, equals(-1200));
    expect(txs[1].type, equals(TransactionType.sent));

    expect(txs.last.from.pubKey,
        equals('A1Fc1VoCLKHyPYmXimYECSmjmsceqwRSZcTBXfgG9JaB'));
    expect(txs.last.recipients[0].pubKey,
        equals('6DrGg8cftpkgffv4Y4Lse9HSjgc8coEQor3yvMPHAnVH'));
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
    final TransactionState emptyResult = await transactionsGvaParser(
        (jsonDecode(emptyTx) as Map<String, dynamic>)['data']
            as Map<String, dynamic>,
        TransactionState.emptyState,
        '6DrGg8cftpkgffv4Y4Lse9HSjgc8coEQor3yvMPHAnVH');
    expect(emptyResult.balance, equals(0));
    final List<Transaction> emptyTxs = emptyResult.transactions;
    expect(emptyTxs.length, equals(0));
  });
}
