import 'package:flutter/material.dart';

import '../../ui/widgets/first_screen/credit_card_theme_item.dart';
import 'cesium_card.dart';
import 'credit_card_themes.dart';

class CardThemeSelector extends StatelessWidget {
  const CardThemeSelector({super.key, required this.card, required this.onTap});

  final CesiumCard card;
  final Function(CreditCardTheme) onTap;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.58,
      ),
      itemCount: CreditCardThemes.themes.length,
      itemBuilder: (BuildContext context, int index) {
        final CreditCardTheme theme = CreditCardThemes.themes[index];
        return GestureDetector(
          onTap: () {
            onTap(theme);
            Navigator.pop(context);
          },
          child: Center(
            child: CreditCardThemeItem(themeIndex: index),
          ),
        );
      },
    );
  }
}
