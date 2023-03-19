import 'package:flutter/material.dart';

import '../widgets/second_screen/card_terminal.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.background,
      child:
          Column(children: const <Widget>[SizedBox(height: 2), CardTerminal()]),
    );
  }
}
