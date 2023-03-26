import 'package:flutter/material.dart';

import '../../data/models/contact.dart';
import '../ui_helpers.dart';

class TransactionContactWidget extends StatelessWidget {
  const TransactionContactWidget(
      {super.key, required this.contact, this.avatarSize = 10.0});

  final Contact contact;
  final double avatarSize;

  @override
  Widget build(BuildContext context) {
    final bool hasName = contact.name?.isNotEmpty ?? false;
    final bool hasNick = contact.nick?.isNotEmpty ?? false;

    return Row(
      children: <Widget>[
        avatar(contact.avatar, avatarSize: avatarSize),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (hasName && hasNick)
                Text('${contact.name} (${contact.nick})',
                    style: Theme.of(context).textTheme.titleMedium)
              else if (hasNick)
                Text(contact.nick!,
                    style: Theme.of(context).textTheme.titleMedium)
              else if (hasName)
                Text(contact.name!,
                    style: Theme.of(context).textTheme.titleMedium)
              else
                Text(contact.pubKey,
                    style: Theme.of(context).textTheme.titleMedium)
            ],
          ),
        ),
      ],
    );
  }
}
