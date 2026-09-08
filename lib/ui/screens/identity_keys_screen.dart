import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../shared_prefs_helper_v2.dart';

/// Écran "Mode Expert" affichant le nsec principal et le code PASS du
/// MULTIPASS courant — masqués par défaut, révélables un par un.
///
/// Volontairement absent du flux d'onboarding standard (récupération) :
/// ces secrets techniques ne sont utiles qu'aux utilisateurs avancés (recréer
/// une identité sur un autre client, terminal UPlanet, débogage). Voir
/// multipass_recovery_screen.dart, qui renvoie ici plutôt que d'exposer
/// directement le secret post-récupération.
class IdentityKeysScreen extends StatefulWidget {
  const IdentityKeysScreen({super.key});

  @override
  State<IdentityKeysScreen> createState() => _IdentityKeysScreenState();
}

class _IdentityKeysScreenState extends State<IdentityKeysScreen> {
  bool _loading = true;
  String _nsec = '';
  String _pass = '';
  bool _nsecVisible = false;
  bool _passVisible = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final String? nsec = await SharedPreferencesHelperV2().getNostrNsec();
    final String? pass = await SharedPreferencesHelperV2().getMultipassPass();
    if (!mounted) {
      return;
    }
    setState(() {
      _nsec = nsec ?? '';
      _pass = pass ?? '';
      _loading = false;
    });
  }

  void _copy(String label, String value) {
    Clipboard.setData(ClipboardData(text: value));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$label copié')),
    );
  }

  Widget _secretRow({
    required String label,
    required String value,
    required bool visible,
    required VoidCallback onToggle,
    required String hint,
  }) {
    if (value.isEmpty) {
      return const SizedBox.shrink();
    }
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(label,
                      style: const TextStyle(fontWeight: FontWeight.w700)),
                ),
                IconButton(
                  icon: Icon(
                      visible ? Icons.visibility_off : Icons.visibility,
                      size: 20),
                  tooltip: visible ? 'Masquer' : 'Afficher',
                  onPressed: onToggle,
                ),
                IconButton(
                  icon: const Icon(Icons.copy, size: 20),
                  tooltip: 'Copier',
                  onPressed: () => _copy(label, value),
                ),
              ],
            ),
            SelectableText(
              visible ? value : '•' * value.length.clamp(0, 48),
              style: TextStyle(
                fontSize: 13,
                fontFamily: 'monospace',
                letterSpacing: visible ? 0 : 2,
                color: cs.onSurface,
              ),
            ),
            const SizedBox(height: 4),
            Text(hint,
                style: TextStyle(
                    fontSize: 11,
                    color: cs.onSurface.withValues(alpha: 0.6))),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Identité technique')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Card(
                    color: Theme.of(context).colorScheme.errorContainer,
                    child: const Padding(
                      padding: EdgeInsets.all(12),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.warning_amber_rounded, size: 20),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Ne partagez jamais ces informations. Quiconque les possède contrôle votre MULTIPASS.',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _secretRow(
                    label: '🔑 Clé privée (nsec)',
                    value: _nsec,
                    visible: _nsecVisible,
                    onToggle: () =>
                        setState(() => _nsecVisible = !_nsecVisible),
                    hint:
                        'Identité NOSTR principale — signe vos actions et protège votre portefeuille ẐEN.',
                  ),
                  _secretRow(
                    label: '🔢 Code PASS',
                    value: _pass,
                    visible: _passVisible,
                    onToggle: () =>
                        setState(() => _passVisible = !_passVisible),
                    hint:
                        "Reçu par email à la création du MULTIPASS — permet de le récupérer depuis n'importe quel terminal UPlanet ou une autre application (ex. cabine-33).",
                  ),
                  if (_nsec.isEmpty && _pass.isEmpty)
                    const Padding(
                      padding: EdgeInsets.only(top: 24),
                      child: Center(
                        child: Text(
                          'Aucune information disponible pour ce compte.',
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}
