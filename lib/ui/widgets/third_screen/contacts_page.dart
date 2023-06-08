import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:share_plus/share_plus.dart';

import '../../../data/models/bottom_nav_cubit.dart';
import '../../../data/models/contact.dart';
import '../../../data/models/contact_cubit.dart';
import '../../../data/models/payment_cubit.dart';
import '../../contacts_cache.dart';
import '../../ui_helpers.dart';
import '../bottom_widget.dart';
import 'contact_edit_dialog.dart';

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
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: tr('search_contacts'),
                border: const OutlineInputBorder(),
              ),
              onChanged: (String query) {
                context.read<ContactsCubit>().filterContacts(query);
              },
            ),
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
                              context
                                  .read<ContactsCubit>()
                                  .removeContact(contact);
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
                        dismissible: DismissiblePane(onDismissed: () {
                          onSent(context, contact);
                        }),
                        children: <SlidableAction>[
                          SlidableAction(
                            onPressed: (BuildContext c) {
                              showQrDialog(
                                  context: context,
                                  publicKey: contact.pubKey,
                                  noTitle: true,
                                  feedbackText: 'some_key_copied_to_clipboard');
                            },
                            backgroundColor: Theme.of(context).primaryColorDark,
                            foregroundColor: Colors.white,
                            icon: Icons.copy,
                            label: tr('copy_contact_key'),
                          ),
                          SlidableAction(
                            onPressed: (BuildContext c) {
                              onSent(c, contact);
                            },
                            backgroundColor: Theme.of(context).primaryColor,
                            foregroundColor: Colors.white,
                            icon: Icons.send,
                            label: tr('send_g1'),
                          ),
                        ],
                      ),
                      child: SlidableContactTile(contact,
                          index: index, context: context, onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ContactEditDialog(
                                contact: contact,
                                onSave: (Contact c) {
                                  context
                                      .read<ContactsCubit>()
                                      .updateContact(c);
                                  ContactsCache().saveContact(c);
                                });
                          },
                        );
                      }, onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(tr('long_press_to_edit')),
                          ),
                        );
                      }));
                },
              )),
            const BottomWidget()
          ],
        ));
  }

  void onSent(BuildContext c, Contact contact) {
    c.read<PaymentCubit>().selectUser(contact);
    c.read<BottomNavCubit>().updateIndex(0);
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
