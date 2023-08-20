import 'dart:math';

import 'package:durt/durt.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/bottom_nav_cubit.dart';
import '../../data/models/cesium_card.dart';
import '../../data/models/contact.dart';
import '../../data/models/credit_card_themes.dart';
import '../../g1/api.dart';
import '../../g1/g1_helper.dart';
import '../../shared_prefs_helper.dart';
import '../ui_helpers.dart';
import 'form_error_widget.dart';

class CesiumAddDialog extends StatefulWidget {
  const CesiumAddDialog(
      {super.key, required this.cardName, required this.publicKey});

  final String cardName;
  final String publicKey;

  @override
  State<CesiumAddDialog> createState() => _CesiumAddDialogState();
}

class _CesiumAddDialogState extends State<CesiumAddDialog> {
  final TextEditingController secretPhraseController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscureText1 = true;
  bool _obscureText2 = true;
  bool _isProcessing = false;
  final ValueNotifier<String> _feedbackNotifier = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Contact>(
      future: getProfile(widget.publicKey, true),
      builder: (BuildContext context, AsyncSnapshot<Contact> snapshot) {
        if (snapshot.hasData) {
          return showDialog(
              context, humanizeContact(widget.publicKey, snapshot.data!));
        }
        return showDialog(context, humanizePubKey(widget.publicKey));
      },
    );
  }

  AlertDialog showDialog(BuildContext context, String name) {
    return AlertDialog(
      title: Text(tr('cesium_auth_dialog_title',
          namedArgs: <String, String>{'key': name})),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            TextField(
              controller: secretPhraseController,
              obscureText: _obscureText1,
              onChanged: (String? value) {
                _feedbackNotifier.value = '';
              },
              decoration: InputDecoration(
                labelText: tr('cesium_secret_phrase'),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText1 ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText1 = !_obscureText1;
                    });
                  },
                ),
              ),
            ),
            TextField(
              controller: passwordController,
              obscureText: _obscureText2,
              onChanged: (String? value) {
                _feedbackNotifier.value = '';
              },
              decoration: InputDecoration(
                labelText: tr('cesium_password'),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText2 ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText2 = !_obscureText2;
                    });
                  },
                ),
              ),
            ),
            FormErrorWidget(feedbackNotifier: _feedbackNotifier),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(tr('cancel')),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        TextButton(
          onPressed: _isProcessing
              ? null
              : () {
                  _feedbackNotifier.value = '';
                  setState(() {
                    _isProcessing = true;
                  });
                  final String secret = secretPhraseController.text;
                  final String password = passwordController.text;
                  final CesiumWallet wallet = CesiumWallet(secret, password);

                  // logger('wallet.pubkey: ${wallet.pubkey} vs ${widget.publicKey}');
                  setState(() {
                    _isProcessing = false;
                  });
                  if (wallet.pubkey != extractPublicKey(widget.publicKey)) {
                    _feedbackNotifier.value = tr('incorrect_passwords');
                  } else {
                    final CesiumCard card = CesiumCard(
                        name: widget.cardName,
                        pubKey: extractPublicKey(widget.publicKey),
                        seed: '',
                        theme: CreditCardThemes.themes[Random().nextInt(10)]);
                    if (!SharedPreferencesHelper()
                        .has(extractPublicKey(widget.publicKey))) {
                      SharedPreferencesHelper().addCesiumCard(card);
                      SharedPreferencesHelper().selectCurrentWallet(card);
                    }
                    SharedPreferencesHelper().addCesiumVolatileCard(wallet);
                    context.read<BottomNavCubit>().updateIndex(0);
                    _feedbackNotifier.value = '';
                    Navigator.of(context).pop(true);
                  }
                },
          child: _isProcessing
              ? const CircularProgressIndicator()
              : Text(tr('accept')),
        ),
      ],
    );
  }
}
