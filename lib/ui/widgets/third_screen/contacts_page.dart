import 'package:clipboard/clipboard.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../cubit/bottom_nav_cubit.dart';
import '../../../data/models/contact.dart';
import '../../../data/models/contact_cubit.dart';
import '../../../data/models/contact_state.dart';
import '../../../data/models/payment_cubit.dart';
import '../../ui_helpers.dart';
import '../bottom_widget.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  final TextEditingController _searchController = TextEditingController();
  late ContactsCubit _contactsCubit;

  @override
  void initState() {
    super.initState();
    _contactsCubit = context.read<ContactsCubit>();
    _contactsCubit.resetFilter();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final ContactsCubit cubit = context.read<ContactsCubit>();
    return BlocBuilder<ContactsCubit, ContactsState>(
        builder: (BuildContext context, ContactsState state) {
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
                  _contactsCubit.filterContacts(query);
                },
              ),
              if (state.filteredContacts.isEmpty)
                const NoElements(text: 'no_contacts')
              else
                Expanded(
                    child: ListView.builder(
                  itemCount: state.filteredContacts.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Contact contact = state.filteredContacts[index];
                    return Slidable(
                      // Specify a key if the Slidable is dismissible.
                      key: const ValueKey<int>(0),

                      // The start action pane is the one at the left or the top side.
                      startActionPane: ActionPane(
                        // A motion is a widget used to control how the pane animates.
                        motion: const ScrollMotion(),

                        // All actions are defined in the children parameter.
                        children: <SlidableAction>[
                          // A SlidableAction can have an icon and/or a label.
                          SlidableAction(
                            onPressed: (BuildContext c) {
                              _contactsCubit.removeContact(contact);
                            },
                            backgroundColor: const Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: tr('delete_contact'),
                          ),
                          /*  SlidableAction(
                            onPressed: (BuildContext c) {},
                            backgroundColor: const Color(0xFF21B7CA),
                            foregroundColor: Colors.white,
                            icon: Icons.share,
                            label: tr('share_contact'),
                          ),*/
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
                              FlutterClipboard.copy(contact.pubKey).then(
                                  (dynamic value) => ScaffoldMessenger.of(
                                          context)
                                      .showSnackBar(SnackBar(
                                          content: Text(tr(
                                              'some_key_copied_to_clipboard')))));
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
                      child: ListTile(
                        title: contact.nick != null
                            ? Text(contact.nick!)
                            : contact.name != null
                                ? Text(contact.name!)
                                : humanizePubKeyAsWidget(contact.pubKey),
                        subtitle: contact.nick != null || contact.name != null
                            ? humanizePubKeyAsWidget(contact.pubKey)
                            : null,
                        leading: avatar(
                          contact.avatar,
                          bgColor: tileColor(index, context),
                          color: tileColor(index, context, true),
                        ),
                        tileColor: tileColor(index, context),
                      ),
                    );
                  },
                )),
              const BottomWidget()
            ],
          ));
    });
  }

  void onSent(BuildContext c, Contact contact) {
    c
        .read<PaymentCubit>()
        .selectUser(contact.pubKey, contact.nick, contact.avatar);
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
