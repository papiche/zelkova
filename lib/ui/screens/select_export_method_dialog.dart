import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../widgets/fifth_screen/export_dialog.dart';

class SelectExportMethodDialog extends StatelessWidget {
  const SelectExportMethodDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(tr('select_export_method')),
      // content: Text(tr('select_export_method_desc')),
      actions: <Widget>[
        TextButton.icon(
            icon: const Icon(Icons.file_present),
            label: Text(tr('file_export')),
            onPressed: () => Navigator.of(context).pop(ExportType.file)),
        TextButton.icon(
            icon: const Icon(Icons.content_paste),
            label: Text(tr('clipboard_export')),
            onPressed: () => Navigator.of(context).pop(ExportType.clipboard)),
        TextButton.icon(
            icon: const Icon(Icons.share),
            label: Text(tr('share_export')),
            onPressed: () => Navigator.of(context).pop(ExportType.share)),
      ],
    );
  }
}
