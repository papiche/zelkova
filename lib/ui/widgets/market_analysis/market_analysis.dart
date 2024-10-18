import '../../../data/models/contact.dart';
import '../../../data/models/transaction.dart';

class AccountTotals {
  double totalIncome = 0;
  double totalExpenses = 0;
  List<Transaction> transactions = <Transaction>[];
}

Future<void> fetchTransactionsForContacts(
    List<Contact> contacts,
    DateTime startDate,
    DateTime endDate,
    Function(List<Transaction> newTransactions,
            Map<String, AccountTotals> totals)
        updateUI) async {
  final Map<String, AccountTotals> accountTotals = <String, AccountTotals>{};
  final Set<int> visitedTransactionHashes = <int>{};

  for (final Contact contact in contacts) {
    final List<Transaction> transactions =
        await getAllTransactionsForAddress(contact.pubKey);

    final List<Transaction> newTransactions = <Transaction>[];

    for (final Transaction transaction in transactions) {
      final int transactionHash = transaction.hashCode;

      if (visitedTransactionHashes.contains(transactionHash)) {
        continue;
      }

      visitedTransactionHashes.add(transactionHash);
      newTransactions.add(transaction);
      _addTransactionToAccount(accountTotals, contact.pubKey, transaction);
    }

    updateUI(newTransactions, accountTotals);
  }
}

void _addTransactionToAccount(Map<String, AccountTotals> accountTotals,
    String accountPubkey, Transaction transaction) {
  if (!accountTotals.containsKey(accountPubkey)) {
    accountTotals[accountPubkey] = AccountTotals();
  }

  accountTotals[accountPubkey]!.transactions.add(transaction);

  if (transaction.amount > 0) {
    accountTotals[accountPubkey]!.totalExpenses += transaction.amount;
  } else {
    accountTotals[accountPubkey]!.totalIncome += transaction.amount;
  }
}

Future<List<Transaction>> getAllTransactionsForAddress(String address) async {
  return <Transaction>[];
}
