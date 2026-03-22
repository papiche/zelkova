import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../g1/currency.dart';
import 'locale_helper.dart';

String formatKAmountInView(
        {required BuildContext context,
        required double amount,
        required bool isG1,
        required double currentUd,
        required bool useSymbol,
        Currency? currency,
        bool isBalance = false}) =>
    _formatAmount(
        locale: currentLocale(context),
        amount: convertAmountByCurrency(
            currency ?? (isG1 ? Currency.ZEN : Currency.DU), amount, currentUd,
            isBalance: isBalance),
        currency: currency ?? (isG1 ? Currency.ZEN : Currency.DU),
        useSymbol: useSymbol);

String formatKAmountInViewWithLocale(
        {required String locale,
        required double amount,
        required bool isG1,
        required double currentUd,
        required bool useSymbol,
        Currency? currency}) =>
    _formatAmount(
        locale: locale,
        amount: convertAmountByCurrency(
            currency ?? (isG1 ? Currency.ZEN : Currency.DU), amount, currentUd),
        currency: currency ?? (isG1 ? Currency.ZEN : Currency.DU),
        useSymbol: useSymbol);

/// Legacy conversion (kept for compatibility)
double convertAmount(bool isG1, double amount, double currentUd) =>
    isG1 ? amount / 100 : ((amount / 100) / currentUd);

/// Currency-aware conversion from raw centimes to display value
/// - G1:  centimes / 100
/// - DU:  (centimes / 100) / currentUd
/// - ZEN: (centimes / 100) * 10  (1 ẐEN = 0.1 Ğ1)
/// For balance display: subtract 1 Ğ1 primo TX reserve → ((Ğ1 - 1) * 10)
double convertAmountByCurrency(
    Currency currency, double amount, double currentUd,
    {bool isBalance = false}) {
  switch (currency) {
    case Currency.G1:
      return amount / 100;
    case Currency.DU:
      return (amount / 100) / currentUd;
    case Currency.ZEN:
      final double g1 = amount / 100;
      return isBalance ? (g1 - 1) * 10 : g1 * 10;
  }
}

String _formatAmount(
    {required String locale,
    required double amount,
    required Currency currency,
    required bool useSymbol}) {
  return formatAmountWithLocale(
      locale: locale,
      amount: amount,
      isG1: currency.isG1Like,
      useSymbol: useSymbol,
      currency: currency);
}

String formatAmountWithLocale(
    {required String locale,
    required double amount,
    required bool isG1,
    required bool useSymbol,
    Currency? currency}) {
  final NumberFormat currencyFormatter = currentNumberFormat(
      isG1: isG1,
      locale: locale,
      useSymbol: useSymbol,
      amount: amount,
      currency: currency);
  return currencyFormatter.format(amount);
}

NumberFormat currentNumberFormat({
  required bool useSymbol,
  required bool isG1,
  required String locale,
  required double amount,
  Currency? currency,
}) {
  // ZEN: 1 decimal (like G1 but ×10 scale)
  // G1: max 2 decimals, min 1
  // DU: max 3 decimals, min 0
  final int maxDecimals = isG1 ? 2 : 3;
  final int minDecimals = isG1 ? 1 : 0;

  // Start from the max decimals and trim trailing zeros
  int decimalsToShow = maxDecimals;
  String asString = amount.toStringAsFixed(maxDecimals);
  while (decimalsToShow > minDecimals && asString.endsWith('0')) {
    decimalsToShow--;
    asString = amount.toStringAsFixed(decimalsToShow);
  }

  // Build the currency formatter with the correct locale and symbol
  return NumberFormat.currency(
    symbol: useSymbol ? currentCurrencyFromEnum(currency ?? (isG1 ? Currency.ZEN : Currency.DU)) : '',
    locale: eo(locale), // fallback for Esperanto
    decimalDigits: decimalsToShow,
  );
}

String currentCurrency(bool isG1) {
  return isG1 ? '${Currency.ZEN.name()} ' : '${Currency.DU.name()} ';
}

String currentCurrencyFromEnum(Currency currency) {
  return '${currency.name()} ';
}

String currentCurrencyTrimmed(bool isG1) {
  return currentCurrency(isG1).trim();
}

String currentCurrencyTrimmedFromEnum(Currency currency) {
  return currency.name();
}

// NumberFormat does not work with esperanto nowadays, so we use
// this fallback
// https://en.wikipedia.org/wiki/Decimal_separator
// The three most spoken international auxiliary languages, Ido, Esperanto, and
// Interlingua, all use the comma as the decimal separator.
String eo(String locale) => locale == 'eo' ? 'es' : locale;

double parseToDoubleLocalized(
        {required String locale, required String number}) =>
    NumberFormat.decimalPattern(eo(locale)).parse(number).toDouble();

String localizeNumber(BuildContext context, double amount) =>
    NumberFormat.decimalPattern(eo(currentLocale(context))).format(amount);
