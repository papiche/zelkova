import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/app_cubit.dart';
import '../widgets/bottom_widget.dart';
import '../widgets/first_screen/credit_card.dart';
import '../widgets/first_screen/pay_contact_search_button.dart';
import '../widgets/header.dart';
import 'pay_form.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  // final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!context.read<AppCubit>().isWarningViewed) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(tr('demo_desc')),
            action: SnackBarAction(
              label: 'OK',
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                context.read<AppCubit>().warningViewed();
              },
            ),
          ),
        );
      }
    });
    return Material(
        color: Theme.of(context).colorScheme.background,
        child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            //physics: const AlwaysScrollableScrollPhysics(),
            //controller: _controller,
            // shrinkWrap: true,
            children: <Widget>[
              const Header(text: 'credit_card_title'),
              CreditCard(),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Divider(
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(.4),
                ),
              ),
              const SizedBox(height: 10),
              const PayContactSearchButton(),
              const SizedBox(height: 10),
              const PayForm(),
              const BottomWidget()
            ]));
  }
}
