import 'package:flutter/material.dart';

import '../../../data/models/credit_card_themes.dart';
import '../../ui_helpers.dart';

class CreditCardSelectorItem extends StatelessWidget {
  const CreditCardSelectorItem({super.key, this.name, required this.theme});

  final String? name;
  final CreditCardTheme theme;

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
                          theme.primaryColor,
                          theme.secondaryColor,
                          // card.theme.primaryColor,
                          // card.theme.secondaryColor,
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Stack(children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                            child: Opacity(
                              opacity: 0.2,
                              child: Image.asset('assets/img/gbrevedot_alt.png',
                                  width: 100, height: 100),
                            )),
                        if (name != null)
                          Positioned(
                            bottom: 8,
                            left: 8,
                            child: Text(
                              name!,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                      ]),
                    )))));
  }
}
