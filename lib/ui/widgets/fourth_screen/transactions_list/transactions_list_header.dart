import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../data/models/app_cubit.dart';
import '../../../../data/models/multi_wallet_transaction_cubit.dart';
import '../../../../data/models/multi_wallet_transaction_state.dart';
import '../../../../g1/currency.dart';
import '../../../currency_helper.dart';
import '../../../locale_helper.dart';
import '../../../ui_helpers.dart';

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
        final AppCubit appCubit = context.read<AppCubit>();
        final double balance =
        context.read<MultiWalletTransactionCubit>().balance(pubKey);
        final bool isG1 = appCubit.currency == Currency.G1;
        final String currentSymbol = currentCurrencyTrimmed(isG1);
        final NumberFormat currentNumber = currentNumberFormat(
          useSymbol: true,
          isG1: isG1,
          locale: currentLocale(context),
          amount: balance,
        );
        final bool isCurrencyBefore =
        isSymbolPlacementBefore(currentNumber.symbols.CURRENCY_PATTERN);
        return Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Theme
                .of(context)
                .colorScheme
                .primaryContainer,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
          child: Column(
            children: <Widget>[
              Text(
                'Balance',
                style: Theme
                    .of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(
                  color: Theme
                      .of(context)
                      .colorScheme
                      .onPrimaryContainer,
                ),
              ),
              const SizedBox(height: 8),
              Text.rich(
                humanizeAmount(
                  isCurrencyBefore,
                  context,
                  isG1,
                  false,
                  currentSymbol,
                  24.0,
                  balance,
                  appCubit.currentUd,
                ),
                style: Theme
                    .of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(
                  color: Theme
                      .of(context)
                      .colorScheme
                      .onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
