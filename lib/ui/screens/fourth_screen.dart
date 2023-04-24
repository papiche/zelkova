import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/bottom_nav_cubit.dart';
import '../tutorial.dart';
import '../widgets/fourth_screen/fourth_tutorial.dart';
import '../widgets/fourth_screen/transaction_page.dart';

class FourthScreen extends StatefulWidget {
  const FourthScreen({super.key});

  @override
  State<FourthScreen> createState() => _FourthScreenState();
}

class _FourthScreenState extends State<FourthScreen> {
  late Tutorial tutorial;

  @override
  void initState() {
    super.initState();
    if (context.read<BottomNavCubit>().state == 3) {
      tutorial = FourthTutorial(context);
      Future<void>.delayed(Duration.zero, () => tutorial.showTutorial());
    }
  }

  @override
  Widget build(BuildContext context) {
    return const TransactionsAndBalanceWidget();
  }
}
