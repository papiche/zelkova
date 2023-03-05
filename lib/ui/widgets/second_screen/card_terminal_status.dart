import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CardTerminalStatus extends StatelessWidget {
  const CardTerminalStatus({super.key, required this.online});

  final bool online;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.payment,
            color: online ? Colors.green : Colors.red,
          ),
          const SizedBox(width: 8),
          Text(online ? tr('online-terminal') : tr('offline-terminal'),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto Mono',
                fontSize: 18,
              )),
        ],
      ),
    );
  }
}
