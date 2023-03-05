import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../shared_prefs.dart';
import '../../ui_helpers.dart';

class CreditCard extends StatelessWidget {
  CreditCard({super.key});

  final String publicKey = SharedPreferencesHelper().getPubKey();

  @override
  Widget build(BuildContext context) {
    const double cardRadius = 10.0;
    const double cardPadding = 26.0;

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
                gradient: const LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: <Color>[
                    Color(0xFF05112B),
                    Color(0xFF085476),
                  ],
                ),
              ),
              child: Stack(children: <Widget>[
                Padding(
                    padding: const EdgeInsets.fromLTRB(160, 10, 0, 0),
                    child: Opacity(
                        opacity: 0.1,
                        child: Image.asset('assets/img/gbrevedot_alt.png'))),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
                  Padding(
                    padding: const EdgeInsets.all(cardPadding),
                    child: Text(
                      tr('g1_wallet'),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: cardPadding),
                      child: GestureDetector(
                          onTap: () {
                            _showQrDialog(context);
                          },
                          child: SvgPicture.asset(
                            'assets/img/chip.svg',
                          ))),
                  const SizedBox(height: 8.0),
                  GestureDetector(
                    onTap: () => showTooltip(context, '', tr('keys-tooltip')),
                    child: Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: cardPadding),
                        child: Text(
                          '**** **** ${SharedPreferencesHelper().getPubKey().substring(0, 4)} ${SharedPreferencesHelper().getPubKey().substring(4, 8)}',
                          style: TextStyle(
                            fontFamily: 'SourceCodePro',
                            // decoration: TextDecoration.underline,
                            color: Colors.white,
                            fontSize: 22.0,
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
                          ),
                        )),
                  ),
                  const SizedBox(height: 12.0),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: cardPadding),
                    child: GestureDetector(
                      onTap: () =>
                          showTooltip(context, '', tr('card-validity-tooltip')),
                      child: Text(
                        tr('card-validity'),
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  )
                ]),
              ]),
            )));
  }

  void _showQrDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: QrImage(
              data: publicKey,
              size: MediaQuery.of(context).size.width * 0.8,
              gapless: false,
              foregroundColor: Colors.orange,
            ),
          ),
        );
      },
    );
  }
}
