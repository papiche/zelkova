import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../data/models/contact.dart';
import '../../data/models/contact_cubit.dart';
import '../../g1/g1_helper.dart';
import '../../shared_prefs_helper.dart';
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

  static final ValueNotifier<MenuController?> _openMenuController =
      ValueNotifier<MenuController?>(null);

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
                showContactPage(context, contact);
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
              onPressed: () => addContact(context, contact),
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
    Future<void>.delayed(const Duration(milliseconds: 50), () {
      if (_openMenuController.value != null &&
          _openMenuController.value != controller) {
        _openMenuController.value!.close();
      }
      if (controller.isOpen) {
        controller.close();
        _openMenuController.value = null;
      } else {
        controller.open();
        _openMenuController.value = controller;
      }
    });
  }
}
