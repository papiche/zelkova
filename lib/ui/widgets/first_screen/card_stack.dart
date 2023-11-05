import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/models/cesium_card.dart';
import '../../../shared_prefs_helper.dart';
import '../../logger.dart';
import '../fifth_screen/import_dialog.dart';
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
    return Consumer<SharedPreferencesHelper>(builder: (BuildContext context,
        SharedPreferencesHelper prefsHelper, Widget? child) {
      final List<CesiumCard> cards =
          List<CesiumCard>.from(SharedPreferencesHelper().cesiumCards);
      final int currentIndex =
          SharedPreferencesHelper().getCurrentWalletIndex();
      logger('Current wallet index is $currentIndex of ${cards.length}');
      final CesiumCard currentItem = cards.removeAt(currentIndex);
      cards.add(currentItem);
      final int walletsSize = cards.length;
      return Stack(
        alignment: Alignment.center,
        children: <Widget>[
          ...List<Widget>.generate(
            walletsSize,
            (int index) {
              return Positioned(
                top: 50.0 * index,
                child: SizedBox(
                    height: 200,
                    child: CreditCardMini(
                        card: cards[index],
                        cardIndex: index,
                        settingsVisible: index == walletsSize - 1)),
              );
            },
          ),
          Positioned(
              left: 30,
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
                  onPressed: () {
                    showSelectImportMethodDialog(context, 0);
                  },
                  child: const Icon(Icons.add),
                ),
              ))
        ],
      );
    });
  }
}
