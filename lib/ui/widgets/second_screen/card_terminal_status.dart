import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CardTerminalStatus extends StatelessWidget {
  const CardTerminalStatus(
      {super.key, required this.online, required this.uri});

  final bool online;
  final String uri;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Tooltip(
              message: online ? tr('online_terminal') : tr('offline_terminal'),
              child: Icon(
                Icons.payment,
                color: online ? Colors.green : Colors.red,
              )),
        ],
      ),
    );
  }
}
