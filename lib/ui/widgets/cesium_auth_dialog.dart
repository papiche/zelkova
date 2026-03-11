import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/bottom_nav_cubit.dart';
import '../../data/models/contact.dart';
import '../../data/models/multi_wallet_transaction_cubit.dart';
import '../../g1/api.dart';
import '../../g1/crypto/cesium_wallet.dart';
import '../../g1/g1_export_auth_utils.dart';
import '../../g1/g1_helper.dart';
import '../../shared_prefs_helper.dart';
import '../logger.dart';
import '../qr_manager.dart';
import '../ui_helpers.dart';
import 'fifth_screen/import_dialog.dart';
import 'fifth_screen/import_dialog_stub.dart';
import 'form_error_widget.dart';
import 'password_field.dart';

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
  bool _isProcessing = false;
  final ValueNotifier<String> _feedbackNotifier = ValueNotifier<String>('');
  final ValueNotifier<String> _statusNotifier = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Contact>(
      future: getProfile(widget.publicKey, complete: false),
      builder: (BuildContext context, AsyncSnapshot<Contact> snapshot) {
        if (snapshot.hasData) {
          return _buildFullScreenAuth(context, snapshot.data!);
        }
        return _buildFullScreenAuth(context, Contact(pubKey: widget.publicKey));
      },
    );
  }

  Widget _buildFullScreenAuth(BuildContext context, Contact contact) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('cesium_auth_title')),
        actions: <Widget>[
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 8),
            Text(
              tr('cesium_auth_dialog_title', namedArgs: <String, String>{
                'key': humanizeContact(widget.publicKey, contact),
              }),
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            PasswordField(
              controller: secretPhraseController,
              label: tr('cesium_secret_phrase'),
              onChanged: (String value) => _feedbackNotifier.value = '',
            ),
            const SizedBox(height: 16),
            PasswordField(
              controller: passwordController,
              label: tr('cesium_password'),
              onChanged: (String value) => _feedbackNotifier.value = '',
            ),
            const SizedBox(height: 8),
            FormErrorWidget(feedbackNotifier: _feedbackNotifier),
            ValueListenableBuilder<String>(
              valueListenable: _statusNotifier,
              builder: (BuildContext context, String status, Widget? child) {
                if (status.isEmpty) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        status,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                child: Text(tr('cancel')),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              const SizedBox(width: 8),
              FilledButton(
                onPressed:
                    _isProcessing ? null : () => _handleAuthentication(contact),
                child: _isProcessing
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(tr('accept')),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleAuthentication(Contact contact) async {
    _feedbackNotifier.value = '';
    setState(() {
      _isProcessing = true;
    });

    _statusNotifier.value = tr('validating_credentials');

    // Allow UI to update with loading indicator before heavy operation
    await Future<void>.delayed(Duration.zero);

    final String secret = secretPhraseController.text;
    final String password = passwordController.text;

    // Measure time for wallet creation
    final Stopwatch stopwatch = Stopwatch()..start();
    final CesiumWallet wallet = CesiumWallet(secret, password);
    stopwatch.stop();
    logger('CesiumWallet creation took: ${stopwatch.elapsedMilliseconds}ms');

    if (!mounted) {
      return;
    }

    setState(() {
      _isProcessing = false;
    });

    _statusNotifier.value = '';

    if (wallet.pubkey != extractPublicKey(widget.publicKey)) {
      _feedbackNotifier.value = tr('incorrect_passwords');
    } else {
      _onCorrectAuth(contact, wallet, context);
    }
  }

  void _onCorrectAuth(
      Contact contact, CesiumWallet wallet, BuildContext context) {
    SharedPreferencesHelper().handleCorrectCesiumV1Auth(
        publicKey: widget.publicKey, name: contact.name, wallet: wallet);

    // Clear feedback and close dialog immediately
    _feedbackNotifier.value = '';
    Navigator.of(context).pop(true);

    // Fetch transactions and update navigation AFTER closing the dialog
    // to avoid blocking the UI
    Future<void>.delayed(Duration.zero, () {
      if (context.mounted) {
        context
            .read<MultiWalletTransactionCubit>()
            .fetchTransactions(pubKey: extractPublicKey(widget.publicKey));
        if (context.read<BottomNavCubit>().currentIndex != widget.returnTo) {
          context.read<BottomNavCubit>().updateIndex(widget.returnTo);
        }
      }
    });
  }

  Future<void> _showFileImportDialog(BuildContext c, Contact contact) async {
    if (!c.mounted) {
      return;
    }
    String? fileContent;
    if (kIsWeb) {
      // Previous used .dunikey with dot
      fileContent = await importWalletWeb('dunikey');
    } else {
      fileContent =
          await importWallet(c, <String>['.dunikey'], 'select_auth_file');
    }

    if (fileContent != null && fileContent.isNotEmpty && mounted) {
      // Show loading indicator before processing (EWIF can be very slow)
      _feedbackNotifier.value = '';
      setState(() {
        _isProcessing = true;
      });
      _statusNotifier.value = tr('validating_credentials');

      // Allow UI to update before heavy operation
      await Future<void>.delayed(Duration.zero);

      try {
        final Stopwatch stopwatch = Stopwatch()..start();
        if (!mounted) {
          return;
        }
        final CesiumWallet importedWallet =
            await parseKeyFile(fileContent, context);
        stopwatch.stop();
        logger('KeyFile parsing took: ${stopwatch.elapsedMilliseconds}ms');

        if (!mounted) {
          return;
        }

        setState(() {
          _isProcessing = false;
        });
        _statusNotifier.value = '';

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
        if (mounted) {
          setState(() {
            _isProcessing = false;
          });
          _statusNotifier.value = '';
        }
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

        // Show loading indicator before processing (EWIF can be very slow)
        _feedbackNotifier.value = '';
        setState(() {
          _isProcessing = true;
        });
        _statusNotifier.value = tr('validating_credentials');

        // Allow UI to update before heavy operation
        await Future<void>.delayed(Duration.zero);

        try {
          final Stopwatch stopwatch = Stopwatch()..start();
          if (!context.mounted) {
            return;
          }
          final CesiumWallet importedWallet =
              await parseKeyFile(scannedKey, context);
          stopwatch.stop();
          logger('QR KeyFile parsing took: ${stopwatch.elapsedMilliseconds}ms');

          if (!mounted) {
            return;
          }

          setState(() {
            _isProcessing = false;
          });
          _statusNotifier.value = '';

          if (importedWallet.pubkey == extractPublicKey(widget.publicKey)) {
            if (!context.mounted) {
              return;
            }
            _onCorrectAuth(contact, importedWallet, context);
          } else {
            _feedbackNotifier.value = tr('auth_file_pubkey_mismatch');
          }
        } catch (e) {
          if (mounted) {
            setState(() {
              _isProcessing = false;
            });
            _statusNotifier.value = '';
          }
          logger('Error parsing QR keyfile: $e');
          _feedbackNotifier.value = tr('auth_file_error');
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

Future<bool?> showAuthCesiumWalletDialog(
    BuildContext context, String wallet, int returnTo) {
  return Navigator.push<bool>(
    context,
    MaterialPageRoute<bool>(
      builder: (BuildContext context) {
        return CesiumAuthDialog(publicKey: wallet, returnTo: returnTo);
      },
    ),
  );
}

Future<bool> walletV1Auth(BuildContext context) async {
  bool hasPass = false;
  if (!SharedPreferencesHelper().isPasswordLessWallet() &&
      !SharedPreferencesHelper().hasVolatilePass()) {
    hasPass = await showAuthCesiumWalletDialog(
            context,
            SharedPreferencesHelper().getPubKey(),
            context.read<BottomNavCubit>().currentIndex) ??
        false;
  } else {
    hasPass = true;
  }
  return hasPass;
}
