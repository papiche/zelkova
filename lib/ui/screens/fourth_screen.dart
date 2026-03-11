import 'package:flutter/material.dart';

import '../widgets/fourth_screen/transactions_list/transactions_list_widget.dart';

class FourthScreen extends StatefulWidget {
  const FourthScreen({super.key});

  @override
  State<FourthScreen> createState() => _FourthScreenState();
}

class _FourthScreenState extends State<FourthScreen> {
  @override
  Widget build(BuildContext context) {
    return const TransactionsListWidget();
  }
}
