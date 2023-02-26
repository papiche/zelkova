import 'package:flutter/material.dart';

import '../widgets/first_screen/credit_card.dart';
import '../widgets/first_screen/pay_contact_search_bar.dart';
import '../widgets/header.dart';
import 'pay_form.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.background,
      child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          physics: const BouncingScrollPhysics(),
          children: <Widget>[
            const Header(text: 'credit_card_title'),
            const CreditCard(),
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
