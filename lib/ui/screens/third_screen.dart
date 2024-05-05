import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/contact.dart';
import '../../data/models/contact_cubit.dart';
import '../../g1/g1_helper.dart';
import '../contacts_cache.dart';
import '../qr_manager.dart';
import '../tutorial.dart';
import '../tutorial_keys.dart';
import '../widgets/card_drawer.dart';
import '../widgets/first_screen/contact_search_page.dart';
import '../widgets/third_screen/contact_form_dialog.dart';
import '../widgets/third_screen/contacts_page.dart';
import '../widgets/third_screen/third_tutorial.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  late Tutorial tutorial;

  @override
  void initState() {
    super.initState();
    tutorial = ThirdTutorial(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(tr('bottom_nav_trd')), actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.travel_explore),
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const ContactSearchPage(forPayment: false);
                  },
                );
              }),
          IconButton(
              key: contactsQrKey,
              icon: const Icon(Icons.qr_code),
              onPressed: () async {
                final String? pubKey = await QrManager.qrScan(context);
                if (pubKey != null && validateKey(pubKey)) {
                  final Contact contact =
                      await ContactsCache().getContact(pubKey);
                  if (!context.mounted) {
                    return;
                  }
                  if (!context.read<ContactsCubit>().isContact(pubKey)) {
                    context.read<ContactsCubit>().addContact(contact);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(tr('contact_added')),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(tr('contact_already_exists')),
                      ),
                    );
                  }
                } else {
                  if (!context.mounted) {
                    return;
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(tr('wrong_public_key')),
                    ),
                  );
                }
              }),
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              tutorial.showTutorial(showAlways: true);
            },
          ),
          const SizedBox(width: 5),
        ]),
        drawer: const CardDrawer(),
        body: const ContactsPage(),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ContactFormDialog(
                      contact: const Contact(
                        name: '',
                        pubKey: '',
                      ),
                      isNew: true,
                      onSave: (Contact c) {
                        context.read<ContactsCubit>().addContact(c);
                        ContactsCache().saveContact(c);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(tr('contact_added')),
                          ),
                        );
                      });
                });
          },
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(50.0),
            ),
          ),
          child: const Icon(Icons.add),
        ));
  }
}
