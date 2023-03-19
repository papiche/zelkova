import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../shared_prefs.dart';
import '../../ui_helpers.dart';

class CreditCard extends StatelessWidget {
  CreditCard({super.key});

  final String publicKey = SharedPreferencesHelper().getPubKey();

  TextStyle cardTextStyle(BuildContext context) => TextStyle(
        fontFamily: 'SourceCodePro',
        // decoration: TextDecoration.underline,
        color: Colors.white,
        fontSize: MediaQuery.of(context).size.width * 0.06,
        fontWeight: FontWeight.bold,
        shadows: <Shadow>[
          Shadow(
            blurRadius: 1,
            color: Colors.black.withOpacity(0.7),
            offset: const Offset(0, 2),
          ),
          Shadow(
            blurRadius: 1,
            color: Colors.white.withOpacity(0.5),
            offset: const Offset(0, -1),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    const double cardRadius = 10.0;
    final double cardPadding =
        MediaQuery.of(context).size.width > smallScreenWidth ? 26.0 : 16.0;

    final String pubKey = SharedPreferencesHelper().getPubKey();
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
                              dotenv.env['CARD_COLOR_TEXT'] ?? tr('g1_wallet'),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.07,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      ),
                      if (MediaQuery.of(context).size.width > smallScreenWidth)
                        const SizedBox(height: 8.0),
                      Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: cardPadding),
                          child: GestureDetector(
                              onTap: () {
                                _showQrDialog(context);
                              },
                              child: SvgPicture.asset(
                                width: MediaQuery.of(context).size.width <
                                        smallScreenWidth
                                    ? 25
                                    : 40,
                                'assets/img/chip.svg',
                              ))),
                      const SizedBox(height: 8.0),
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
                            GestureDetector(
                                onTap: () => copyPublicKeyToClipboard(context),
                                child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      '${pubKey.substring(0, 4)} ${pubKey.substring(4, 8)}',
                                      style: cardTextStyle(context),
                                    )))
                          ])),
                      if (MediaQuery.of(context).size.width > smallScreenWidth)
                        const SizedBox(height: 12.0),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: cardPadding),
                        child: GestureDetector(
                          onTap: () => showTooltip(
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

  void _showQrDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            child: SizedBox(
                height: MediaQuery.of(context).size.width,
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GestureDetector(
                      onTap: () => copyPublicKeyToClipboard(context),
                      child: Column(children: <Widget>[
                        Text(tr('show_qr_to_client')),
                        QrImage(
                          data: publicKey,
                          size: MediaQuery.of(context).size.width * 0.8,
                          gapless: false,
                          foregroundColor: Colors.orange,
                        ),
                      ]),
                    ))));
      },
    );
  }
}
