import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ginkgo/g1/transaction.dart';
import 'package:ginkgo/g1/transaction_parser.dart';

void main() {
  test('Test parsing', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final String txData = await rootBundle.loadString('assets/tx.json');
    final TransactionsAndBalance result = transactionParser(txData);
    expect(result.balance, equals(6700));
    for (final Transaction tx in result.transactions) {
      expect(tx.from != tx.to, equals(true));
    }
    expect(
        result.transactions.first.to ==
            '9Bcx5JV3swCQBEeH3PcuNcBVperLscWtN78hjFVx1yzG',
        equals(true));
    expect(
        result.transactions.first.from !=
            '9Bcx5JV3swCQBEeH3PcuNcBVperLscWtN78hjFVx1yzG',
        equals(true));
    expect(result.transactions[1].amount < 0, equals(true));
    expect(result.transactions.first.amount > 0, equals(true));
  });
}
