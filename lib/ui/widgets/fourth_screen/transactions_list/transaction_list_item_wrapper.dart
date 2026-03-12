import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../data/models/app_cubit.dart';
import '../../../../data/models/transaction.dart';
import '../../../../g1/currency.dart';
import '../../../../shared_prefs_helper.dart';
import '../../../currency_helper.dart';
import '../../../locale_helper.dart';
import '../../../ui_helpers.dart';
import '../transaction_item.dart';

/// Wrapper widget that simplifies TransactionListItem usage by
/// providing default values from context and shared preferences.
class TransactionListItemWrapper extends StatelessWidget {
  const TransactionListItemWrapper({
    super.key,
    required this.transaction,
    required this.pubKey,
    required this.index,
  });

  final Transaction transaction;
  final String pubKey;
  final int index;

  @override
  Widget build(BuildContext context) {
    final AppCubit appCubit = context.read<AppCubit>();
    final bool isExternalAccount = SharedPreferencesHelper().isExternal(pubKey);
    final Currency currency = appCubit.currency;
    final bool isG1 = currency.isG1Like;
    final String currentSymbol = currentCurrencyTrimmedFromEnum(currency);
    final NumberFormat currentNumber = currentNumberFormat(
      useSymbol: true,
      isG1: isG1,
      locale: currentLocale(context),
      amount: transaction.amount,
      currency: currency,
    );
    final bool isCurrencyBefore =
        isSymbolPlacementBefore(currentNumber.symbols.CURRENCY_PATTERN);

    return TransactionListItem(
      transaction: transaction,
      pubKey: pubKey,
      index: index,
      isG1: isG1,
      currency: currency,
      currentUd: appCubit.currentUd,
      currentSymbol: currentSymbol,
      isCurrencyBefore: isCurrencyBefore,
      isExternalAccount: isExternalAccount,
    );
  }
}
