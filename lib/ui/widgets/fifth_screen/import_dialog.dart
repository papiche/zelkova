import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pattern_lock/pattern_lock.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../data/models/contact.dart';
import '../../../data/models/contact_cubit.dart';
import '../../../data/models/multi_wallet_transaction_cubit.dart';
import '../../../data/models/stored_account.dart';
import '../../../g1/g1_helper.dart';
import '../../../g1/g1_v2_helper.dart'; // validateMnemonicMulti
import '../../../shared_prefs_helper.dart';
import '../../../wallet_already_exists_exception.dart';
import '../../logger.dart';
import '../../pattern_util.dart';
import '../../ui_helpers.dart';
import '../cesium_auth_dialog.dart';
import '../custom_error_widget.dart';
import '../error_dialog.dart';
import 'import_clipboard_dialog.dart';
import 'import_dialog_stub.dart'
    if (dart.library.js_interop) 'import_dialog_web.dart';
import 'import_types.dart';
import 'select_import_method.dart';

/// Get the appropriate text color for error messages based on theme
Color _getErrorTextColor(BuildContext context) {
  // Using a red that's visible on both light and dark backgrounds
  final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
  return isDarkMode ? Colors.red[200]! : const Color(0xFFFF6B6B);
}

/// Get the appropriate text color for success messages based on theme
Color _getSuccessTextColor(BuildContext context) {
  final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
  return isDarkMode ? Colors.white : Colors.black87;
}

/// Get the appropriate background color for snackbars based on theme
Color _getSnackBarBackgroundColor(BuildContext context) {
  final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
  return isDarkMode ? Colors.grey[900]! : Colors.grey[300]!;
}

/// Show a snackbar using the global messenger key (works even after context is destroyed)
void _showGlobalSnackBar(
    String message, Color textColor, Color backgroundColor) {
  globalMessengerKey.currentState?.showSnackBar(
    SnackBar(
        content: Text(
          message,
          style: TextStyle(color: textColor),
        ),
        backgroundColor: backgroundColor),
  );
}

class ImportDialog extends StatefulWidget {
  const ImportDialog({super.key, this.textToImport});

  final String? textToImport;

  @override
  State<ImportDialog> createState() => _ImportDialogState();
}

class _ImportDialogState extends State<ImportDialog> {
  final GlobalKey<ScaffoldState> _importKey =
      GlobalKey<ScaffoldState>(debugLabel: 'importKey');
  int _attempts = 0;
  bool _errorDialogShown = false;
  bool _isProcessing = false;
  Future<String>? _importFuture;

  @override
  void initState() {
    super.initState();
    loggerDev(
        'ImportDialog initState: textToImport is ${widget.textToImport == null ? 'null' : 'not null'}');
    _importFuture = widget.textToImport == null
        ? _getImportFuture(context)
        : Future<String>.value(widget.textToImport);
    loggerDev('ImportDialog: Future created, will complete with data');
  }

