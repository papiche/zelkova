import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../tutorial.dart';
import '../widgets/card_drawer.dart';
import '../widgets/second_screen/card_terminal.dart';
import '../widgets/second_screen/second_tutorial.dart';
import '../../g1/astroid_helper.dart';
import '../../g1/api.dart';
import '../../shared_prefs_helper.dart';
import '../pay_helper.dart';
import '../qr_manager_mobile.dart';
import '../ui_helpers.dart';

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

  Future<void> _scanAstroID() async {
    try {
      // Scan the QR code and extract the DISCO value
      final String? disco = await QrManager.qrScan(context);
      if (disco == null) {
        return;
      }

      // Ask the user for the unique password
      final String? password = await showTextInputDialog(
        context: context,
        title: 'Enter Password',
        hint: 'Unique Password',
      );
      if (password == null || password.isEmpty) {
        return;
      }

      // Decrypt the AstroID
      final Tuple2<String, String>? secrets =
          await decryptAstroID(disco, password);
      if (secrets == null) {
        showAlertDialog(context, 'Error',
            'Failed to decrypt AstroID. Please check the password.');
        return;
      }

      // Initialize a new CesiumWallet with the decrypted secrets
      final CesiumWallet astroIDWallet =
          CesiumWallet.fromSecrets(secrets.item1, secrets.item2);

      // Get the currently loaded wallet
      final CesiumWallet currentWallet =
          await SharedPreferencesHelper().getWallet();

      // Make a payment from the AstroID wallet to the current wallet
      final PayResult result = await payWithGVA(
        to: [currentWallet.pubkey],
        amount: 100.0, // Specify the amount to transfer
        comment: 'Payment from AstroID',
      );

      if (result.message == 'success') {
        showAlertDialog(context, 'Success', 'Payment from AstroID successful!');
      } else {
        showAlertDialog(
            context, 'Error', 'Payment from AstroID failed: ${result.message}');
      }

      // Discard the AstroID wallet instance
      astroIDWallet.dispose();
    } catch (e, stacktrace) {
      logger('Error during AstroID payment: $e');
      logger(stacktrace.toString());
      showAlertDialog(
          context, 'Error', 'An error occurred during AstroID payment.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('receive_g1')),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            onPressed: _scanAstroID,
          ),
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
