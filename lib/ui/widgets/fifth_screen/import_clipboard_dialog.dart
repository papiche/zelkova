import 'package:clipboard/clipboard.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ImportClipboardDialog extends StatefulWidget {
  const ImportClipboardDialog({super.key, required this.onImport});

  final Function(String) onImport;

  @override
  State<ImportClipboardDialog> createState() => _ImportClipboardDialogState();
}

class _ImportClipboardDialogState extends State<ImportClipboardDialog> {
  final TextEditingController _textController = TextEditingController();

  Future<void> _pasteFromClipboard() async {
    FlutterClipboard.paste().then((String? value) {
      setState(() {
        if (value != null) {
          _textController.text = value;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(tr('import_wallet_from_clipboard')),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: _textController,
            maxLines: 4,
            decoration: InputDecoration(
                hintText: tr('import_wallet_from_clipboard_desc')),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: _pasteFromClipboard,
            child: Text(tr('paste')),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text(tr('import')),
          onPressed: () {
            Navigator.of(context).pop(_textController.text);
            widget.onImport(_textController.text);
          },
        ),
      ],
    );
  }
}
