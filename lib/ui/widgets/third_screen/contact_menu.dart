import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../data/models/contact.dart';

class ContactMenu extends StatelessWidget {
  const ContactMenu(
      {super.key,
      required this.contact,
      required this.onSent,
      required this.onCopy,
      required this.onDelete});

  final VoidCallback onSent;
  final VoidCallback onCopy;
  final VoidCallback onDelete;
  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
        builder:
            (BuildContext context, MenuController controller, Widget? child) {
          return IconButton(
            onPressed: () {
              if (controller.isOpen) {
                controller.close();
              } else {
                controller.open();
              }
            },
            icon: const Icon(Icons.more_vert),
            // tooltip: tr('Show menu'),
          );
        },
        menuChildren: <Widget>[
          MenuItemButton(
            leadingIcon: const Icon(Icons.send),
            onPressed: onSent,
            child: Text(tr('send_g1')),
          ),
          MenuItemButton(
            leadingIcon: const Icon(Icons.copy),
            onPressed: onCopy,
            child: Text(tr('copy_contact_key')),
          ),
          MenuItemButton(
            leadingIcon: const Icon(Icons.delete),
            onPressed: onDelete,
            child: Text(tr('delete_contact')),
          ),
        ]);
  }
}
