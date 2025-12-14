import 'package:flutter/material.dart';

/// Header component showing the balance for the account.
class TransactionsListHeader extends StatelessWidget {
  const TransactionsListHeader({
    super.key,
    required this.pubKey,
    required this.isExternalAccount,
    this.onToggleUD,
  });

  final String pubKey;
  final bool isExternalAccount;
  final ValueChanged<bool>? onToggleUD;

  @override
  Widget build(BuildContext context) {
    // The header is now just a placeholder/spacer
    // The UD toggle button is in the balance panel
    return const SizedBox.shrink();
  }
}
