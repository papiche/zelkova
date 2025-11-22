import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/multi_wallet_transaction_cubit.dart';
import '../../../../data/models/multi_wallet_transaction_state.dart';
import '../../balance_widget.dart';

/// Header component showing the balance for the account.
class TransactionsListHeader extends StatelessWidget {
  const TransactionsListHeader({
    super.key,
    required this.pubKey,
    required this.isExternalAccount,
  });

  final String pubKey;
  final bool isExternalAccount;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MultiWalletTransactionCubit,
        MultiWalletTransactionState>(
      builder: (BuildContext context, MultiWalletTransactionState state) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              BalanceWidget(pubKey: pubKey, small: false),
            ],
          ),
        );
      },
    );
  }
}
