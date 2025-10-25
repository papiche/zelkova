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
  final double balance = balanceParsed ?? 0.0;

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

  return currentState.copyWith(
    balance: balance,
    currentUd: currentUd,
    transactions: finalTransactions,
    endCursor: combinedEndCursor,
    hasNextPage: hasNextPage,
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
