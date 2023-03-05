import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../shared_prefs.dart';
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
        height: 250,
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
                          child: Text(amount,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontFamily: 'LCDMono',
                                color: Colors.white,
                                fontSize: 28,
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: const Offset(1, 1),
                                    blurRadius: 3,
                                    color: Colors.black.withOpacity(0.4),
                                  ),
                                ],
                              )))
                    ])),
            Expanded(
                child: Column(children: <Widget>[
              QrImage(
                data: _getQrUi(SharedPreferencesHelper().getPubKey(), amount),
                size: 160.0,
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
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        style: const TextStyle(
                          fontFamily: 'Roboto Mono',
                          color: Colors.white,
                          fontSize: 14,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: amount.isNotEmpty
                              ? tr('show-qr-to-client-amount')
                              : tr('show-qr-to-client'),
                          hintStyle: const TextStyle(
                            fontFamily: 'Roboto Mono',
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getQrUi(String destinationPublicKey, String amountString) {
    final double amount = double.tryParse(amountString) ?? 0.0;

    String uri;
    if (amount > 0) {
      // there is something like this in other clients?
      uri = 'duniter:key/$destinationPublicKey?amount=$amount';
    } else {
      uri = destinationPublicKey;
    }
    return uri;
  }
}
