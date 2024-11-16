import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../widgets/fifth_screen/export_dialog.dart';

class SelectExportMethodDialog extends StatelessWidget {
  const SelectExportMethodDialog(
      {super.key, this.onlyOneWalletSelected = false});

  final bool onlyOneWalletSelected;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  tr('select_export_method'),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextButton.icon(
                    icon: const Icon(Icons.file_present),
                    label: Text(tr('file_export')),
                    onPressed: () => Navigator.of(context).pop(ExportType.file),
                  ),
                  TextButton.icon(
                    icon: const Icon(Icons.content_paste),
                    label: Text(tr('clipboard_export')),
                    onPressed: () =>
                        Navigator.of(context).pop(ExportType.clipboard),
                  ),
                  TextButton.icon(
                    icon: const Icon(Icons.share),
                    label: Text(tr('share_export')),
                    onPressed: () =>
                        Navigator.of(context).pop(ExportType.share),
                  ),
                ],
              ),
              if (onlyOneWalletSelected) _buildKeyExportContent(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildKeyExportContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Divider(),
          const SizedBox(height: 8),
          Text(
            tr('cesium_compatible_exports'),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          _buildExportOption(
            context,
            ExportType.pubsec,
            tr('export_pubsec_format'),
            tr('export_pubsec_format_description'),
          ),
          _buildExportOption(
            context,
            ExportType.wif,
            tr('export_wif_format'),
            tr('export_wif_format_description'),
          ),
          _buildExportOption(
            context,
            ExportType.ewif,
            tr('export_ewif_format'),
            tr('export_ewif_format_description'),
          ),
        ],
      ),
    );
  }

  Widget _buildExportOption(
    BuildContext context,
    ExportType type,
    String buttonText,
    String descriptionText,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextButton.icon(
          icon: const Icon(Icons.article_outlined),
          label: Text(buttonText),
          onPressed: () {
            Navigator.of(context).pop(type);
          },
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
          child: Text(
            descriptionText,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[700],
                ),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}
