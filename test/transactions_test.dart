import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ginkgo/data/models/transaction.dart';
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
}
