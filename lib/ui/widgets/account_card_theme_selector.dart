import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../data/models/wallet.dart';
import '../../data/models/wallet_themes.dart';
import 'first_screen/account_card_selector_item.dart';

class AccountCardThemeSelector extends StatelessWidget {
  const AccountCardThemeSelector(
      {super.key, required this.card, required this.onTap});

  final Wallet card;
  final Function(WalletTheme) onTap;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount:
            ResponsiveBreakpoints.of(context).largerThan(MOBILE) ? 4 : 2,
        childAspectRatio: 1.58,
      ),
      itemCount: WalletThemes.themes.length,
      itemBuilder: (BuildContext context, int index) {
        final WalletTheme theme = WalletThemes.themes[index];
        return GestureDetector(
          onTap: () {
            onTap(theme);
            Navigator.pop(context);
          },
          child: Center(
            child: AccountCardSelectorItem(theme: WalletThemes.themes[index]),
          ),
        );
      },
    );
  }
}
