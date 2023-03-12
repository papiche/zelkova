import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../widgets/first_screen/credit_card.dart';
import '../widgets/first_screen/pay_contact_search_widget.dart';
import '../widgets/header.dart';
import 'pay_form.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(tr('demo-desc'))));
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
