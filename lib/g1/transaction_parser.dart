import 'dart:convert';

import '../data/models/transaction.dart';

TransactionsAndBalanceState transactionParser(String txData) {
  final RegExp exp = RegExp(r'\((.*?)\)');

  final Map<String, dynamic> parsedTxData =
      json.decode(txData) as Map<String, dynamic>;
  final String pubKey = parsedTxData['pubkey'] as String;
  final List<dynamic> listReceived = (parsedTxData['history']
      as Map<String, dynamic>)['received'] as List<dynamic>;
  double balance = 0;
  final List<Transaction> tx = <Transaction>[];
  for (final dynamic receivedRaw in listReceived) {
    final Map<String, dynamic> received = receivedRaw as Map<String, dynamic>;
    final int timestamp = received['blockstampTime'] as int;
    final String comment = received['comment'] as String;
    final List<dynamic> outputs = received['outputs'] as List<dynamic>;
    final double amount = double.parse((outputs[0] as String).split(':')[0]);
    final String? address1 = exp.firstMatch(outputs[0] as String)!.group(1);
    final String? address2 = exp.firstMatch(outputs[1] as String)!.group(1);
    if (pubKey == address1) {
      // Receive
      balance = balance += amount;
    }
    if (pubKey == address2) {
      // Send
      balance = balance -= amount;
    }
    final DateTime txDate =
        DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    /* if (!kReleaseMode) {
      logger('Timestamp: $timestamp');
      logger('Fecha: $txDate');
    } */
    tx.insert(
        0,
        Transaction(
            from: address2!,
            to: address1!,
            amount: pubKey == address2 ? -amount : amount,
            comment: comment,
            time: txDate));
  }
  return TransactionsAndBalanceState(
      transactions: tx, balance: balance, lastChecked: DateTime.now());
}
