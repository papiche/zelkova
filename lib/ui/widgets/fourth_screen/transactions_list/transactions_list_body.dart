import 'package:flutter/material.dart';
import '../../../../data/models/transaction.dart';
import 'transaction_list_item_wrapper.dart';

/// Body component that renders the list of transactions.
/// Handles both pending and confirmed transactions.
class TransactionsListBody extends StatelessWidget {
  const TransactionsListBody({
    super.key,
    required this.scrollController,
    required this.transactions,
    required this.pendingTransactions,
    required this.isLoadingMore,
    required this.hasMorePages,
    required this.pubKey,
    this.isScrollEnabled = true,
  });

  final ScrollController scrollController;
  final List<Transaction> transactions;
  final List<Transaction> pendingTransactions;
  final bool isLoadingMore;
  final bool hasMorePages;
  final String pubKey;
  final bool isScrollEnabled;

  @override
  Widget build(BuildContext context) {
    final int pendingCount = pendingTransactions.length;
    final int totalCount = pendingCount + transactions.length;
    return ListView.builder(
      controller: scrollController,
      physics: isScrollEnabled
          ? const AlwaysScrollableScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      itemCount: totalCount + (isLoadingMore ? 1 : 0),
      itemBuilder: (BuildContext context, int index) {
        // Loading indicator at the end
        if (index == totalCount) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (index < pendingCount) {
          return TransactionListItemWrapper(
            transaction: pendingTransactions[index],
            pubKey: pubKey,
            index: index,
            key: ValueKey<String>(
                'pending_${pendingTransactions[index].time
                    .millisecondsSinceEpoch}'),
          );
        }

        final int transactionIndex = index - pendingCount;
        return TransactionListItemWrapper(
          transaction: transactions[transactionIndex],
          pubKey: pubKey,
          index: index,
          key: ValueKey<String>(
              'tx_${transactions[transactionIndex].time
                  .millisecondsSinceEpoch}'),
        );
      },
    );
  }
}

