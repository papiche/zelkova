import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/app_cubit.dart';
import 'import_types.dart';

class SelectImportMethodDialog extends StatelessWidget {
  const SelectImportMethodDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(tr('select_import_method')),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.file_present),
              title: Text(tr('file_import')),
              onTap: () =>
                  Navigator.of(context).pop(ImportType.fileZelkovaV1Export),
            ),
            ListTile(
              leading: const Icon(Icons.content_paste),
              title: Text(tr('clipboard_import')),
              onTap: () =>
                  Navigator.of(context).pop(ImportType.clipboardZelkovaV1Export),
            ),
            ListTile(
              leading: const Icon(Icons.key),
              title: Text(tr('clipboard_import_pubkey')),
              onTap: () =>
                  Navigator.of(context).pop(ImportType.clipboardPubKey),
            ),
            if (context.read<AppCubit>().isV2)
              ListTile(
                leading: const Icon(Icons.password),
                title: Text(tr('clipboard_import_mnemonic')),
                subtitle: Text(tr('clipboard_import_mnemonic_description')),
                onTap: () =>
                    Navigator.of(context).pop(ImportType.clipboardMnemonic),
              ),
          ],
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
