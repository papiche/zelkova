import 'package:flutter/material.dart';

import '../../screens/identity_keys_screen.dart';
import 'info_card.dart';

/// Carte "Mode Expert" ouvrant l'écran nsec/PASS (IdentityKeysScreen).
/// Voir fifth_screen.dart — affichée uniquement si state.expertMode.
class IdentityKeysCard extends StatelessWidget {
  const IdentityKeysCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
              builder: (BuildContext context) => const IdentityKeysScreen()),
        );
      },
      child: const InfoCard(
        title: 'Identité technique (nsec / PASS)',
        translate: false,
        icon: Icons.vpn_key,
      ),
    );
  }
}
