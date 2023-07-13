import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';

import '../../nfc_helper.dart';
import '../../ui_helpers.dart';

class CardTerminalStatus extends StatelessWidget {
  const CardTerminalStatus(
      {super.key, required this.online, required this.uri});

  final bool online;
  final String uri;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<NFCAvailability>(
        future: FlutterNfcKit.nfcAvailability,
        builder:
            (BuildContext context, AsyncSnapshot<NFCAvailability> snapshot) {
          final bool nft = hasNft(snapshot);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Tooltip(
                    message:
                        online ? tr('online_terminal') : tr('offline_terminal'),
                    child: Icon(
                      Icons.payment,
                      color: online ? Colors.green : Colors.red,
                    )),
                if (nft || inDevelopment)
                  Tooltip(
                      message: tr('pay_with_nfc_tooltip'),
                      child: GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(tr('pay_with_nfc_tooltip'))));
                            writeNfcUrl(uri);
                          },
                          child: Icon(
                            Icons.nfc,
                            color: nft ? Colors.green : Colors.red,
                          ))),
              ],
            ),
          );
        });
  }
}