  @override
  void didUpdateWidget(covariant ImportDialog oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.textToImport != widget.textToImport) {
      _importFuture = widget.textToImport == null
          ? _getImportFuture(context)
          : Future<String>.value(widget.textToImport);
    }
  }

  Future<String> _getImportFuture(BuildContext c) {
    if (kIsWeb) {
      return importWalletWeb('json');
    } else {
      // Native Android or iOS - use the native file picker
      return importWallet(c);
    }
  }

  @override
  Widget build(BuildContext c) {
    return FutureBuilder<String>(
        future: _importFuture,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData &&
              snapshot.data != null &&
              snapshot.data!.isNotEmpty) {
            final String keyEncString = snapshot.data!;
            final String preview = keyEncString.length > 50
                ? keyEncString.substring(0, 50)
                : keyEncString;
            loggerDev('ImportDialog received text: $preview...');

            // If it's a pubkey, do not try to parse JSON here.
            if (validateKey(keyEncString)) {
              loggerDev('ImportDialog: Text is a valid key, showing error');
              if (!_errorDialogShown) {
                _errorDialogShown = true;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const ErrorDialog(
                        titleKey: 'error',
                        messageKey: 'invalid_import_json',
                      );
                    },
                  ).then((_) {
                    _errorDialogShown = false;
                    if (!context.mounted) {
                      return;
                    }
                    Navigator.of(context).pop();
                  });
                });
              }
              return const SizedBox.shrink();
            }

            // Only JSON path from here.
            if (!looksLikeJson(keyEncString)) {
              loggerDev(
                  'ImportDialog: Text does not look like JSON, showing error');
              if (!_errorDialogShown) {
                _errorDialogShown = true;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const ErrorDialog(
                        titleKey: 'error',
                        messageKey: 'invalid_import_json',
                      );
                    },
                  ).then((_) {
                    _errorDialogShown = false;
                    if (!context.mounted) {
                      return;
                    }
                    Navigator.of(context).pop();
                  });
                });
              }
              return const SizedBox.shrink();
            }

            // This can fail if the string is not a valid JSON or a valid
            // export so we catch the error
            try {
              loggerDev('ImportDialog: Attempting to decode JSON');
              final Map<String, dynamic> keyJson =
                  jsonDecode(keyEncString) as Map<String, dynamic>;
              loggerDev(
                  'ImportDialog: JSON decoded successfully, keys: ${keyJson.keys}');
              if (keyJson['key'] == null) {
                loggerDev(
                    'ImportDialog: No "key" field in JSON, showing error');
                if (!_errorDialogShown) {
                  _errorDialogShown = true;

                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const ErrorDialog(
                          titleKey: 'error',
                          messageKey: 'invalid_import_json',
                        );
                      },
                    ).then((_) {
                      _errorDialogShown = false;
                      if (!context.mounted) {
                        return;
                      }
                      Navigator.of(context).pop();
                    });
                  });
                }
                return Container();
              }

              loggerDev(
                  'ImportDialog: Found "key" field, building PatternLock UI');
              final String keyEncrypted = keyJson['key'] as String;
              return Scaffold(
                key: _importKey,
                appBar: AppBar(
                  title: Text(tr('draw_your_pattern')),
                ),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Flexible(
                      child: Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Text(
                            tr('intro_pattern_to_import'),
                            style: const TextStyle(fontSize: 26),
                          )),
                    ),
                    Flexible(
                      child: PatternLock(
                        selectedColor: selectedPatternLock(),
                        notSelectedColor: notSelectedPatternLock(),
                        pointRadius: 8,
                        fillPoints: true,
                        onInputComplete: (List<int> pattern) async {
                          if (_isProcessing) {
                            return;
                          }
                          if (_attempts >= 3) {
                            c.replaceSnackbar(
                              content: Text(
                                tr('too_many_attempts'),
                                style: TextStyle(color: _getErrorTextColor(c)),
                              ),
                              backgroundColor: _getSnackBarBackgroundColor(c),
                            );
                            Navigator.of(context).pop(true);
                            return;
                          }
                          try {
                            if (mounted) {
                              setState(() => _isProcessing = true);
                            }
                            // try to decrypt
                            final Map<String, dynamic> keys =
                                decryptJsonForImport(
                                    keyEncrypted, pattern.join());

                            // Perform import in background first
                            if (!c.mounted) {
                              return;
                            }
                            await _performImportInBackground(c, keys);

                            // Close dialog after successful import
                            if (!context.mounted) {
                              return;
                            }
                            Navigator.of(context).pop(true);
                          } catch (e, stacktrace) {
                            if (mounted) {
                              setState(() => _isProcessing = false);
                            }
                            _attempts++;
                            logger(e.toString());
                            logger(stacktrace);
                            if (!context.mounted) {
                              return;
                            }
                            context.replaceSnackbar(
                              content: Text(
                                tr('wrong_pattern'),
                                style: TextStyle(
                                    color: _getErrorTextColor(context)),
                              ),
                              backgroundColor:
                                  _getSnackBarBackgroundColor(context),
                            );
                            await Sentry.captureException(e,
                                stackTrace: stacktrace);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              );
            } catch (e) {
              loggerDev('ImportDialog: Error decoding JSON: $e');
              if (!_errorDialogShown) {
                _errorDialogShown = true;
                logger('Error decoding JSON: $e');
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const ErrorDialog(
                        titleKey: 'error',
                        messageKey: 'error_decoding_json',
                      );
                    },
                  ).then((_) {
                    _errorDialogShown = false;
                    if (!context.mounted) {
                      return;
                    }
                    Navigator.of(context).pop();
                  });
                });
              }
              return Container();
            }
          } else if (snapshot.hasError) {
            return CustomErrorWidget(snapshot.error);
          } else {
            loggerDev(
                'ImportDialog FutureBuilder: snapshot has no data (hasData=${snapshot.hasData}, hasError=${snapshot.hasError}, connectionState=${snapshot.connectionState})');
            return Container(); // CustomErrorWidget(tr('import_failed'));
          }
        });
  }

  Future<void> _performImportInBackground(
      BuildContext parentContext, Map<String, dynamic> keys) async {
    // Capture colors based on current theme before any async operations
    late final Color successTextColor;
    late final Color errorTextColor;
    late final Color backgroundColor;

    try {
      // Theme.of(parentContext).brightness == Brightness.dark;
      successTextColor = _getSuccessTextColor(parentContext);
      errorTextColor = _getErrorTextColor(parentContext);
      backgroundColor = _getSnackBarBackgroundColor(parentContext);

      final dynamic cesiumCards = keys['cesiumCards'];
      final dynamic v2Wallets = keys['v2Wallets'];
      final List<dynamic>? contacts = keys['contacts'] as List<dynamic>?;
      importContacts(contacts, parentContext);

      int imported = 0;
      final List<String> skipped = <String>[];

      // Import V1 wallets
      if (cesiumCards != null) {
        final List<dynamic> cesiumCardList =
            jsonDecode(cesiumCards as String) as List<dynamic>;
        for (final dynamic cesiumCard in cesiumCardList) {
          final bool result = importWalletToSharedPrefs(
              parentContext, cesiumCard as Map<String, dynamic>);
          if (result) {
            imported += 1;
          } else {
            final String name = cesiumCard['name'] as String? ??
                cesiumCard['pubKey'] as String? ??
                'Unknown';
            skipped.add(name);
          }
        }
      }

      // Import V2 wallets
      if (v2Wallets != null) {
        final List<dynamic> v2WalletList =
            jsonDecode(v2Wallets as String) as List<dynamic>;
        for (final dynamic v2Wallet in v2WalletList) {
          final bool result = await importV2WalletToSharedPrefs(
              parentContext, v2Wallet as Map<String, dynamic>);
          if (result) {
            imported += 1;
          } else {
            final String name = v2Wallet['name'] as String? ??
                v2Wallet['pubKey'] as String? ??
                'Unknown';
            skipped.add(name);
          }
        }
      }

      if (!parentContext.mounted) {
        return;
      }
      // Fallback for single wallet import (old format)
      if (cesiumCards == null && v2Wallets == null) {
        importWalletToSharedPrefs(parentContext, keys);
        imported = 1;
      }

      String message = imported == 0
          ? tr('no_wallets_imported')
          : tr('wallets_imported',
              namedArgs: <String, String>{'number': imported.toString()});

      if (skipped.isNotEmpty) {
        message += '\n${tr('some_wallets_skipped')}';
      }

      if (!parentContext.mounted) {
        return;
      }
      _showGlobalSnackBar(
        message,
        imported == 0 ? errorTextColor : successTextColor,
        backgroundColor,
      );
    } catch (e, stacktrace) {
      logger('Error importing wallet: $e');
      // Note: we still have isDarkMode, errorTextColor, backgroundColor from the beginning
      _showGlobalSnackBar(
        tr('error_importing_wallet'),
        errorTextColor,
        backgroundColor,
      );
      await Sentry.captureException(e, stackTrace: stacktrace);
    }
  }

  void importContacts(List<dynamic>? contacts, BuildContext context) {
    if (contacts != null) {
      final ContactsCubit contactsCubit = context.read<ContactsCubit>();
      final List<Contact> existingContacts = contactsCubit.contacts;
      if (contacts.isNotEmpty) {
        if (existingContacts.isNotEmpty) {
          for (final dynamic contactJson in contacts) {
            final Contact contact =
                Contact.fromJson(contactJson as Map<String, dynamic>);
            if (!contactsCubit.isContact(contact.pubKey)) {
              contactsCubit.addContact(contact);
            } else {
              final Contact storedContact =
                  contactsCubit.getContact(contact.pubKey)!;
              contactsCubit.updateContact(storedContact.merge(contact));
            }
          }
        } else {
          for (final dynamic contactJson in contacts) {
            final Contact contact =
                Contact.fromJson(contactJson as Map<String, dynamic>);
            contactsCubit.addContact(contact);
          }
        }
      }
    }
  }

  bool importWalletToSharedPrefs(
      BuildContext context, Map<String, dynamic> cesiumCard) {
    final dynamic pub = cesiumCard['pub'];
    final String pubKey =
        pub != null ? pub as String : cesiumCard['pubKey'] as String;
    if (!SharedPreferencesHelper().has(pubKey)) {
      final String seed = cesiumCard['seed'] as String? ?? '';
      // The type field helps us preserve whether it was passwordProtected (volatile)
      // If not present, we infer from seed being empty
      final String? typeStr = cesiumCard['type'] as String?;
      final bool isPasswordProtected =
          typeStr == 'v1PasswordProtected' || (typeStr == null && seed.isEmpty);

      // For V1 PasswordProtected (volatile), seed should remain empty
      final String seedToUse = isPasswordProtected ? '' : seed;

      SharedPreferencesHelper().addLegacyWallet(SharedPreferencesHelper()
          .buildLegacyWallet(pubKey: pubKey, seed: seedToUse));
      context
          .read<MultiWalletTransactionCubit>()
          .fetchTransactions(pubKey: pubKey);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> importV2WalletToSharedPrefs(
      BuildContext context, Map<String, dynamic> v2Wallet) async {
    try {
      final String? pubKey = v2Wallet['pubKey'] as String?;
      final String? mnemonic = v2Wallet['mnemonic'] as String?;
      final String? typeStr = v2Wallet['type'] as String?;

      if (pubKey == null || mnemonic == null) {
        logger('V2 wallet missing required fields: pubKey or mnemonic');
        return false;
      }

      // Check if wallet already exists
      if (SharedPreferencesHelper().has(pubKey)) {
        logger('V2 wallet already exists: $pubKey');
        return false;
      }

      // Parse and maintain the original account type
      AccountType accountType;
      if (typeStr == 'v2PasswordProtected') {
        accountType = AccountType.v2PasswordProtected;
      } else if (typeStr == 'v2PasswordLess') {
        accountType = AccountType.v2PasswordLess;
      } else {
        // Default to password-less if type is not specified
        logger('V2 wallet type not specified, defaulting to passwordLess');
        accountType = AccountType.v2PasswordLess;
      }

      // Import the wallet using the mnemonic with the original type
      // For v2PasswordProtected, this will request unlock from the user
      await SharedPreferencesHelper().importWalletFromMnemonic(
        mnemonic,
        accountType,
      );

      if (!context.mounted) {
        return false;
      }

      // Fetch transactions for the imported wallet
      context
          .read<MultiWalletTransactionCubit>()
          .fetchTransactions(pubKey: pubKey);

      return true;
    } catch (e, stacktrace) {
      logger('Error importing V2 wallet: $e');
      await Sentry.captureException(e, stackTrace: stacktrace);
      return false;
    }
  }
}

Future<void> showSelectImportMethodDialog(
    BuildContext context, int returnTo) async {
  final ImportType? importType = await showDialog<ImportType>(
    context: context,
    builder: (BuildContext c) => const SelectImportMethodDialog(),
  );
  if (importType != null) {
    if (!context.mounted) {
      // FIXME when I call this form add wallet assistant, after a pop, the context is not mounted
      // But if a show this dialog from another screen, it works
      return;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        if (importType == ImportType.fileZelkovaV1Export) {
          return const ImportDialog();
        } else {
          return ImportClipboardDialog(
            importType: importType,
            onImport: (String textToImport) async {
              final String preview = textToImport.length > 50
                  ? textToImport.substring(0, 50)
                  : textToImport;
              loggerDev('onImport callback started with text: $preview...');
              if (validateKey(textToImport)) {
                loggerDev('Recognized as a valid key');
                if (!SharedPreferencesHelper().has(textToImport)) {
                  await showAuthCesiumWalletDialog(
                      context, textToImport, returnTo);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(tr('wallet_already_imported'))),
                  );
                }
                return;
              }

              if (isValidMnemonic(textToImport)) {
                loggerDev('Recognized as a valid mnemonic');
                try {
                  await SharedPreferencesHelper().importWalletFromMnemonic(
                    textToImport,
                    AccountType.v2PasswordProtected,
                  );
                  if (!context.mounted) {
                    return;
                  }
                  context.replaceSnackbar(
                    content: Text(tr('wallet_imported')),
                    backgroundColor: _getSnackBarBackgroundColor(context),
                  );
                  Navigator.of(context).pop(true);
                } on WalletAlreadyExistsException {
                  if (!context.mounted) {
                    return;
                  }
                  context.replaceSnackbar(
                    content: Text(tr('wallet_already_imported')),
                    backgroundColor: _getSnackBarBackgroundColor(context),
                  );
                  Navigator.of(context).pop(true);
                } catch (e, st) {
                  logger('Error importing mnemonic: $e');
                  await Sentry.captureException(e, stackTrace: st);
                  if (!context.mounted) {
                    return;
                  }
                  context.replaceSnackbar(
                    content: Text(tr('error_importing_wallet')),
                    backgroundColor: _getSnackBarBackgroundColor(context),
                  );
                }
                return;
              }

              // Fallback: route non-JSON / non-mnemonic / non-pubkey to ImportDialog
              loggerDev(
                  'Not recognized as key or mnemonic, opening ImportDialog');
              loggerDev(
                  'About to call showDialog with context: ${context.runtimeType}');
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  loggerDev('ImportDialog builder called');
                  return ImportDialog(textToImport: textToImport);
                },
              ).then((dynamic result) {
                loggerDev('ImportDialog closed with result: $result');
              }).catchError((Object e) {
                loggerDev('ImportDialog error: $e');
              });
            },
          );
        }
      },
    );
  }
}

