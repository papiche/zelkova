import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../widgets/card_drawer.dart';
import '../widgets/second_screen/card_terminal.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr('receive_g1'))),
      drawer: const CardDrawer(),
      body:
          Column(children: const <Widget>[SizedBox(height: 2), CardTerminal()]),
    );
  }
}
