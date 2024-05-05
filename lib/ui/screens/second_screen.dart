import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../tutorial.dart';
import '../widgets/card_drawer.dart';
import '../widgets/second_screen/card_terminal.dart';
import '../widgets/second_screen/second_tutorial.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  late Tutorial tutorial;

  @override
  void initState() {
    super.initState();
    tutorial = SecondTutorial(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('receive_g1')),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              tutorial.showTutorial(showAlways: true);
            },
          ),
        ],
      ),
      drawer: const CardDrawer(),
      body:
          const Column(children: <Widget>[SizedBox(height: 2), CardTerminal()]),
    );
  }
}
