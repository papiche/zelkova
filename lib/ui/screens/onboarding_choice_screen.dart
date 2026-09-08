import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'multipass_recovery_screen.dart';

/// URL du site de création de compte UPlanet. Zelkova ne crée plus de
/// MULTIPASS lui-même : seule la récupération (email + code PASS) est
/// proposée dans l'app, pour simplifier l'UX et éviter la duplication des
/// parcours de création côté client.
const String _kQoOpUrl = 'https://qo-op.com';

Future<void> _openQoOp() async {
  final Uri uri = Uri.parse(_kQoOpUrl);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

/// Écran d'accueil du onboarding — affiché quand aucun compte n'est enregistré.
/// Présente UPlanet, explique le MULTIPASS, puis propose de récupérer un
/// MULTIPASS existant (email + code PASS → home station via NOSTR). La
/// création d'un nouveau MULTIPASS se fait exclusivement sur qo-op.com.
class OnboardingChoiceScreen extends StatelessWidget {
  const OnboardingChoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    final double vp = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: vp * 0.06),

              // ── Logo & titre ───────────────────────────────────────────────
              const _UPlanetHero(),
              const SizedBox(height: 28),

              // ── Proposition de valeur ──────────────────────────────────────
              Text(
                'Votre identité souveraine\ndans une économie coopérative',
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium?.copyWith(
                  height: 1.4,
                  color: cs.onSurface.withValues(alpha: 0.72),
                ),
              ),
              const SizedBox(height: 32),

              // ── Ce qu'est le MULTIPASS ─────────────────────────────────────
              _InfoCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        const Text('🔑', style: TextStyle(fontSize: 20)),
                        const SizedBox(width: 10),
                        Text(
                          'Votre MULTIPASS',
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: cs.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Une identité NOSTR et un portefeuille ẐEN générés à '
                      'partir de votre email et de votre position. '
                      'Aucun mot de passe, aucun serveur central. '
                      'Votre identité vous appartient.',
                      style: theme.textTheme.bodySmall?.copyWith(
                        height: 1.55,
                        color: cs.onSurface.withValues(alpha: 0.75),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // ── Services débloqués ─────────────────────────────────────────
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: const <_ServiceChip>[
                  _ServiceChip(icon: '⚛', label: 'ATOM4LOVE'),
                  _ServiceChip(icon: '📰', label: 'KIN.news'),
                  _ServiceChip(icon: '🔮', label: 'Cabine-33'),
                  _ServiceChip(icon: '🌍', label: 'Réseau NOSTR'),
                  _ServiceChip(icon: '💎', label: 'Ẑelkova Wallet'),
                  _ServiceChip(icon: '🪙', label: 'G1 / ẐEN'),
                ],
              ),
              const SizedBox(height: 28),

              // ── Comment ça marche ──────────────────────────────────────────
              _InfoCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        const Text('⚡', style: TextStyle(fontSize: 18)),
                        const SizedBox(width: 8),
                        Text(
                          'Comment ça marche ?',
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const _Step(
                      n: '1',
                      text: 'Vous créez votre MULTIPASS sur qo-op.com — '
                          'identité NOSTR + portefeuille ẐEN générés en quelques secondes.',
                    ),
                    const _Step(
                      n: '2',
                      text: 'Vous recevez un code PASS par email — gardez-le précieusement.',
                    ),
                    const _Step(
                      n: '3',
                      text: 'Dans Ẑelkova, saisissez votre email et ce code PASS '
                          'pour retrouver votre MULTIPASS et tous les services UPlanet.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 36),

              // ── Séparateur "Pour commencer" ────────────────────────────────
              Row(
                children: <Widget>[
                  Expanded(
                    child: Divider(color: cs.outline.withValues(alpha: 0.4)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Text(
                      'Pour commencer',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: cs.onSurface.withValues(alpha: 0.45),
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(color: cs.outline.withValues(alpha: 0.4)),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // ── Récupération du MULTIPASS ───────────────────────────────────
              _PathCard(
                emoji: '📧',
                title: 'Récupérer mon MULTIPASS',
                subtitle: 'Saisissez votre email et votre code PASS — votre\n'
                    'station Astroport est détectée automatiquement via le réseau.',
                color: cs.primaryContainer,
                labelColor: cs.onPrimaryContainer,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const MultipassRecoveryScreen(),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // ── Pas encore de MULTIPASS ─────────────────────────────────────
              Center(
                child: TextButton.icon(
                  onPressed: _openQoOp,
                  icon: const Icon(Icons.open_in_new, size: 16),
                  label: const Text('Pas encore de MULTIPASS ? Créez-en un sur qo-op.com'),
                  style: TextButton.styleFrom(
                    foregroundColor: cs.onSurface.withValues(alpha: 0.65),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ── Pied de page ───────────────────────────────────────────────
              Text(
                'Coopérative UPlanet · AGPL-3.0 · Sans serveur central',
                textAlign: TextAlign.center,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: cs.onSurface.withValues(alpha: 0.28),
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Hero UPlanet ──────────────────────────────────────────────────────────────

class _UPlanetHero extends StatelessWidget {
  const _UPlanetHero();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Column(
      children: <Widget>[
        // Globe stylisé avec superposition ẐEN
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: <Color>[
                    cs.primary.withValues(alpha: 0.22),
                    cs.primary.withValues(alpha: 0.06),
                  ],
                ),
                border: Border.all(
                  color: cs.primary.withValues(alpha: 0.35),
                  width: 1.5,
                ),
              ),
            ),
            const Text('🌐', style: TextStyle(fontSize: 42)),
            Positioned(
              right: 14,
              bottom: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(
                  color: cs.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'ẐEN',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    color: cs.onPrimary,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Text(
          'Bienvenue sur UPlanet',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w900,
                letterSpacing: -0.5,
              ),
        ),
      ],
    );
  }
}

// ── Info card ─────────────────────────────────────────────────────────────────

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: cs.outline.withValues(alpha: 0.18)),
      ),
      child: child,
    );
  }
}

// ── Step item ─────────────────────────────────────────────────────────────────

class _Step extends StatelessWidget {
  const _Step({required this.n, required this.text});
  final String n;
  final String text;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 22,
            height: 22,
            margin: const EdgeInsets.only(top: 1, right: 10),
            decoration: BoxDecoration(
              color: cs.primary.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              n,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: cs.primary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    height: 1.5,
                    color: cs.onSurface.withValues(alpha: 0.72),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Service chip ──────────────────────────────────────────────────────────────

class _ServiceChip extends StatelessWidget {
  const _ServiceChip({required this.icon, required this.label});
  final String icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: cs.secondaryContainer.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: cs.outline.withValues(alpha: 0.22)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(icon, style: const TextStyle(fontSize: 13)),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: cs.onSecondaryContainer,
            ),
          ),
        ],
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
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: Row(
            children: <Widget>[
              Text(emoji, style: const TextStyle(fontSize: 36)),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
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
                        color: labelColor.withValues(alpha: 0.70),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: labelColor.withValues(alpha: 0.50),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
