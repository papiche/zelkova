import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../g1/currency.dart';
import 'locale_helper.dart';

String formatKAmountInView(
        {required BuildContext context,
        required double amount,
        required bool isG1,
        required double currentUd,
        required bool useSymbol}) =>
    _formatAmount(
        locale: currentLocale(context),
        amount: convertAmount(isG1, amount, currentUd),
        isG1: isG1,
        useSymbol: useSymbol);

String formatKAmountInViewWithLocale(
        {required String locale,
        required double amount,
        required bool isG1,
        required double currentUd,
        required bool useSymbol}) =>
    _formatAmount(
        locale: locale,
        amount: convertAmount(isG1, amount, currentUd),
        isG1: isG1,
        useSymbol: useSymbol);

double convertAmount(bool isG1, double amount, double currentUd) =>
    isG1 ? amount / 100 : ((amount / 100) / currentUd);

String _formatAmount(
    {required String locale,
    required double amount,
    required bool isG1,
    required bool useSymbol}) {
  return formatAmountWithLocale(
      locale: locale, amount: amount, isG1: isG1, useSymbol: useSymbol);
}

String formatAmountWithLocale(
    {required String locale,
    required double amount,
    required bool isG1,
    required bool useSymbol}) {
  final NumberFormat currencyFormatter =
      currentNumberFormat(isG1: isG1, locale: locale, useSymbol: useSymbol);
  return currencyFormatter.format(amount);
}

NumberFormat currentNumberFormat(
    {required bool useSymbol, required bool isG1, required String locale}) {
  final NumberFormat currencyFormatter = NumberFormat.currency(
    symbol: useSymbol ? currentCurrency(isG1) : '',
    locale: eo(locale),
    decimalDigits: isG1 ? 2 : 3,
  );
  return currencyFormatter;
}

String currentCurrency(bool isG1) {
  return isG1 ? '${Currency.G1.name()} ' : '${Currency.DU.name()} ';
}

String currentCurrencyTrimmed(bool isG1) {
  return currentCurrency(isG1).trim();
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
