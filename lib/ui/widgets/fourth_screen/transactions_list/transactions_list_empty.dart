import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

/// Empty state component when there are no transactions.
class TransactionsListEmpty extends StatelessWidget {
  const TransactionsListEmpty({
    super.key,
    required this.onRefresh,
    this.isExternalAccount = false,
  });

  final Future<void> Function() onRefresh;
  final bool isExternalAccount;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: <Widget>[
          SliverFillRemaining(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.receipt_long_outlined,
                      size: 64,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      tr(isExternalAccount
                          ? 'no_transactions_simple'
                          : 'no_transactions'),
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
