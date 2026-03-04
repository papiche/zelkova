import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../g1/g1_helper.dart';
import '../../../g1/g1_v2_helper.dart';
import '../../clipboard_helper.dart';
import '../../logger.dart';
import '../../ui_helpers.dart';
import '../generic_qr_button.dart';
import 'import_types.dart';

class ImportClipboardDialog extends StatefulWidget {
  const ImportClipboardDialog(
      {super.key, required this.onImport, required this.importType});

  final Future<void> Function(String) onImport;

  final ImportType importType;

  @override
  State<ImportClipboardDialog> createState() => _ImportClipboardDialogState();
}

class _ImportClipboardDialogState extends State<ImportClipboardDialog> {
  final TextEditingController _textController = TextEditingController();
  String? _errorMessage;
  bool _isImporting = false; // optional guard

  Future<void> _validateAndImport() async {
    loggerDev('_validateAndImport called, _isImporting: $_isImporting');
    if (_isImporting) {
      loggerDev('Already importing, returning');
      return;
    }
    final String text = _textController.text;
    final String preview = text.length > 50 ? text.substring(0, 50) : text;
    loggerDev('Text to validate: $preview${text.length > 50 ? '...' : ''}');

    switch (widget.importType) {
      case ImportType.clipboardG1nkgoV1Export:
        if (text.isEmpty) {
          loggerDev('Error: empty g1nkgo export');
          setState(() => _errorMessage = tr('error_empty_g1nkgo'));
          return;
        }
        break;
      case ImportType.clipboardPubKey:
        final bool isValid = validateKey(text);
        loggerDev('Validating pubkey: $isValid');
        if (!isValid) {
          loggerDev('Error: invalid pubkey');
          setState(() => _errorMessage = tr('error_invalid_pubkey'));
          return;
        }
        break;
      case ImportType.clipboardMnemonic:
        final int wordCount = text.split(' ').length;
        final bool isValidMnem = isValidMnemonic(text);
        loggerDev(
            'Validating mnemonic: wordCount=$wordCount, isValid=$isValidMnem');
        if (wordCount < 12 || !isValidMnem) {
          loggerDev('Error: invalid mnemonic');
          setState(() => _errorMessage = tr('error_invalid_mnemonic'));
          return;
        }
        break;
      case ImportType.fileG1nkgoV1Export:
        throw UnimplementedError('Not supported here');
    }

    loggerDev('Validation passed, starting import');
    setState(() {
      _errorMessage = null;
      _isImporting = true;
    });

    try {
      loggerDev('Calling widget.onImport');
      await widget.onImport(text);
      loggerDev('Import completed successfully');
      if (!mounted) {
        return;
      }
      Navigator.of(context).pop(true); // close the dialog AFTER import
    } catch (e, st) {
      loggerDev('Error during import', error: e, stackTrace: st);
      if (mounted) {
        setState(() => _errorMessage = 'Import error: $e');
      }
    } finally {
      if (mounted) {
        setState(() => _isImporting = false);
      }
    }
  }

  Future<void> _pasteFromClipboard() async {
    loggerDev('_pasteFromClipboard called');
    pasteFromClipboard(onPaste: (String? value) {
      loggerDev('Paste callback received');
      setState(() {
        if (value != null) {
          _textController.text = value;
          loggerDev('TextController updated');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String title;
    String description;
    bool showQrButton = false;

    switch (widget.importType) {
      case ImportType.clipboardG1nkgoV1Export:
        title = tr('import_wallet_from_clipboard');
        description = tr('import_wallet_from_clipboard_desc');
        showQrButton = false;
        break;
      case ImportType.clipboardPubKey:
        title = tr('import_wallet_from_clipboard_pubkey');
        description = tr('import_wallet_from_clipboard_pubkey_desc');
        showQrButton = true;
        break;
      case ImportType.clipboardMnemonic:
        title = tr('import_wallet_from_clipboard_mnemonic');
        description = tr('import_wallet_from_clipboard_mnemonic_desc');
        showQrButton = false;
      case ImportType.fileG1nkgoV1Export:
        throw UnimplementedError('Other import types are not supported here');
    }
    return AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: _textController,
            maxLines: 4,
            decoration: InputDecoration(
                hintText: description, errorText: _errorMessage),
          ),
          const SizedBox(height: 10),
          if (!isIOSWeb())
            TextButton(
              onPressed: _pasteFromClipboard,
              child: Text(tr('paste')),
            ),
        ],
      ),
      actions: <Widget>[
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              if (showQrButton)
                GenericQrButton(
                  onKeyScanned: (String key) async {
                    Navigator.of(context).pop(true);
                    await widget.onImport(key);
                  },
                ),
              TextButton(
                onPressed: _isImporting ? null : _validateAndImport,
                child: _isImporting
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(tr('import')),
              ),
            ])
      ],
    );
  }
}
