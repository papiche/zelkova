import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/models/stored_account.dart';
import '../../../shared_prefs_helper.dart';
import '../../logger.dart';
import '../add_wallet_assistant.dart';
import 'drawer_credit_card.dart';

class CardStack extends StatefulWidget {
  const CardStack({super.key});

  @override
  State<CardStack> createState() => _CardStackState();
}

class _CardStackState extends State<CardStack> {
  int visibleCardIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<SharedPreferencesHelper>(builder: (BuildContext context,
        SharedPreferencesHelper prefsHelper, Widget? child) {
      final List<StoredAccount> cards =
          List<StoredAccount>.from(SharedPreferencesHelper().accounts);
      final int currentIndex =
          SharedPreferencesHelper().getCurrentWalletIndex();
      logger('Current wallet index is $currentIndex of ${cards.length}');
      final StoredAccount currentItem = cards.removeAt(currentIndex);
      cards.add(currentItem);
      final int walletsSize = cards.length;
      return SizedBox(
          height: 200 + ((cards.length - 1) * 45),
          child: Center(
              child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              ...List<Widget>.generate(
                walletsSize,
                (int index) {
                  return Positioned(
                    top: 45.0 * index,
                    child: SizedBox(
                        height: 200,
                        child: DrawerWalletCard(
                            card: cards[index],
                            cardIndex: index,
                            settingsVisible: index == walletsSize - 1)),
                  );
                },
              ),
              Positioned(
                  right: 25,
                  top: -15,
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
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const WalletOptionsDialog();
                            });
                      },
                      child: const Icon(Icons.add),
                    ),
                  ))
            ],
          )));
    });
  }
}
