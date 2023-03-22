import 'package:flutter/material.dart';

import '../../data/models/cesium_card.dart';
import '../../shared_prefs.dart';

class CardDrawer extends StatelessWidget {
  const CardDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final List<CesiumCard> cards = SharedPreferencesHelper().cesiumCards;

    return Drawer(
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 200,
            child: Center(
              child: Text(
                '', // 'Drawer Header',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                ),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: cards.length,
                itemBuilder: (BuildContext context, int index) {
                  final CesiumCard card = cards[index];
                  return InkWell(
                    onTap: () {
                      // SharedPreferencesHelper().selectCesiumCard(person);
                      Navigator.pop(context);
                    },
                    child: Text(card.pubKey),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
