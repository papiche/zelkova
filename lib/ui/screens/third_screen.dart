import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../widgets/card_drawer.dart';
import '../widgets/third_screen/contacts_page.dart';

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr('bottom_nav_trd'))),
      drawer: const CardDrawer(),
      body: const ContactsPage(),
    );
  }
}
