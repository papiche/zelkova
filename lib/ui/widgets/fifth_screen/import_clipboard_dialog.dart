import 'package:bip39_multi_nullsafety/bip39_multi_nullsafety.dart' as bip39;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../g1/g1_helper.dart';
import '../../clipboard_helper.dart';
import '../generic_qr_button.dart';
import 'import_types.dart';

class ImportClipboardDialog extends StatefulWidget {
  const ImportClipboardDialog(
      {super.key, required this.onImport, required this.importType});

  final Function(String) onImport;
  final ImportType importType;

  @override
  State<ImportClipboardDialog> createState() => _ImportClipboardDialogState();
}

class _ImportClipboardDialogState extends State<ImportClipboardDialog> {
  final TextEditingController _textController = TextEditingController();
  String? _errorMessage;

  void _validateAndImport() {
    final String text = _textController.text;

    switch (widget.importType) {
      case ImportType.clipboardG1nkgoV1Export:
        if (text.isEmpty) {
          setState(() {
            _errorMessage = tr('error_empty_g1nkgo');
          });
          return;
        }
        break;
      case ImportType.clipboardPubKey:
        if (!validateKey(text)) {
          setState(() {
            _errorMessage = tr('error_invalid_pubkey');
          });
          return;
        }
        break;
      case ImportType.clipboardMnemonic:
        if (text.split(' ').length < 12 ||
            bip39.validateMnemonic(text) == false) {
          setState(() {
            _errorMessage = tr('error_invalid_mnemonic');
          });
          return;
        }
        break;
      case ImportType.fileG1nkgoV1Export:
        throw UnimplementedError('Other import types are not supported here');
    }

    setState(() {
      _errorMessage = null;
    });
    Navigator.of(context).pop(text);
    widget.onImport(text);
  }

  Future<void> _pasteFromClipboard() async {
    pasteFromClipboard(onPaste: (String? value) {
      setState(() {
        if (value != null) {
          _textController.text = value;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String title;
    String description;

    switch (widget.importType) {
      case ImportType.clipboardG1nkgoV1Export:
        title = tr('import_wallet_from_clipboard');
        description = tr('import_wallet_from_clipboard_desc');
        break;
      case ImportType.clipboardPubKey:
        title = tr('import_wallet_from_clipboard_pubkey');
        description = tr('import_wallet_from_clipboard_pubkey_desc');
        break;
      case ImportType.clipboardMnemonic:
        title = tr('import_wallet_from_clipboard_mnemonic');
        description = tr('import_wallet_from_clipboard_mnemonic_desc');
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
              GenericQrButton(
                onKeyScanned: (String key) {
                  Navigator.of(context).pop(key);
                  widget.onImport(key);
                },
              ),
              TextButton(
                child: Text(tr('import')),
                onPressed: () {
                  _validateAndImport();
                  // Navigator.of(context).pop(_textController.text);
                  // widget.onImport(_textController.text);
                },
              ),
            ])
      ],
    );
  }
}