Future<String> importWallet(BuildContext context,
    [List<String> allowedExtensions = const <String>['.json'],
    String messageKey = 'select_file_to_import']) async {
  try {
    Future<String> importWithFilePicker() async {
      final String extension = allowedExtensions.isNotEmpty
          ? allowedExtensions.first.replaceAll('.', '')
          : 'json';
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: <String>[extension],
        withData: true,
      );

      if (result == null || result.files.isEmpty) {
        logger('File selection cancelled by user');
        return '';
      }

      final PlatformFile file = result.files.first;
      final Uint8List? bytes = file.bytes;
      if (bytes == null || bytes.isEmpty) {
        logger('File does not contain data');
        return '';
      }

      return utf8.decode(bytes);
    }

    if (isAndroid()) {
      return importWithFilePicker();
    }

    final Directory? directory = await getZelkovaDownloadDirectory();
    if (directory == null) {
      logger('Downloads directory not found');
      try {
        return await importWithFilePicker();
      } catch (e) {
        logger('FilePicker fallback also failed: $e');
        return '';
      }
    }

    logger('appDocDir: ${directory.path}');

    if (!context.mounted) {
      return '';
    }

    final String? filePath = await FilesystemPicker.openDialog(
      title: tr(messageKey),
      context: context,
      rootDirectory: directory,
      showGoUp: true,
      fsType: FilesystemType.all,
      allowedExtensions: allowedExtensions,
      fileTileSelectMode: FileTileSelectMode.wholeTile,
    );

    if (filePath == null || filePath.isEmpty) {
      logger('File selection cancelled by user');
      return '';
    }

    final File file = File(filePath);

    // Read the file directly without checking exists() (avoid slow async I/O)
    // If the file doesn't exist, readAsString will throw an exception
    final String jsonString = await file.readAsString();

    // Log the content if not in release mode
    if (!kReleaseMode) {
      // logger(jsonString);
    }

    return jsonString;
  } catch (e, stacktrace) {
    logger('Error importing wallet $e');
    await Sentry.captureException(e, stackTrace: stacktrace);
    return '';
  }
}

// Quick check to avoid jsonDecode on obvious non-JSON inputs.
bool looksLikeJson(String s) {
  final String t = s.trimLeft();
  return t.startsWith('{') || t.startsWith('[');
}
