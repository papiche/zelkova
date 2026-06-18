import 'package:flutter/material.dart';

import 'multipass_recovery_screen.dart';
import 'wallet_creation_screen.dart';

/// Écran d'accueil du onboarding — affiché quand aucun compte n'est enregistré.
/// Deux chemins mutuellement exclusifs :
///   1. Récupérer un MULTIPASS existant (email → home station auto-détectée)
///   2. Créer un nouveau MULTIPASS (flux ATOMIC complet)
class OnboardingChoiceScreen extends StatelessWidget {
  const OnboardingChoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Spacer(flex: 3),

              // ── En-tête ────────────────────────────────────────────────────
              const Text(
                '🌌',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 64),
              ),
              const SizedBox(height: 20),
              Text(
                'Avez-vous déjà un MULTIPASS ?',
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Choisissez comment démarrer',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: cs.onSurface.withValues(alpha: 0.55),
                ),
              ),

              const Spacer(flex: 2),

              // ── Chemin 1 : récupération ────────────────────────────────────
              _PathCard(
                emoji: '📧',
                title: 'Récupérer mon MULTIPASS',
                subtitle: 'Mon compte a été créé sur UPlanet.\n'
                    "J'indique mon email et ma station Astroport.",
                color: cs.primaryContainer,
                labelColor: cs.onPrimaryContainer,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const MultipassRecoveryScreen(),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ── Séparateur "ou" ────────────────────────────────────────────
              Row(
                children: <Widget>[
                  const Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Text(
                      'ou',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: cs.onSurface.withValues(alpha: 0.4),
                      ),
                    ),
                  ),
                  const Expanded(child: Divider()),
                ],
              ),

              const SizedBox(height: 24),

              // ── Chemin 2 : nouvelle inscription ATOMIC ─────────────────────
              _PathCard(
                emoji: '✨',
                title: 'Créer mon MULTIPASS',
                subtitle: 'Nouveau sur UPlanet ? Créez votre\n'
                    'identité souveraine avec le profil Kin.',
                color: cs.tertiaryContainer,
                labelColor: cs.onTertiaryContainer,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const WalletCreationScreen(),
                  ),
                ),
              ),

              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Carte de chemin cliquable ─────────────────────────────────────────────────

class _PathCard extends StatelessWidget {
  const _PathCard({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.labelColor,
    required this.onTap,
  });

  final String emoji;
  final String title;
  final String subtitle;
  final Color color;
  final Color labelColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          child: Row(
            children: <Widget>[
              Text(emoji, style: const TextStyle(fontSize: 40)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: labelColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.45,
                        color: labelColor.withValues(alpha: 0.72),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.chevron_right_rounded,
                color: labelColor.withValues(alpha: 0.55),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
