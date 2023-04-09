import 'dart:convert';

import '../data/models/transaction.dart';
import '../data/models/transaction_balance_state.dart';
import '../data/models/transaction_type.dart';

final RegExp exp = RegExp(r'\((.*?)\)');

TransactionsAndBalanceState transactionParser(String txData) {
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
    TransactionType type = TransactionType.received;
    if (pubKey == address1) {
      // Receive
      type = TransactionType.received;
      balance = balance += amount;
    }
    if (pubKey == address2) {
      // Send
      type = TransactionType.sent;
      balance = balance -= amount;
    }
    final DateTime txDate =
        DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true);
    /* if (!kReleaseMode) {
      logger('Timestamp: $timestamp');
      logger('Fecha: $txDate');
    } */
    tx.insert(
        0,
        Transaction(
            type: type,
            from: address2!,
            to: address1!,
            amount: pubKey == address2 ? -amount : amount,
            comment: comment,
            time: txDate));
  }
  return TransactionsAndBalanceState(
      transactions: tx, balance: balance, lastChecked: DateTime.now());
}

TransactionsAndBalanceState transactionsGvaParser(
    Map<String, dynamic> txData, TransactionsAndBalanceState state) {
  // Balance
  final dynamic rawBalance = txData['balance'];
  final double? amount;
  if (rawBalance != null) {
    final Map<String, dynamic> balance = rawBalance as Map<String, dynamic>;
    amount = (balance['amount'] as int) / 1.0;
  } else {
    amount = 0;
  }
  // Transactions
  final Map<String, dynamic> txsHistoryBc =
      txData['txsHistoryBc'] as Map<String, dynamic>;

  final Map<String, dynamic> txsHistoryMp =
      txData['txsHistoryMp'] as Map<String, dynamic>;
  final Map<String, dynamic> both =
      txsHistoryBc['both'] as Map<String, dynamic>;
  final List<dynamic> edges = both['edges'] as List<dynamic>;
  final List<Transaction> txs = <Transaction>[];
  for (final dynamic edgeRaw in edges) {
    final Transaction tx =
        _transactionGvaParser(edgeRaw as Map<String, dynamic>);
    txs.add(tx);
  }
  final List<dynamic> receiving = txsHistoryMp['receiving'] as List<dynamic>;
  final List<dynamic> sending = txsHistoryMp['sending'] as List<dynamic>;
  for (final dynamic receiveRaw in receiving) {
    final Transaction tx = _txGvaParse(
        receiveRaw as Map<String, dynamic>, TransactionType.receiving);
    txs.insert(0, tx);
  }
  for (final dynamic sendingRaw in sending) {
    final Transaction tx = _txGvaParse(
        sendingRaw as Map<String, dynamic>, TransactionType.sending);
    txs.insert(0, tx);
  }

  return state.copyWith(
      transactions: txs, balance: amount, lastChecked: DateTime.now());
}

Transaction _transactionGvaParser(Map<String, dynamic> edge) {
  final Map<String, dynamic> parsedTxData = edge;
  // Direction
  final String direction = parsedTxData['direction'] as String;
  final TransactionType type =
      direction == 'SENT' ? TransactionType.sent : TransactionType.received;

  final Map<String, dynamic> tx = parsedTxData['node'] as Map<String, dynamic>;
  return _txGvaParse(tx, type);
}

Transaction _txGvaParse(Map<String, dynamic> tx, TransactionType type) {
  final List<dynamic> issuers = tx['issuers'] as List<dynamic>;
  final List<dynamic> outputs = tx['outputs'] as List<dynamic>;
  final String from = issuers[0] as String;
  final String? to = exp.firstMatch(outputs[0] as String)!.group(1);

  // Time
  final dynamic writtenTime = tx['writtenTime'];
  final DateTime time = writtenTime == null
      ? DateTime.now()
      : DateTime.fromMillisecondsSinceEpoch((writtenTime as int) * 1000);
  // Amount
  double amount = double.parse((outputs.first as String).split(':')[0]);
  if (type == TransactionType.sent || type == TransactionType.sending) {
    amount = -amount;
  }
  // Comment
  final String comment = tx['comment'] as String;

  return Transaction(
    type: type,
    from: from,
    to: to!,
    amount: amount,
    comment: comment,
    time: time,
  );
}
