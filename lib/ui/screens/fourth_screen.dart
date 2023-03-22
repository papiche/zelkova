import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../widgets/card_drawer.dart';
import '../widgets/fourth_screen/transaction_page.dart';

class FourthScreen extends StatelessWidget {
  const FourthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(tr('transactions'))),
        drawer: const CardDrawer(),
        body: const TransactionsAndBalanceWidget());
  }
}
