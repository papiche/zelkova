import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../data/models/app_cubit.dart';
import '../../shared_prefs_helper_v2.dart';
import '../secure_unlock_widget.dart';
import 'fifth_screen/import_dialog.dart';

class WalletOptionsDialog extends StatelessWidget {
  const WalletOptionsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isV2 = context.read<AppCubit>().isV2;
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
            if (isV2)
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
                onTap: () {
                  final BuildContext rootContext =
                      Navigator.of(context).context;
                  Navigator.of(context).pop();
                  Future<dynamic>.delayed(const Duration(milliseconds: 10), () {
                    if (rootContext.mounted) {
                      showSelectImportMethodDialog(rootContext, 0);
                    }
                  });
                })
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

  void _showCreateWalletOptions(BuildContext orgContext) {
    Navigator.of(orgContext).pop();
    showDialog(
      context: orgContext,
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
                  onTap: () async {
                    await SharedPreferencesHelperV2()
                        .createV2PasswordLessAccount();
                    if (context.mounted) {
                      Navigator.of(context).pop();
                      context.read<AppCubit>().setHasRecentExport(false);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(tr('wallet_created_successfully'))),
                      );
                    }
                  },
                ),
                /*
                  ListTile(
                    leading: const Icon(Icons.lock),
                    title: Text(tr('create_with_password_option')),
                    subtitle: Text(tr('create_with_password_description')),
                    onTap: () => Navigator.of(context).pop('with_password'),
                  ), */
                ListTile(
                    leading: const Icon(Icons.lock),
                    title: Text(tr('create_with_mnemonics_option')),
                    subtitle: Text(tr('create_with_mnemonics_description')),
                    onTap: () async {
                      // Call to unlock dialog
                      await requestUnlockOrSetupAndThenAddWallet(
                          context: context,
                          onAuth: (Uint8List? key) async {
                            if (key == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(tr('lock_or_pass_needed'))),
                              );
                              Navigator.of(context).pop();
                            } else {
                              await SharedPreferencesHelperV2()
                                  .createV2PasswordProtectedAccount(key);
                              if (context.mounted) {
                                Navigator.of(context).pop();
                                context
                                    .read<AppCubit>()
                                    .setHasRecentExport(false);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          tr('wallet_created_successfully'))),
                                );
                              }
                            }
                          });
                    }),
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
