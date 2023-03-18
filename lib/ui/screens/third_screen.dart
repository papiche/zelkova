import 'package:flutter/material.dart';

import '../widgets/third_screen/contacts_page.dart';

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.background,
      child: const ContactsPage(),
    );
  }
}
