import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../ui/widgets/first_screen/credit_card_selector_item.dart';
import 'cesium_card.dart';
import 'credit_card_themes.dart';

class CardThemeSelector extends StatelessWidget {
  const CardThemeSelector({super.key, required this.card, required this.onTap});

  final AccountCard card;
  final Function(AccountCardTheme) onTap;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount:
            ResponsiveBreakpoints.of(context).largerThan(MOBILE) ? 4 : 2,
        childAspectRatio: 1.58,
      ),
      itemCount: CreditCardThemes.themes.length,
      itemBuilder: (BuildContext context, int index) {
        final AccountCardTheme theme = CreditCardThemes.themes[index];
        return GestureDetector(
          onTap: () {
            onTap(theme);
            Navigator.pop(context);
          },
          child: Center(
            child:
                CreditCardSelectorItem(theme: CreditCardThemes.themes[index]),
          ),
        );
      },
    );
  }
}
