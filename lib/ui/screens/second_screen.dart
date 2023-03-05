import 'package:flutter/material.dart';

import '../widgets/second_screen/card_terminal.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.background,
      child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          physics: const BouncingScrollPhysics(),
          children: const <Widget>[SizedBox(height: 36), CardTerminal()]),
    );
  }
}
