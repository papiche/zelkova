import 'dart:async';

import '../data/models/contact.dart';
import '../data/models/transaction.dart';
import '../data/models/transaction_state.dart';
import '../data/models/transaction_type.dart';
import '../ui/logger.dart';
import 'duniter_endpoint_helper.dart';
import 'g1_v2_helper.dart';

Future<TransactionState> transactionsV2Parser(
  Map<String, dynamic> jsonData,
  TransactionState currentState,
  String pubKeyRaw,
) async {
  final String accountAddress = addressFromV1PubkeyFaiSafe(pubKeyRaw);

  final double currentUd = await currentUniversalDividendV2();

  if (jsonData == null || jsonData.isEmpty) {
    return currentState.copyWith(
      balance: 0.0,
      currentUd: currentUd,
      transactions: <Transaction>[],
      lastChecked: DateTime.now(),
    );
  }

  final Map<String, dynamic>? accountsConnection =
      jsonData['accounts'] as Map<String, dynamic>?;

  if (accountsConnection == null) {
    return currentState.copyWith(
      balance: 0.0,
      currentUd: currentUd,
      transactions: <Transaction>[],
      lastChecked: DateTime.now(),
    );
  }

  final List<dynamic>? accounts = accountsConnection['nodes'] as List<dynamic>?;
  if (accounts == null || accounts.isEmpty) {
    return currentState.copyWith(
      balance: 0.0,
      currentUd: currentUd,
      transactions: <Transaction>[],
      lastChecked: DateTime.now(),
    );
  }

  final Map<String, dynamic>? account = accounts
      .where((dynamic acc) =>
          (acc as Map<String, dynamic>)['id'] == accountAddress)
      .cast<Map<String, dynamic>>()
      .firstOrNull;

  if (account == null) {
    return currentState.copyWith(
      balance: 0.0,
      currentUd: currentUd,
      transactions: <Transaction>[],
      lastChecked: DateTime.now(),
    );
  }

  final double balance = (jsonData['balance'] as BigInt?)?.toDouble() ?? 0.0;

  final Map<String, dynamic>? transfersIssuedConnection =
      account['transfersIssued'] as Map<String, dynamic>?;
  final List<dynamic> transfersIssuedNodes =
      transfersIssuedConnection?['nodes'] as List<dynamic>? ?? <dynamic>[];

  final Map<String, dynamic>? transfersReceivedConnection =
      account['transfersReceived'] as Map<String, dynamic>?;
  final List<dynamic> transfersReceivedNodes =
      transfersReceivedConnection?['nodes'] as List<dynamic>? ?? <dynamic>[];

  final List<Transaction> issuedTransactions = await _parseTransactions(
    transfersIssuedNodes,
    TransactionType.sent,
    accountAddress,
  );

  final List<Transaction> receivedTransactions = await _parseTransactions(
    transfersReceivedNodes,
    TransactionType.received,
    accountAddress,
  );

  final List<Transaction> allTransactions = <Transaction>[
    ...receivedTransactions,
    ...issuedTransactions
  ];

  allTransactions
      .sort((Transaction a, Transaction b) => b.time.compareTo(a.time));

  return currentState.copyWith(
    balance: balance,
    currentUd: currentUd,
    transactions: allTransactions,
    lastChecked: DateTime.now(),
  );
}

Future<List<Transaction>> _parseTransactions(
  List<dynamic> rawTransactions,
  TransactionType type,
  String accountAddress,
) async {
  final List<Transaction> transactions = <Transaction>[];

  for (final dynamic rawTx in rawTransactions) {
    try {
      final Map<String, dynamic> txData = rawTx as Map<String, dynamic>;

      final String from =
          (txData['from'] as Map<String, dynamic>)['id'] as String;
      final String to = (txData['to'] as Map<String, dynamic>)['id'] as String;
      final DateTime time = DateTime.parse(txData['timestamp'] as String);
      double amount = double.parse(txData['amount'] as String);
      final Map<String, dynamic>? commentRaw =
          txData['comment'] as Map<String, dynamic>?;

      /* final String? comment =
          commentRaw != null ? commentRaw['remark'] as String : null; */

      // log.i(commentRaw != null ? commentRaw['remarkBytes'] as String? : '');
      final String? comment =
          commentRaw != null && commentRaw['remarkBytes'] != null
              ? decodeHexToText(commentRaw['remarkBytes'] as String)
              : null;

      final Contact fromContact = Contact.withAddress(address: from);
      final Contact toContact = Contact.withAddress(address: to);

      if (type == TransactionType.sent) {
        amount = -amount;
      }

      final Transaction transaction = Transaction(
        type: type,
        from: fromContact,
        recipients: <Contact>[toContact],
        amount: amount,
        comment: comment ?? '',
        time: time,
      );
      transactions.add(transaction);
    } catch (e, st) {
      loggerDev('Error parsing transaction $rawTx', error: e, stackTrace: st);
      rethrow;
    }
  }

  return transactions;
}
