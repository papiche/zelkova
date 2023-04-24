import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/bottom_nav_cubit.dart';
import '../../data/models/contact.dart';
import '../../data/models/contact_cubit.dart';
import '../../g1/g1_helper.dart';
import '../contacts_cache.dart';
import '../qr_manager.dart';
import '../tutorial.dart';
import '../tutorial_keys.dart';
import '../widgets/card_drawer.dart';
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
    tutorial = ThirdTutorial(context);
    if (context.read<BottomNavCubit>().state == 2) {
      Future<void>.delayed(Duration.zero, () => tutorial.showTutorial());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          key: contactsMainKey,
          title: Text(tr('bottom_nav_trd')),
          actions: <Widget>[
            IconButton(
                key: contactsQrKey,
                icon: const Icon(Icons.qr_code),
                onPressed: () async {
                  final String? pubKey = await QrManager.qrScan(context);
                  if (pubKey != null && validateKey(pubKey)) {
                    final Contact contact =
                        await ContactsCache().getContact(pubKey);
                    if (!mounted) {
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
                    if (!mounted) {
                      return;
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(tr('wrong_public_key')),
                      ),
                    );
                  }
                }),
            const SizedBox(width: 5),
          ]),
      drawer: const CardDrawer(),
      body: const ContactsPage(),
    );
  }
}
