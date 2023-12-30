import 'dart:convert';

import '../data/models/contact.dart';
import '../data/models/transaction.dart';
import '../data/models/transaction_state.dart';
import '../data/models/transaction_type.dart';
import '../ui/contacts_cache.dart';
import 'g1_helper.dart';

final RegExp exp = RegExp(r'\((.*?)\)');

Future<TransactionState> transactionParser(
    String txData, List<Transaction> pendingTransactions) async {
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
    final Contact fromC = getContactCache(pubKey: address2!);
    final Contact toC = getContactCache(pubKey: address1!);

    tx.insert(
        0,
        Transaction(
            type: type,
            from: fromC,
            to: toC,
            amount: pubKey == address2 ? -amount : amount,
            comment: comment,
            time: txDate));
  }
  return TransactionState(
      transactions: tx,
      pendingTransactions: pendingTransactions,
      balance: balance,
      lastChecked: DateTime.now());
}

Contact getContactCache({required String pubKey}) {
  final Contact contact =
      ContactsCache().getCachedContact(pubKey, false, true) ??
          Contact(pubKey: pubKey);
  assert(contact.hasAvatar == false);
  return contact;
}

Future<TransactionState> transactionsGvaParser(Map<String, dynamic> txData,
    TransactionState state, String myPubKeyRaw) async {
  final String myPubKey = extractPublicKey(myPubKeyRaw);
  // Balance
  final dynamic rawBalance = txData['balance'];
  final double amount = rawBalance != null
      ? ((rawBalance as Map<String, dynamic>)['amount'] as int) / 1.0
      : 0;
  final dynamic rawCurrentUd = txData['currentUd'];
  final double? currentUd = rawCurrentUd != null
      ? ((rawCurrentUd as Map<String, dynamic>)['amount'] as int) / 100.0
      : null;

  // Transactions
  final Map<String, dynamic> txsHistoryBc =
      txData['txsHistoryBc'] as Map<String, dynamic>;

  final Map<String, dynamic> txsHistoryMp =
      txData['txsHistoryMp'] as Map<String, dynamic>;
  final Map<String, dynamic> both =
      txsHistoryBc['both'] as Map<String, dynamic>;
  final List<dynamic> edges = both['edges'] as List<dynamic>;
  final Map<String, dynamic> pageInfo =
      both['pageInfo'] as Map<String, dynamic>;
  final List<Transaction> txs = <Transaction>[];
  for (final dynamic edgeRaw in edges) {
    final Transaction tx =
        await _transactionGvaParser(edgeRaw as Map<String, dynamic>, myPubKey);
    if (tx.from.pubKey == myPubKey &&
        tx.recipients[0].pubKey == myPubKey &&
        tx.recipients.length == 1) {
      // This is a return cash back to me
      continue;
    } else {
      txs.add(tx);
    }
  }
  final List<dynamic> receiving = txsHistoryMp['receiving'] as List<dynamic>;
  final List<dynamic> sending = txsHistoryMp['sending'] as List<dynamic>;
  for (final dynamic receiveRaw in receiving) {
    final Transaction tx = await _txGvaParse(receiveRaw as Map<String, dynamic>,
        myPubKey, TransactionType.receiving);
    txs.insert(0, tx);
  }
  for (final dynamic sendingRaw in sending) {
    final Transaction tx = await _txGvaParse(
        sendingRaw as Map<String, dynamic>, myPubKey, TransactionType.sending);
    txs.insert(0, tx);
  }

  return state.copyWith(
      transactions: txs,
      balance: amount,
      currentUd: currentUd,
      lastChecked: DateTime.now(),
      endCursor: pageInfo['endCursor'] as String?);
}

Future<Transaction> _transactionGvaParser(
    Map<String, dynamic> edge, String myPubKey) {
  final Map<String, dynamic> parsedTxData = edge;
  // Direction
  final String direction = parsedTxData['direction'] as String;
  final TransactionType type =
      direction == 'SENT' ? TransactionType.sent : TransactionType.received;

  final Map<String, dynamic> tx = parsedTxData['node'] as Map<String, dynamic>;
  return _txGvaParse(tx, myPubKey, type);
}

Future<Transaction> _txGvaParse(
    Map<String, dynamic> tx, String myPubKey, TransactionType type) async {
  final List<dynamic> issuers = tx['issuers'] as List<dynamic>;
  final List<dynamic> outputs = tx['outputs'] as List<dynamic>;
  final String from = issuers[0] as String;

  final List<Contact> recipients = <Contact>[];
  final List<double> recipientsAmounts = <double>[];
  double amount = 0.0;
  Contact? toC;
  final bool isSent =
      type == TransactionType.sent || type == TransactionType.sending;
  for (final dynamic output in outputs) {
    // Extract the recipient from each output
    final String outputS = output as String;
    final String? recipient = exp.firstMatch(outputS)!.group(1);
    final Contact recipientContact = getContactCache(pubKey: recipient!);
    recipients.add(recipientContact);

    final double outputAmount = double.parse(outputS.split(':')[0]);
    recipientsAmounts.add(amount);
    if (isSent) {
      if (recipient != myPubKey) {
        // Is not the return cash back to me
        amount += outputAmount;
      }
    } else {
      if (recipient == myPubKey) {
        amount = outputAmount;
        toC = recipientContact;
      }
    }
  }

  if (isSent) {
    // this only works in the case of a single recipient
    toC = recipients.first;
  }

  // Time
  final dynamic writtenTime = tx['writtenTime'];
  final DateTime time = writtenTime == null
      ? DateTime.now()
      : DateTime.fromMillisecondsSinceEpoch((writtenTime as int) * 1000);

  if (isSent) {
    amount = -amount;
  }
  // Comment
  final String comment = tx['comment'] as String;
  final Contact fromC = getContactCache(pubKey: from);

  return Transaction(
    type: type,
    from: fromC,
    to: toC!,
    recipients: recipients,
    recipientsAmounts: recipientsAmounts,
    amount: amount,
    comment: comment,
    time: time,
  );
}
