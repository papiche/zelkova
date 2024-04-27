import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../g1/g1_helper.dart';
import '../../../shared_prefs_helper.dart';
import '../../tutorial_keys.dart';
import '../../ui_helpers.dart';
import '../connectivity_widget_wrapper_wrapper.dart';
import 'card_terminal_status.dart';

class CardTerminalScreen extends StatelessWidget {
  const CardTerminalScreen({super.key, required this.amount});

  final String amount;

  @override
  Widget build(BuildContext context) {
    final String duniterUri = getQrUri(
        pubKey: SharedPreferencesHelper().getPubKey(),
        locale: context.locale.toLanguageTag(),
        amount: amount);
    final String duniterUriNoSha = getQrUri(
        pubKey: extractPublicKey(SharedPreferencesHelper().getPubKey()),
        locale: context.locale.toLanguageTag(),
        amount: amount);
    return Card(
      key: receiveQrKey,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        width: double.infinity,
        height: smallScreen(context) ? 200 : 252,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              Colors.white54,
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
                      ConnectivityWidgetWrapperWrapper(
                          offlineWidget: CardTerminalStatus(
                              online: false, uri: duniterUriNoSha),
                          child: CardTerminalStatus(
                              online: true, uri: duniterUriNoSha)),
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
                          ),
                        ),
                      ),
                    ])),
            Expanded(
                child: Column(children: <Widget>[
              if (!amount.contains('+'))
                Expanded(
                    child: GestureDetector(
                  onTap: () => copyPublicKeyToClipboard(context, duniterUri),
                  // Issue #69
                  // With noSha does not work neither
                  child: QrImageView(data: duniterUri),
                  //   size: smallScreen(context) ? 95.0 : 140.0)
                ))
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
                            horizontal: 10, vertical: 6),
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
                                  fontSize: smallScreen(context) ? 12 : 14,
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
