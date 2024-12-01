import 'dart:math';

import 'package:durt/durt.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/app_cubit.dart';
import '../../data/models/bottom_nav_cubit.dart';
import '../../data/models/cesium_card.dart';
import '../../data/models/contact.dart';
import '../../data/models/credit_card_themes.dart';
import '../../data/models/multi_wallet_transaction_cubit.dart';
import '../../g1/api.dart';
import '../../g1/g1_export_auth_utils.dart';
import '../../g1/g1_helper.dart';
import '../../shared_prefs_helper.dart';
import '../logger.dart';
import '../qr_manager.dart';
import '../ui_helpers.dart';
import 'fifth_screen/import_dialog.dart';
import 'form_error_widget.dart';

class CesiumAuthDialog extends StatefulWidget {
  const CesiumAuthDialog(
      {super.key, required this.publicKey, required this.returnTo});

  final String publicKey;
  final int returnTo;

  @override
  State<CesiumAuthDialog> createState() => _CesiumAuthDialogState();
}

class _CesiumAuthDialogState extends State<CesiumAuthDialog> {
  final TextEditingController secretPhraseController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscureText1 = true;
  bool _obscureText2 = true;
  bool _isProcessing = false;
  final ValueNotifier<String> _feedbackNotifier = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Contact>(
      future: getProfile(widget.publicKey, onlyCPlusProfile: true),
      builder: (BuildContext context, AsyncSnapshot<Contact> snapshot) {
        if (snapshot.hasData) {
          return _buildCustomAlertDialog(context, snapshot.data!);
        }
        return _buildCustomAlertDialog(
            context, Contact(pubKey: widget.publicKey));
      },
    );
  }

  AlertDialog _buildCustomAlertDialog(BuildContext context, Contact contact) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Text(
              tr('cesium_auth_dialog_title', namedArgs: <String, String>{
                'key': humanizeContact(widget.publicKey, contact),
              }),
              style: Theme.of(context).textTheme.titleLarge,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (context.read<AppCubit>().isExpertMode)
            PopupMenuButton<String>(
              tooltip: tr('other_auth_methods'),
              onSelected: (String result) async {
                if (result == 'import') {
                  await _showFileImportDialog(context, contact);
                } else if (result == 'scan') {
                  await _showScanQrDialog(context, contact);
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'import',
                  child: Row(
                    children: <Widget>[
                      const Icon(Icons.upload_file),
                      const SizedBox(width: 8),
                      Text(tr('keyfile_auth')),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'scan',
                  child: Row(
                    children: <Widget>[
                      const Icon(Icons.qr_code_scanner),
                      const SizedBox(width: 8),
                      Text(tr('scan_qr_auth')),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
      content: _buildDialogContent(context),
      actions: _buildDialogActions(context, contact),
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    return SingleChildScrollView(
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
    );
  }

  List<Widget> _buildDialogActions(BuildContext context, Contact contact) {
    return <Widget>[
      TextButton(
        child: Text(tr('cancel')),
        onPressed: () {
          Navigator.of(context).pop(false);
        },
      ),
      TextButton(
        onPressed: _isProcessing
            ? null
            : () async {
                _feedbackNotifier.value = '';
                setState(() {
                  _isProcessing = true;
                });
                final String secret = secretPhraseController.text;
                final String password = passwordController.text;
                final CesiumWallet wallet = CesiumWallet(secret, password);

                setState(() {
                  _isProcessing = false;
                });
                if (wallet.pubkey != extractPublicKey(widget.publicKey)) {
                  _feedbackNotifier.value = tr('incorrect_passwords');
                } else {
                  _onCorrectAuth(contact, wallet, context);
                }
              },
        child: _isProcessing
            ? const CircularProgressIndicator()
            : Text(tr('accept')),
      ),
    ];
  }

  void _onCorrectAuth(
      Contact contact, CesiumWallet wallet, BuildContext context) {
    final CesiumCard card = CesiumCard(
      name: contact.name ?? '',
      pubKey: extractPublicKey(widget.publicKey),
      seed: '',
      theme: CreditCardThemes.themes[Random().nextInt(10)],
    );
    if (!SharedPreferencesHelper().has(extractPublicKey(widget.publicKey))) {
      SharedPreferencesHelper().addCesiumCard(card);
      SharedPreferencesHelper().selectCurrentWallet(card);
      context
          .read<MultiWalletTransactionCubit>()
          .fetchTransactions(pubKey: extractPublicKey(widget.publicKey));
    }
    SharedPreferencesHelper().addCesiumVolatileCard(wallet);
    if (context.read<BottomNavCubit>().currentIndex != widget.returnTo) {
      context.read<BottomNavCubit>().updateIndex(widget.returnTo);
    }
    _feedbackNotifier.value = '';
    Navigator.of(context).pop(true);
  }

  Future<void> _showFileImportDialog(BuildContext c, Contact contact) async {
    if (!c.mounted) {
      return;
    }
    String? fileContent;
    if (kIsWeb) {
      fileContent = await importWalletWeb(c, '.dunikey');
    } else {
      fileContent =
          await importWallet(c, <String>['.dunikey'], 'select_auth_file');
    }

    if (fileContent != null && fileContent.isNotEmpty && mounted) {
      try {
        final CesiumWallet importedWallet =
            await parseKeyFile(fileContent, context);

        // loggerDev('Imported wallet: ${importedWallet.pubkey}');
        // loggerDev('Wallet to auth: ${extractPublicKey(widget.publicKey)}');
        if (importedWallet.pubkey == extractPublicKey(widget.publicKey)) {
          if (!mounted) {
            return;
          }
          _onCorrectAuth(contact, importedWallet, context);
        } else {
          _feedbackNotifier.value = tr('auth_file_pubkey_mismatch');
        }
      } catch (e) {
        _feedbackNotifier.value = tr('auth_file_error');
      }
    }
  }

  Future<void> _showScanQrDialog(BuildContext context, Contact contact) async {
    try {
      final String? scannedKey = await QrManager.qrScan(context);

      if (scannedKey != null && scannedKey.isNotEmpty) {
        if (!context.mounted) {
          return;
        }
        final CesiumWallet importedWallet =
            await parseKeyFile(scannedKey, context);

        if (importedWallet.pubkey == extractPublicKey(widget.publicKey)) {
          if (!context.mounted) {
            return;
          }
          _onCorrectAuth(contact, importedWallet, context);
        } else {
          _feedbackNotifier.value = tr('auth_file_pubkey_mismatch');
        }
      } else {
        _feedbackNotifier.value = tr('qr_scan_error_empty');
      }
    } catch (e) {
      logger('Error scanning QR: $e');
      _feedbackNotifier.value = tr('auth_file_error');
    }
  }
}
