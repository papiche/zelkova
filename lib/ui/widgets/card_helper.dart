import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../data/models/stored_account.dart';
import '../../shared_prefs_helper.dart';
import '../secure_unlock_widget.dart';
import 'cesium_auth_dialog.dart';

IconData iconByAccountType(StoredAccount account) {
  return account.type.isPasswordProtected
      ? SharedPreferencesHelper().isLocked(account)
          ? Icons.lock
          : Icons.lock_open
      : Symbols.money_bag;
}

GestureDetector walletIconByType(
    BuildContext context, StoredAccount account, double size, bool allowAuth) {
  final String tooltipMessage = account.type.isPasswordProtected
      ? SharedPreferencesHelper().isLocked(account)
          ? tr('tooltip_wallet_locked')
          : tr('tooltip_wallet_unlocked')
      : tr('tooltip_wallet_password_less');

  return GestureDetector(
      onTap: () async {
        if (allowAuth) {
          if (!SharedPreferencesHelper().isLocked()) {
            if (account.type == AccountType.v2PasswordProtected) {
              SharedPreferencesHelper().passwordKey = null;
            } else {
              // TODO
            }
          } else {
            if (account.type == AccountType.v2PasswordProtected) {
              await walletV2Auth();
            } else {
              await walletV1Auth(context);
            }
          }
          SharedPreferencesHelper().notifyListeners();
        }
      },
      child: Tooltip(
        message: tooltipMessage,
        child: Icon(
          iconByAccountType(account),
          color: Colors.white.withValues(alpha: 0.45),
          size: size,
        ),
      ));
}
