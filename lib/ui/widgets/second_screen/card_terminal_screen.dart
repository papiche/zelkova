import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../g1/g1_helper.dart';
import '../../../shared_prefs.dart';
import '../../ui_helpers.dart';
import 'card_terminal_status.dart';

class CardTerminalScreen extends StatelessWidget {
  const CardTerminalScreen({super.key, required this.amount});

  final String amount;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        width: double.infinity,
        height: smallScreen(context) ? 212 : 252,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              Colors.blueGrey,
              Colors.white,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      Color(0xFF3B3B3B),
                      Color(0xFF232323),
                    ],
                  ),
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const ConnectivityWidgetWrapper(
                          offlineWidget: CardTerminalStatus(online: false),
                          child: CardTerminalStatus(online: true)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          amount,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontFamily: 'LCDMono',
                            color: Colors.white,
                            fontSize: amount.length < 5
                                ? 28
                                : amount.length < 10
                                    ? 20
                                    : amount.length < 15
                                        ? 14
                                        : 12,
                            shadows: <Shadow>[
                              Shadow(
                                offset: const Offset(1, 1),
                                blurRadius: 3,
                                color: Colors.black.withOpacity(0.4),
                              ),
                            ],
                            //softWrap: true, // Agrega esta línea para permitir que el texto se envuelva a la siguiente línea
                          ),
                        ),
                      ),
                    ])),
            Expanded(
                child: Column(children: <Widget>[
              if (!amount.contains('+'))
                QrImage(
                    data: getQrUri(
                        pubKey: SharedPreferencesHelper().getPubKey(),
                        locale: context.locale.toLanguageTag(),
                        amount: amount),
                    size: smallScreen(context) ? 100.0 : 140.0
                    //: (smallScreen(context) ? 120.0 : 160.0),
                    )
            ])),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    Color(0xFF232323),
                    Color(0xFF3B3B3B),
                  ],
                ),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Text.rich(
                          TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: amount.isNotEmpty
                                    ? tr('show_qr_to_client_amount')
                                    : tr('show_qr_to_client'),
                                style: TextStyle(
                                  fontFamily: 'Roboto Mono',
                                  color: Colors.grey,
                                  fontSize: smallScreen(context) ? 11 : 14,
                                ),
                              ),
                            ],
                          ),
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
