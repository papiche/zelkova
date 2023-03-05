import 'package:another_flushbar/flushbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../widgets/first_screen/credit_card.dart';
import '../widgets/first_screen/pay_contact_search_bar.dart';
import '../widgets/header.dart';
import 'pay_form.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  bool _showFlushbar = true;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // ignore: always_specify_types
      if (_showFlushbar)
        Flushbar<void>(
          message: tr('demo-title'),
          title: tr('demo-desc'),
          duration: const Duration(seconds: 4),
          flushbarPosition: FlushbarPosition.TOP,
          onStatusChanged: (FlushbarStatus? status) {
            if (status == FlushbarStatus.DISMISSED) {
              setState(() {
                _showFlushbar = false;
              });
            }
          },
        ).show(context);
    });
    return Material(
      color: Theme.of(context).colorScheme.background,
      child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          physics: const BouncingScrollPhysics(),
          children: <Widget>[
            const Header(text: 'credit_card_title'),
            CreditCard(),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Divider(
                color:
                    Theme.of(context).colorScheme.onBackground.withOpacity(.4),
              ),
            ),
            const SizedBox(height: 10),
            const PayContactSearchWidget(),
            const SizedBox(height: 10),
            const PayForm(),
          ]),
    );
  }
}
