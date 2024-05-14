import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../g1/g1_helper.dart';
import '../../../shared_prefs_helper.dart';
import '../../tutorial_keys.dart';
import '../../ui_helpers.dart';
import 'card_name_editable.dart';
import 'card_text_style.dart';

class CreditCard extends StatelessWidget {
  const CreditCard(
      {super.key,
      required this.publicKey,
      required this.cardName,
      required this.isG1nkgoCard});

  final String publicKey;
  final String cardName;
  final bool isG1nkgoCard;

  @override
  Widget build(BuildContext context) {
    const double cardRadius = 10.0;
    final bool bigDevice = bigScreen(context);
    final double cardPadding = bigDevice ? 26.0 : 16.0;

    return Card(
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
                    blurRadius: 10.0,
                    spreadRadius: 1.0,
                  )
                ],
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: <Color>[
                    SharedPreferencesHelper().getTheme().primaryColor,
                    SharedPreferencesHelper().getTheme().secondaryColor
                  ],
                ),
              ),
              child: Stack(children: <Widget>[
                Padding(
                    padding: const EdgeInsets.fromLTRB(160, 10, 0, 0),
                    child: Opacity(
                        opacity: 0.1,
                        child: Image.asset('assets/img/gbrevedot_alt.png'))),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(cardPadding),
                        child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              tr('g1_wallet'),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.07,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      ),
                      Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: cardPadding),
                          child: Row(children: <Widget>[
                            GestureDetector(
                                onTap: () {
                                  showQrDialog(
                                      context: context, publicKey: publicKey);
                                },
                                child: SvgPicture.asset(
                                  width: MediaQuery.of(context).size.width <
                                          smallScreenWidth
                                      ? 25
                                      : 40,
                                  'assets/img/chip.svg',
                                )),
                            const SizedBox(width: 10.0),
                            Expanded(
                                child: CardNameEditable(
                              publicKey: publicKey,
                              cardName: cardName,
                              isG1nkgoCard: isG1nkgoCard,
                              defValue:
                                  isG1nkgoCard ? tr('your_name_here') : '',
                            )),
                          ])),
                      const SizedBox(height: 6.0),
                      Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: cardPadding),
                          child: Row(children: <Widget>[
                            GestureDetector(
                                onTap: () => showQrDialog(
                                    context: context, publicKey: publicKey),
                                child: FittedBox(
                                    key: creditCardPubKey,
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      simplifyPubKey(
                                          extractPublicKey(publicKey)),
                                      style: cardTextStyle(context),
                                    ))),
                            GestureDetector(
                                onTap: () => showAlertDialog(
                                    context, '', tr('keys_tooltip')),
                                child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(' **** ****',
                                        style: cardTextStyle(context)))),
                          ])),
                      if (bigDevice) const SizedBox(height: 6.0),
                      if (bigDevice)
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: cardPadding),
                          child: GestureDetector(
                            onTap: () => showAlertDialog(
                                context, '', tr('card_validity_tooltip')),
                            child: Text(
                              tr('card_validity'),
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        ),
                      const SizedBox(height: 18.0),
                    ]),
              ]),
            )));
  }
}
