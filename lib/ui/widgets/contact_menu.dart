import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../data/models/contact.dart';
import '../../data/models/contact_cubit.dart';
import '../../shared_prefs_helper.dart';
import '../ui_helpers.dart';
import 'contact_page.dart';
import 'contacts_actions.dart';

class ContactMenu extends StatelessWidget {
  const ContactMenu(
      {super.key,
      required this.contact,
      required this.onSent,
      required this.onCopy,
      required this.onDelete,
      required this.onEdit,
      this.parent,
      this.disable = false});

  final VoidCallback onEdit;
  final VoidCallback onSent;
  final VoidCallback onCopy;
  final VoidCallback onDelete;
  final Contact contact;
  final Widget? parent;
  final bool disable;

  @override
  Widget build(BuildContext context) {
    final bool isContact =
        context.read<ContactsCubit>().isContact(contact.pubKey);
    final String myPubKey = SharedPreferencesHelper().getPubKey();
    final bool me = isMe(contact, myPubKey);
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
          if (!me)
            MenuItemButton(
              leadingIcon: const Icon(Icons.list_alt),
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ContactPage(contact: contact);
                  },
                );
              },
              child: Text(tr('account_info')),
            ),
          if (!me)
            MenuItemButton(
              leadingIcon: const Icon(Icons.send),
              onPressed: () => onSent(),
              child: Text(tr('send_g1')),
            ),
          if (!isContact && !me)
            MenuItemButton(
              leadingIcon: const Icon(Symbols.person_add),
              onPressed: () =>
                  addContact(context.read<ContactsCubit>(), contact, context),
              child: Text(tr('add_contact')),
            ),
          if (isContact)
            MenuItemButton(
              leadingIcon: const Icon(Symbols.person_edit),
              onPressed: onEdit,
              child: Text(tr('form_contact_title')),
            ),
          const Divider(),
          if (!me)
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
    if (disable) {
      return;
    }
    if (controller.isOpen) {
      controller.close();
    } else {
      controller.open();
    }
  }
}
