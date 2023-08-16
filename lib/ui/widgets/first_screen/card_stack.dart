import 'package:flutter/material.dart';

import '../../../shared_prefs.dart';
import 'credit_card_mini.dart';

class CardStack extends StatefulWidget {
  const CardStack({super.key});

  @override
  State<CardStack> createState() => _CardStackState();
}

class _CardStackState extends State<CardStack> {
  int visibleCardIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        ...List<Widget>.generate(
          1,
          (int index) => Positioned(
            top: 50.0 * index,
            child: SizedBox(
                height: 200,
                child: CreditCardMini(
                    pubKey: SharedPreferencesHelper().getPubKey())),
          ),
        ),
        Positioned(
          right: 30,
          bottom: -13,
          child: FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.add),
          ),
        )
      ],
    );
  }
}
