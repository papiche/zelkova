import 'package:flutter/material.dart';

import '../../../data/models/credit_card_themes.dart';
import '../../ui_helpers.dart';
import 'card_text_style.dart';

class CreditCardThemeItem extends StatelessWidget {
  const CreditCardThemeItem({super.key, required this.themeIndex});

  final int themeIndex;

  @override
  Widget build(BuildContext context) {
    const double cardRadius = 10.0;
    return Padding(
        padding: const EdgeInsets.all(1),
        child: Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(cardRadius),
            ),
            child: AspectRatio(
                aspectRatio: cardAspectRatio, // Credit cart aspect ratio
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(cardRadius),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.grey[400]!,
                          blurRadius: 3.0,
                          spreadRadius: 1.0,
                        )
                      ],
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: <Color>[
                          CreditCardThemes.themes[themeIndex].primaryColor,
                          CreditCardThemes.themes[themeIndex].secondaryColor,
                          // card.theme.primaryColor,
                          // card.theme.secondaryColor,
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Stack(children: <Widget>[
                        if (inDevelopment)
                          Text('${themeIndex + 1}',
                              style: cardTextStyle(context, fontSize: 14)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                            child: Opacity(
                              opacity: 0.2,
                              child: Image.asset('assets/img/gbrevedot_alt.png',
                                  width: 100, height: 100),
                            )),
                      ]),
                    )))));
  }
}
