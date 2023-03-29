import 'package:durt/durt.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../ui_helpers.dart';
import 'card_text_style.dart';

class CreditCardMini extends StatelessWidget {
  const CreditCardMini({super.key, required this.wallet});

  final CesiumWallet wallet;

  @override
  Widget build(BuildContext context) {
    final String pubKey = wallet.pubkey;
    const double cardRadius = 10.0;
    final bool bigDevice = bigScreen(context);
    final double cardPadding = bigDevice ? 26.0 : 16.0;
    return Card(
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cardRadius),
        ),
        child: AspectRatio(
            aspectRatio: 1.58, // Credit cart aspect ratio
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
                    Color(int.parse("${dotenv.env['CARD_COLOR_LEFT']}")),
                    Color(int.parse("${dotenv.env['CARD_COLOR_RIGHT']}")),
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
                              dotenv.env['CARD_TEXT'] ?? tr('g1_wallet'),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.07,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      ),
                      const SizedBox(height: 6.0),
                      Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: cardPadding),
                          child: Row(children: <Widget>[
                            GestureDetector(
                                onTap: () => showTooltip(
                                    context, '', tr('keys_tooltip')),
                                child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text('**** **** ',
                                        style: cardTextStyle(context)))),
                            FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  '${pubKey.substring(0, 4)} ${pubKey.substring(4, 8)}',
                                  style: cardTextStyle(context),
                                ))
                          ])),
                      if (bigDevice) const SizedBox(height: 6.0),
                      const SizedBox(height: 18.0),
                    ]),
              ]),
            )));
  }
}
