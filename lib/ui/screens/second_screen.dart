// ignore_for_file: use_build_context_synchronously

import 'package:durt/durt.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ndef/ndef.dart';
import '../../data/models/cesium_card.dart';
import '../logger.dart';
import 'package:tuple/tuple.dart';

import '../tutorial.dart';
import '../widgets/card_drawer.dart';
import '../widgets/second_screen/card_terminal.dart';
import '../widgets/second_screen/second_tutorial.dart';
import '../../g1/astroid_helper.dart';
import '../../g1/api.dart';
import '../../shared_prefs_helper.dart';
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

      // Demander à l'utilisateur de saisir le mot de passe unique ($UNIQID)
      final String? password = await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          String passwordLocal = '';
          return AlertDialog(
            title: const Text('Saisir le mot de passe'),
            content: TextField(
              decoration:
                  const InputDecoration(hintText: 'Mot de passe unique'),
              onChanged: (String value) {
                // Handle password input
                passwordLocal = value;
              },
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(null),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  // Handle password submission
                  Navigator.of(context).pop(passwordLocal);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
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

      // Get the currently loaded wallet
      final CesiumWallet currentWallet =
          await SharedPreferencesHelper().getWallet();

      // Initialize a new CesiumWallet with the decrypted secrets
      final CesiumWallet astroIDWallet =
          CesiumWallet(secrets.item1, secrets.item2);

      // Add the AstroID wallet to the storage
      SharedPreferencesHelper().importAstroIDWallet(disco, password);
      final CesiumCard card = SharedPreferencesHelper().buildCesiumCard(
          seed: astroIDWallet.seed.toHexString(), pubKey: astroIDWallet.pubkey);

      // Select the AstroID wallet as the current wallet
      SharedPreferencesHelper().selectCurrentWallet(card);

      // Make a payment from the AstroID wallet to the current wallet
      final PayResult result = await payWithGVA(
        to: <String>[currentWallet.pubkey],
        amount: 100.0, // Specify the amount to transfer
        comment: 'Payment from AstroID',
      );

      if (result.message == 'success') {
        showAlertDialog(context, 'Success', 'Payment from AstroID successful!');
      } else {
        showAlertDialog(
            context, 'Error', 'Payment from AstroID failed: ${result.message}');
      }
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
