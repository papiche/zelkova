import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../screens/multipass_recovery_screen.dart';

/// URL du site de création de compte UPlanet. Zelkova ne crée jamais de
/// MULTIPASS lui-même — y compris pour les comptes legacy (wallet Cesium
/// importé avant l'existence du MULTIPASS) détectés ici.
const String _kQoOpUrl = 'https://qo-op.com';

void showMultipassOnboardingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => const MultipassOnboardingDialog(),
  );
}

/// Dialog affiché une fois pour tout compte local sans MULTIPASS (nsec
/// absent). Ne propose plus de créer un MULTIPASS in-app : uniquement un
/// lien vers qo-op.com (création) et un raccourci vers l'écran de
/// récupération (email + code PASS) pour un MULTIPASS déjà existant.
class MultipassOnboardingDialog extends StatelessWidget {
  const MultipassOnboardingDialog({super.key});

  Future<void> _openQoOp() async {
    final Uri uri = Uri.parse(_kQoOpUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _goToRecovery(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const MultipassRecoveryScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Activez votre MULTIPASS'),
      content: const Text(
        'Ce portefeuille ne possède pas encore d’identité MULTIPASS '
        '(NOSTR + ẐEN). Créez-en un sur qo-op.com, ou récupérez-en un '
        'existant avec votre email et votre code PASS.',
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Plus tard'),
        ),
        TextButton.icon(
          onPressed: _openQoOp,
          icon: const Icon(Icons.open_in_new, size: 16),
          label: const Text('qo-op.com'),
        ),
        FilledButton(
          onPressed: () => _goToRecovery(context),
          child: const Text('J’ai un MULTIPASS'),
        ),
      ],
    );
  }
}
