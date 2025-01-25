import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import 'fifth_screen/import_dialog.dart';

class WalletOptionsDialog extends StatelessWidget {
  const WalletOptionsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(tr('wallet_options_title')),
        ],
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.add),
              title: Text(tr('create_wallet_option')),
              subtitle: Text(tr('create_wallet_description')),
              onTap: () => _showCreateWalletOptions(context),
            ),
            ListTile(
                leading: const Icon(Icons.import_export),
                title: Text(tr('import_wallet_option')),
                subtitle: Text(tr('import_wallet_description')),
                onTap: () => showSelectImportMethodDialog(context, 0)),
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

  void _showCreateWalletOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(tr('create_wallet_title')),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Symbols.money_bag),
                  title: Text(tr('create_no_password_option')),
                  subtitle: Text(tr('create_no_password_description')),
                  onTap: () => Navigator.of(context).pop('no_password'),
                ),
                ListTile(
                  leading: const Icon(Icons.lock),
                  title: Text(tr('create_with_password_option')),
                  subtitle: Text(tr('create_with_password_description')),
                  onTap: () => Navigator.of(context).pop('with_password'),
                ),
                ListTile(
                  leading: const Icon(Icons.password),
                  title: Text(tr('create_with_mnemonics_option')),
                  subtitle: Text(tr('create_with_mnemonics_description')),
                  onTap: () => Navigator.of(context).pop('with_mnemonics'),
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
      },
    );
  }
}
