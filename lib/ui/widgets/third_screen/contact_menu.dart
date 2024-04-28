import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../data/models/contact.dart';
import '../../../data/models/contact_cubit.dart';

class ContactMenu extends StatelessWidget {
  const ContactMenu(
      {super.key,
      required this.contact,
      required this.onSent,
      required this.onCopy,
      required this.onDelete,
      required this.onEdit,
      this.parent});

  final VoidCallback onEdit;
  final VoidCallback onSent;
  final VoidCallback onCopy;
  final VoidCallback onDelete;
  final Contact contact;
  final Widget? parent;

  @override
  Widget build(BuildContext context) {
    final bool isContact =
        context.read<ContactsCubit>().isContact(contact.pubKey);

    return MenuAnchor(
        builder:
            (BuildContext context, MenuController controller, Widget? child) {
          return parent != null
              ? GestureDetector(child: parent, onTap: () => onTap(controller))
              : IconButton(
                  onPressed: () => onTap(controller),
                  icon: const Icon(Icons.more_vert),
                  // tooltip: tr('Show menu'),
                );
        },
        menuChildren: <Widget>[
          if (isContact)
            MenuItemButton(
              leadingIcon: const Icon(Symbols.person_edit),
              onPressed: onEdit,
              child: Text(tr('form_contact_title')),
            ),
          MenuItemButton(
            leadingIcon: const Icon(Icons.list_alt),
            onPressed: () {},
            child: Text(tr('account_info')),
          ),
          const Divider(),
          MenuItemButton(
            leadingIcon: const Icon(Icons.copy),
            onPressed: onCopy,
            child: Text(tr('copy_contact_key')),
          ),
          if (isContact)
            MenuItemButton(
              leadingIcon: const Icon(Icons.delete),
              onPressed: onDelete,
              child: Text(tr('delete_contact')),
            ),
        ]);
  }

  void onTap(MenuController controller) {
    if (controller.isOpen) {
      controller.close();
    } else {
      controller.open();
    }
  }
}
