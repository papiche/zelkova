import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../shared_prefs.dart';
import '../../ui_helpers.dart';
import 'card_name_editable.dart';
import 'card_text_style.dart';

class CreditCardMini extends StatelessWidget {
  const CreditCardMini({super.key, required this.pubKey});

  final String pubKey;

  @override
  Widget build(BuildContext context) {
    const double cardRadius = 10.0;
    final bool bigDevice = bigScreen(context);
    final double cardInternalElPadding = bigDevice ? 5 : 6.0;
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Card(
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
                          blurRadius: 3.0,
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
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Stack(children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.fromLTRB(120, 10, 0, 0),
                            child: Opacity(
                              opacity: 0.1,
                              child: Image.asset('assets/img/gbrevedot_alt.png',
                                  width: 100, height: 100),
                            )),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: cardInternalElPadding,
                                      vertical: cardInternalElPadding),
                                  child: Row(children: <Widget>[
                                    Expanded(
                                        child: CardNameText(
                                      currentText:
                                          SharedPreferencesHelper().getName(),
                                      onTap: () {},
                                    )),
                                  ])),
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: cardInternalElPadding,
                                      vertical: cardInternalElPadding),
                                  child: Row(children: <Widget>[
                                    GestureDetector(
                                        onTap: () => showQrDialog(
                                            context: context,
                                            publicKey: pubKey),
                                        child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              '${pubKey.substring(0, 4)} ${pubKey.substring(4, 8)}',
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
