import 'package:flutter/material.dart';

import '../../../shared_prefs_helper.dart';
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
          SharedPreferencesHelper().cesiumCards.length,
          (int index) {
            final int walletSize = SharedPreferencesHelper().cesiumCards.length;
            return Positioned(
              top: 50.0 * index,
              child: SizedBox(
                  height: 200,
                  child: GestureDetector(
                      onTap: () {
                        SharedPreferencesHelper().setCurrentWalletIndex(index);
                      },
                      child: CreditCardMini(
                          card: SharedPreferencesHelper().cards[index],
                          settingsVisible: index == walletSize - 1))),
            );
          },
        ),
        Positioned(
            right: 30,
            bottom: -15,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black45,
                    spreadRadius: 10,
                    blurRadius: 10,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: FloatingActionButton(
                // elevation: 20,
                /* shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(20),
                ), */
                onPressed: () {},
                child: const Icon(Icons.add),
              ),
            ))
      ],
    );
  }
}
