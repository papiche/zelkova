import 'package:flutter/material.dart';

import '../widgets/fourth_screen/transaction_page.dart';

class FourthScreen extends StatelessWidget {
  const FourthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Theme.of(context).colorScheme.background,
        child: const TransactionsAndBalanceWidget());
  }
}
