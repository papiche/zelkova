import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../data/models/cesium_card.dart';
import '../../../data/models/credit_card_theme_selector.dart';
import '../../../data/models/credit_card_themes.dart';
import '../../ui_helpers.dart';
import 'card_name_editable.dart';
import 'card_text_style.dart';

class CreditCardMini extends StatefulWidget {
  const CreditCardMini({super.key, required this.card});

  final CesiumCard card;

  @override
  State<CreditCardMini> createState() => _CreditCardMiniState();
}

class _CreditCardMiniState extends State<CreditCardMini> {
  bool _showSettingsIcon = false;

  void _showThemeSelector(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(tr('card_theme_select')),
          content: SizedBox(
              width: double.maxFinite,
              child: CardThemeSelector(card: widget.card)),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const double cardRadius = 10.0;
    final bool bigDevice = bigScreen(context);
    final double cardInternalElPadding = bigDevice ? 5 : 6.0;
    final int themeIndex = Random().nextInt(10);
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Card(
            elevation: 8.0,
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
                        Positioned(
                          top: -10,
                          right: -10,
                          child: Visibility(
                            visible: true,
                            child: FloatingActionButton(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              onPressed: () => _showThemeSelector(context),
                              child: const Icon(Icons.settings,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(120, 10, 0, 0),
                            child: Opacity(
                              opacity: 0.2,
                              child: Image.asset('assets/img/gbrevedot_alt.png',
                                  width: 100, height: 100),
                            )),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              if (widget.card.name.isNotEmpty)
                                Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: cardInternalElPadding,
                                        vertical: cardInternalElPadding),
                                    child: Row(children: <Widget>[
                                      Expanded(
                                          child: CardNameText(
                                              currentText: widget.card.name,
                                              onTap: () {})),
                                    ])),
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: cardInternalElPadding,
                                      vertical: cardInternalElPadding),
                                  child: Row(children: <Widget>[
                                    GestureDetector(
                                        onTap: () => showQrDialog(
                                            context: context,
                                            publicKey: widget.card.pubKey),
                                        child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              '$themeIndex ${widget.card.pubKey.substring(0, 4)} ${widget.card.pubKey.substring(4, 8)}',
                                              style: cardTextStyle(context,
                                                  fontSize: 16),
                                            ))),
                                  ])),
                              if (bigDevice) const SizedBox(height: 6.0),
                              const SizedBox(height: 8.0),
                            ]),
                      ]),
                    )))));
  }
}
