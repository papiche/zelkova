import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../data/models/cesium_card.dart';
import '../../../data/models/credit_card_theme_selector.dart';
import '../../../data/models/credit_card_themes.dart';
import '../../../g1/g1_helper.dart';
import '../../../shared_prefs_helper.dart';
import '../../logger.dart';
import '../../ui_helpers.dart';
import 'card_name_editable.dart';
import 'card_text_style.dart';

class CreditCardMini extends StatelessWidget {
  const CreditCardMini(
      {super.key,
      required this.card,
      required this.cardIndex,
      required this.settingsVisible});

  final CesiumCard card;
  final bool settingsVisible;
  final int cardIndex;

  void _showThemeSelector(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(tr('card_theme_select')),
          content: SizedBox(
              width: double.maxFinite,
              child: CardThemeSelector(
                  card: card,
                  onTap: (CreditCardTheme theme) =>
                      SharedPreferencesHelper().setTheme(theme: theme))),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const double cardRadius = 10.0;
    final bool bigDevice = bigScreen(context);
    final double cardInternalElPadding = bigDevice ? 5 : 6.0;
    return Padding(
        padding: const EdgeInsets.all(10),
        child: settingsVisible
            ? _buildCard(cardRadius, context, cardInternalElPadding, bigDevice)
            : GestureDetector(
                onTap: () => onCardTap(context),
                child: _buildCard(
                    cardRadius, context, cardInternalElPadding, bigDevice)));
  }

  Card _buildCard(double cardRadius, BuildContext context,
      double cardInternalElPadding, bool bigDevice) {
    return Card(
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cardRadius),
        ),
        child: AspectRatio(
            aspectRatio: cardAspectRatio,
            // Credit cart aspect ratio
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
                      card.theme.primaryColor,
                      card.theme.secondaryColor
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Stack(children: <Widget>[
                    // if (!SharedPreferencesHelper().isG1nkgoCard())
                    Positioned(
                      top: 60,
                      right: 0,
                      child: Visibility(
                        visible: settingsVisible,
                        child: FloatingActionButton(
                          backgroundColor: Colors.transparent,
                          elevation: 1,
                          onPressed: () {
                            showDialog<bool>(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(tr('please_confirm_delete')),
                                    content: Text(tr(SharedPreferencesHelper()
                                            .isG1nkgoCard()
                                        ? 'please_confirm_delete_desc_g1nkgo'
                                        : 'please_confirm_delete_desc')),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(false),
                                        child: Text(tr('cancel')),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          if (SharedPreferencesHelper()
                                              .isG1nkgoCard()) {}
                                          SharedPreferencesHelper()
                                              .removeCesiumCard();
                                          SharedPreferencesHelper()
                                              .selectCurrentWalletIndex(0);
                                          Navigator.pop(context);
                                        },
                                        child: Text(tr('accept')),
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Visibility(
                        visible: settingsVisible,
                        child: FloatingActionButton(
                          backgroundColor: Colors.transparent,
                          elevation: 1,
                          onPressed: () => _showThemeSelector(context),
                          child:
                              const Icon(Icons.settings, color: Colors.white),
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
                        children: <Widget>[
                          if (card.name.isNotEmpty)
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: cardInternalElPadding,
                                    vertical: cardInternalElPadding),
                                child: Row(children: <Widget>[
                                  Expanded(
                                    child: CardNameText(
                                        currentText: card.name,
                                        onTap: null,
                                        isGinkgoCard: SharedPreferencesHelper()
                                            .isG1nkgoCard(card)),
                                  ),
                                ])),
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: cardInternalElPadding,
                                  vertical: cardInternalElPadding),
                              child: Row(children: <Widget>[
                                FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      simplifyPubKey(
                                          extractPublicKey(card.pubKey)),
                                      style:
                                          cardTextStyle(context, fontSize: 16),
                                    )),
                              ])),
                          if (bigDevice) const SizedBox(height: 6.0),
                          const SizedBox(height: 8.0),
                        ]),
                  ]),
                ))));
  }

  void onCardTap(BuildContext context) {
    logger("Card ${card.pubKey} '${card.name}' was tapped!");
    SharedPreferencesHelper().selectCurrentWallet(card);
    Navigator.pop(context);
  }
}
