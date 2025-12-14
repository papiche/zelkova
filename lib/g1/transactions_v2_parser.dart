import 'dart:async';

import 'package:flutter/foundation.dart';

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
  String pubKeyRaw, {
  String? cursor, // Add cursor parameter to know if it's the first page
  double? cachedUd, // Accept cached UD from AppCubit
}) async {
  final String accountAddress = addressFromV1PubkeyFaiSafe(pubKeyRaw);

  // Use cached UD if provided, otherwise fetch it
  final double currentUd = cachedUd ?? await currentUniversalDividendV2();

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
  // final dynamic rawBalance = account['balance'];
  final dynamic rawBalance = account['totalBalance'];
  final double? balanceParsed =
      rawBalance is String ? double.tryParse(rawBalance) : 0.0;
  double balance = balanceParsed ?? 0.0;

  // FIXME, this previous value is the duniter indexer balance, but for now, let's use the duniter endpoint balance that is more accurate
  balance = await calculateBalanceFromEndPoint(address: accountAddress);

  final Map<String, dynamic>? transfersIssuedConnection =
      account['transfersIssued'] as Map<String, dynamic>?;
  final List<dynamic> transfersIssuedNodes =
      transfersIssuedConnection?['nodes'] as List<dynamic>? ?? <dynamic>[];
  final Map<String, dynamic>? issuedPageInfo =
      transfersIssuedConnection?['pageInfo'] as Map<String, dynamic>?;

  final Map<String, dynamic>? transfersReceivedConnection =
      account['transfersReceived'] as Map<String, dynamic>?;
  final List<dynamic> transfersReceivedNodes =
      transfersReceivedConnection?['nodes'] as List<dynamic>? ?? <dynamic>[];
  final Map<String, dynamic>? receivedPageInfo =
      transfersReceivedConnection?['pageInfo'] as Map<String, dynamic>?;

  // Extract pagination info - we need both endCursors and hasNextPage flags
  final String? issuedEndCursor = issuedPageInfo?['endCursor'] as String?;
  final String? receivedEndCursor = receivedPageInfo?['endCursor'] as String?;
  final bool issuedHasNextPage =
      issuedPageInfo?['hasNextPage'] as bool? ?? false;
  final bool receivedHasNextPage =
      receivedPageInfo?['hasNextPage'] as bool? ?? false;

  // We have more pages if either list has more pages
  final bool hasNextPage = issuedHasNextPage || receivedHasNextPage;

  // Store the endCursor - we'll use the one from the list that has more items
  // or combine them somehow. For now, let's store both in a combined format
  String? combinedEndCursor;
  if (issuedEndCursor != null && receivedEndCursor != null) {
    combinedEndCursor = '$issuedEndCursor|$receivedEndCursor';
  } else if (issuedEndCursor != null) {
    combinedEndCursor = '$issuedEndCursor|';
  } else if (receivedEndCursor != null) {
    combinedEndCursor = '|$receivedEndCursor';
  }

  // For UD history, we'll get it from transferWithUd field
  final Map<String, dynamic>? transferWithUdConnection =
      account['transferWithUd'] as Map<String, dynamic>?;
  final List<dynamic> transferWithUdNodes =
      transferWithUdConnection?['nodes'] as List<dynamic>? ?? <dynamic>[];
  final Map<String, dynamic>? transferWithUdPageInfo =
      transferWithUdConnection?['pageInfo'] as Map<String, dynamic>?;

  loggerDev(
      '[transactionsV2Parser] transferWithUd found: ${transferWithUdConnection != null}, nodes count: ${transferWithUdNodes.length}');

  final String? udHistoryEndCursor =
      transferWithUdPageInfo?['endCursor'] as String?;
  final bool udHistoryHasNextPage =
      transferWithUdPageInfo?['hasNextPage'] as bool? ?? false;

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

  // Parse UD transactions from transferWithUd field
  final List<Transaction> udTransactions =
      await _parseUDTransactionsFromTransferWithUd(
    transferWithUdNodes,
    accountAddress,
    currentUd,
  );

  loggerDev(
      '[transactionsV2Parser] Parsed UD transactions: ${udTransactions.length}');

  final List<Transaction> allTransactions = <Transaction>[
    ...receivedTransactions,
    ...issuedTransactions
  ];

  allTransactions
      .sort((Transaction a, Transaction b) => b.time.compareTo(a.time));

  // Improved accumulation logic:
  // - If cursor is null, it's the first page -> replace all content
  // - If cursor is not null, it's a subsequent page -> accumulate
  final List<Transaction> finalTransactions;
  if (cursor == null) {
    // First page: replace all content to start fresh
    finalTransactions = allTransactions;
  } else {
    // Subsequent pages: accumulate with existing transactions
    finalTransactions = <Transaction>[
      ...currentState.transactions,
      ...allTransactions,
    ];
    // Sort again after merging
    finalTransactions
        .sort((Transaction a, Transaction b) => b.time.compareTo(a.time));
  }

  // Accumulation logic for UD transactions
  final List<Transaction> finalUDTransactions;
  if (cursor == null) {
    finalUDTransactions = udTransactions;
  } else {
    finalUDTransactions = <Transaction>[
      ...currentState.udTransactions,
      ...udTransactions,
    ];
    finalUDTransactions
        .sort((Transaction a, Transaction b) => b.time.compareTo(a.time));
  }

  debugPrint('[transactionsV2Parser] Final state:');
  debugPrint(
      '[transactionsV2Parser] - Transactions: ${finalTransactions.length}');
  debugPrint(
      '[transactionsV2Parser] - UD Transactions: ${finalUDTransactions.length}');
  debugPrint(
      '[transactionsV2Parser] - Current state UD Transactions before copyWith: ${currentState.udTransactions.length}');

  final TransactionState newState = currentState.copyWith(
    balance: balance,
    currentUd: currentUd,
    transactions: finalTransactions,
    pendingTransactions: currentState.pendingTransactions,
    endCursor: combinedEndCursor,
    hasNextPage: hasNextPage,
    udTransactions: finalUDTransactions,
    udEndCursor: udHistoryEndCursor,
    udHasNextPage: udHistoryHasNextPage,
    lastChecked: DateTime.now(),
  );

  debugPrint(
      '[transactionsV2Parser] - New state UD Transactions after copyWith: ${newState.udTransactions.length}');

  return newState;
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

/// Parse UD transactions from the transferWithUd field
Future<List<Transaction>> _parseUDTransactionsFromTransferWithUd(
  List<dynamic> transferWithUdNodes,
  String accountAddress,
  double currentUd,
) async {
  final List<Transaction> udTransactions = <Transaction>[];

  for (final dynamic udNode in transferWithUdNodes) {
    try {
      final Map<String, dynamic> udData = udNode as Map<String, dynamic>;

      final double amount = double.parse(udData['amount'] as String);
      final DateTime time = DateTime.parse(udData['timestamp'] as String);

      // Create a system UD contact (don't use invalid address)
      final Contact fromContact = Contact.empty().copyWith(
        nick: 'Universal Dividend',
      );
      final Contact toContact = Contact.withAddress(address: accountAddress);

      final Transaction transaction = Transaction(
        type: TransactionType.dividendReceived,
        from: fromContact,
        recipients: <Contact>[toContact],
        amount: amount,
        comment: 'Universal Dividend',
        time: time,
      );
      udTransactions.add(transaction);
    } catch (e, st) {
      loggerDev('Error parsing UD transaction from transferWithUd $udNode',
          error: e, stackTrace: st);
      // Don't rethrow for UD parsing to be more resilient
    }
  }

  udTransactions
      .sort((Transaction a, Transaction b) => b.time.compareTo(a.time));
  return udTransactions;
}
