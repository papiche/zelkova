import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:share_plus/share_plus.dart';

import '../../../data/models/contact.dart';
import '../../../data/models/contact_cubit.dart';
import '../../../data/models/contact_sort_type.dart';
import '../../ui_helpers.dart';
import '../bottom_widget.dart';
import '../contact_menu.dart';
import '../contacts_actions.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ContactsCubit>().resetFilter();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ContactsCubit cubit = context.watch<ContactsCubit>();
    context.read<ContactsCubit>().sortContactsAsStored();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background),
                child: Row(children: <Widget>[
                  Expanded(
                      child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: tr('search_contacts'),
                            border: const OutlineInputBorder(),
                          ),
                          onChanged: (String query) {
                            context.read<ContactsCubit>().filterContacts(query);
                          })),
                  PopupMenuButton<ContactsSortType>(
                    icon: const Icon(Icons.sort),
                    onSelected: (ContactsSortType result) {
                      context.read<ContactsCubit>().sortContacts(result);
                    },
                    itemBuilder: (BuildContext context) {
                      final ContactsSortType currentOrder =
                          context.read<ContactsCubit>().state.order;

                      return <PopupMenuEntry<ContactsSortType>>[
                        PopupMenuItem<ContactsSortType>(
                          value: ContactsSortType.date,
                          child: ListTile(
                            leading: Icon(
                              Icons.date_range,
                              color: currentOrder == ContactsSortType.date
                                  ? Colors.blue
                                  : null,
                            ),
                            title: Text(tr('contacts_sort_by_date')),
                            trailing: currentOrder == ContactsSortType.date
                                ? const Icon(Icons.check)
                                : null,
                          ),
                        ),
                        PopupMenuItem<ContactsSortType>(
                          value: ContactsSortType.alpha,
                          child: ListTile(
                            leading: Icon(
                              Icons.sort_by_alpha,
                              color: currentOrder == ContactsSortType.alpha
                                  ? Colors.blue
                                  : null,
                            ),
                            title: Text(tr('contacts_sort_by_name')),
                            trailing: currentOrder == ContactsSortType.alpha
                                ? const Icon(Icons.check)
                                : null,
                          ),
                        ),
                      ];
                    },
                  )
                ]))),
        const SizedBox(height: 20),
        if (cubit.state.filteredContacts.isEmpty)
          const NoElements(text: 'no_contacts')
        else
          Expanded(
              child: ListView.builder(
            itemCount: cubit.state.filteredContacts.length,
            itemBuilder: (BuildContext context, int index) {
              final Contact contact = cubit.state.filteredContacts[index];
              return Slidable(
                  // Specify a key if the Slidable is dismissible.
                  key: ValueKey<int>(index),
                  // The start action pane is the one at the left or the top side.
                  startActionPane: ActionPane(
                    // A motion is a widget used to control how the pane animates.
                    motion: const ScrollMotion(),

                    // All actions are defined in the children parameter.
                    children: <SlidableAction>[
                      // A SlidableAction can have an icon and/or a label.
                      SlidableAction(
                        onPressed: (BuildContext c) {
                          onDeleteContact(context, contact);
                        },
                        backgroundColor: deleteColor,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: tr('delete_contact'),
                      ),
                      if (showShare())
                        SlidableAction(
                          onPressed: (BuildContext c) =>
                              Share.share(contact.pubKey),
                          backgroundColor:
                              Theme.of(context).secondaryHeaderColor,
                          foregroundColor: Theme.of(context).primaryColor,
                          icon: Icons.share,
                          label: tr('share_this_key'),
                        ),
                    ],
                  ),
                  // The end action pane is the one at the right or the bottom side.
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    /* dismissible: DismissiblePane(onDismissed: () {
                          onSent(context, contact);
                        }), */
                    children: <SlidableAction>[
                      SlidableAction(
                        onPressed: (BuildContext c) {
                          onShowContactQr(context, contact);
                        },
                        backgroundColor: Theme.of(context).primaryColorDark,
                        foregroundColor: Colors.white,
                        icon: Icons.copy,
                        label: tr('copy_contact_key'),
                      ),
                      SlidableAction(
                        onPressed: (BuildContext c) {
                          onSentContact(c, contact);
                        },
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                        icon: Icons.send,
                        label: tr('send_g1'),
                      ),
                    ],
                  ),
                  child: SlidableContactTile(contact,
                      index: index,
                      context: context,
                      onLongPress: () => onEditContact(context, contact),
                      onTap: () {
/*                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(tr('long_press_to_edit')),
                          ),
                        ); */
                      },
                      trailing: ContactMenu(
                          contact: contact,
                          onEdit: () => onEditContact(context, contact),
                          onSent: () => onSentContact(context, contact),
                          onCopy: () => onShowContactQr(context, contact),
                          onDelete: () => onDeleteContact(context, contact))));
            },
          )),
        const BottomWidget()
      ],
    );
  }
}

class NoElements extends StatelessWidget {
  const NoElements({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Center(child: Text(tr(text))));
  }
}
