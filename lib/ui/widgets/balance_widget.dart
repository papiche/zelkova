import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/app_cubit.dart';
import '../../data/models/multi_wallet_transaction_cubit.dart';
import '../../g1/currency.dart';
import '../currency_helper.dart';
import '../locale_helper.dart';
import '../ui_helpers.dart';

class BalanceWidget extends StatelessWidget {
  const BalanceWidget({super.key, required this.pubKey, required this.small});

  final String pubKey;
  final bool small;

  @override
  Widget build(BuildContext context) {
    final AppCubit appCubit = context.read<AppCubit>();
    final double balanceFontSize = small ? 18 : 36;
    final bool isG1 = appCubit.currency == Currency.G1;
    final double currentUd = appCubit.currentUd;
    final String currentSymbol = currentCurrencyTrimmed(isG1);
    final double balance =
        context.read<MultiWalletTransactionCubit>().balance(pubKey);
    final NumberFormat currentNumber = currentNumberFormat(
        useSymbol: true,
        isG1: isG1,
        locale: currentLocale(context),
        amount: balance);
    final bool isCurrencyBefore =
        isSymbolPlacementBefore(currentNumber.symbols.CURRENCY_PATTERN);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Center(
          child: Text.rich(humanizeAmount(isCurrencyBefore, context, isG1,
              small, currentSymbol, balanceFontSize, balance, currentUd))),
    );
  }
}
