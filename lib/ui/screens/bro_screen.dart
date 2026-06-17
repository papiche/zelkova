import 'dart:async';

import 'package:bip340/bip340.dart' as bip340;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../data/models/nostr_message.dart';
import '../../g1/nostr/nostr_keys.dart';
import '../../g1/nostr/nostr_relay_service.dart';
import '../../services/astroport_station_service.dart';
import '../../shared_prefs_helper_v2.dart';
import '../logger.dart';

/// Interface de chat dédiée BRO — IA station via NIP-44.
///
/// BRO (bro_dm_daemon.sh) est le démon IA de la station Astroport.ONE.
/// Il écoute les DMs kind-4 NIP-44 adressés à NODEHEX, chiffre bout-à-bout
/// avec secp256k1, et répond via tous les relays de la constellation.
///
/// ## Architecture du dialogue
///
/// - Questions libres → RAG Qdrant (base de connaissance NextCloud + slots)
/// - Commandes → traitement direct côté daemon (mémoire, génération, etc.)
/// - Latence typique : 2-30 secondes (Ollama local, Qdrant, ComfyUI)
/// - Chiffrement : NIP-44 par défaut (ou NIP-04 si le client a initié en NIP-04)
///
/// ## Commandes reconnues
///
/// | Commande          | Effet                                             |
/// |-------------------|---------------------------------------------------|
/// | (texte libre)     | Question IA avec RAG Qdrant                       |
/// | #mem              | Lister tous les souvenirs enregistrés             |
/// | #mem #N           | Afficher les 5 derniers souvenirs du slot N       |
/// | #rec <texte>      | Mémoriser dans le slot 0 (public)                 |
/// | #rec #N <texte>   | Mémoriser dans le slot N (1-12, sociétaires)      |
/// | #reset            | Effacer tous les souvenirs                        |
/// | #reset #N         | Effacer uniquement le slot N                      |
/// | #badge <skill>    | Générer une image de badge (ComfyUI)              |
/// | #craft <URL>      | Décomposer un tutoriel en recette JSON            |
/// | #rec:<skill>      | Contribuer à la mémoire partagée d'un skill       |
/// | #mem:<skill>      | Lire la mémoire partagée d'un skill               |
/// | [ctx:skill:N] Q   | Question pédagogique avec contexte skill N        |
class BroScreen extends StatefulWidget {
  const BroScreen({super.key});

  @override
  State<BroScreen> createState() => _BroScreenState();
}

class _BroScreenState extends State<BroScreen> {
  final TextEditingController _inputCtrl = TextEditingController();
  final ScrollController _scrollCtrl = ScrollController();
  final List<NostrMessage> _messages = <NostrMessage>[];

  bool _loading = true;
  bool _sending = false;
  bool _broTyping = false;
  String? _errorMsg;

  String? _myHexPubkey;
  String? _myHexPrivkey;
  String? _broHexPubkey;
  String? _stationHostname;

  String? _dmSubId;
  Timer? _typingTimer;

  // Commandes qui s'envoient directement
  static const List<String> _directSend = <String>['#mem'];

  // Commandes qui insèrent un préfixe dans le champ de saisie
  static const Map<String, String> _prefixInsert = <String, String>{
    '#rec ': '#rec ',
    '#badge ': '#badge ',
    '#craft ': '#craft ',
  };

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void dispose() {
    _cancelSubscription();
    _typingTimer?.cancel();
    _inputCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _cancelSubscription() {
    if (_dmSubId != null) {
      NostrRelayService().cancelDmSubscription(_dmSubId!);
      _dmSubId = null;
    }
  }

  Future<void> _init() async {
    // Annuler l'abonnement précédent pour éviter les fuites lors d'un retry
    _cancelSubscription();
    _typingTimer?.cancel();

    if (mounted) {
      setState(() {
        _loading = true;
        _errorMsg = null;
        _broTyping = false;
      });
    }

    try {
      final String? nsec = await SharedPreferencesHelperV2().getNostrNsec();
      if (nsec == null || nsec.isEmpty) {
        _setError('Identité NOSTR manquante — crée ton MULTIPASS d\'abord.');
        return;
      }
      final String hexPriv = NostrKeys.nsecToHex(nsec);
      final String hexPub = bip340.getPublicKey(hexPriv);

      // NODEHEX + hostname depuis 12345.json (une seule requête, résultat mis en cache)
      final Map<String, dynamic>? stationData =
          await AstroportStationService().fetchStationData();
      final String? broHex = stationData?['NODEHEX'] as String?;
      if (broHex == null || broHex.length != 64) {
        _setError('Station BRO introuvable — vérifie ta connexion.');
        return;
      }
      final String? hostname = stationData?['hostname'] as String?;

      logger('[BroScreen] NODEHEX → ${broHex.substring(0, 8)}… station=$hostname');

      if (mounted) {
        setState(() {
          _myHexPubkey = hexPub;
          _myHexPrivkey = hexPriv;
          _broHexPubkey = broHex;
          _stationHostname = hostname;
        });
      }

      await _loadHistory();
    } catch (e) {
      logger('[BroScreen] init error: $e');
      _setError(e.toString());
    }
  }

  void _setError(String msg) {
    if (mounted) {
      setState(() {
        _loading = false;
        _errorMsg = msg;
      });
    }
  }

  Future<void> _loadHistory() async {
    if (_myHexPubkey == null || _myHexPrivkey == null || _broHexPubkey == null) {
      return;
    }
    setState(() => _loading = true);
    try {
      final List<NostrMessage> msgs =
          await NostrRelayService().fetchNip44Messages(
        myHexPubkey: _myHexPubkey!,
        myHexPrivkey: _myHexPrivkey!,
        peerHexPubkey: _broHexPubkey!,
      );
      if (mounted) {
        setState(() {
          _messages
            ..clear()
            ..addAll(msgs);
          _loading = false;
        });
        _scrollToBottom(animated: false);
        _subscribeLive();
      }
    } catch (e) {
      logger('[BroScreen] loadHistory error: $e');
      if (mounted) setState(() => _loading = false);
    }
  }

  void _subscribeLive() {
    if (_myHexPubkey == null || _myHexPrivkey == null || _broHexPubkey == null) {
      return;
    }
    _dmSubId = NostrRelayService().subscribeToDms(
      myHexPubkey: _myHexPubkey!,
      myHexPrivkey: _myHexPrivkey!,
      onMessage: (NostrMessage msg) {
        if (!mounted) return;
        if (msg.senderHex != _broHexPubkey) return;
        // BRO a répondu → arrêter le typing indicator
        _typingTimer?.cancel();
        setState(() {
          _broTyping = false;
          _messages.removeWhere(
              (NostrMessage m) => m.pending && m.content == msg.content);
          _messages.add(msg);
        });
        _scrollToBottom();
      },
    );
  }

  /// Envoie [override] si fourni, sinon le contenu du champ de saisie.
  /// Pour les commandes avec paramètres (#rec, #badge, #craft), utiliser
  /// [_insertPrefix] pour pré-remplir le champ plutôt que d'envoyer directement.
  Future<void> _send([String? override]) async {
    final String text = override ?? _inputCtrl.text.trim();
    if (text.isEmpty || _sending) return;
    if (_myHexPrivkey == null || _broHexPubkey == null) return;

    if (override == null) _inputCtrl.clear();

    final NostrMessage optimistic = NostrMessage(
      id: 'pending_${DateTime.now().millisecondsSinceEpoch}',
      senderHex: _myHexPubkey!,
      recipientHex: _broHexPubkey!,
      content: text,
      createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      pending: true,
    );
    setState(() {
      _messages.add(optimistic);
      _sending = true;
      _broTyping = true;
    });
    _scrollToBottom();

    // Timer de sécurité : BRO répond max en ~30s, 45s avant abandon indicator
    _typingTimer?.cancel();
    _typingTimer = Timer(const Duration(seconds: 45), () {
      if (mounted) setState(() => _broTyping = false);
    });

    final bool ok = await NostrRelayService().sendNip44Message(
      hexPrivateKey: _myHexPrivkey!,
      recipientHexPubkey: _broHexPubkey!,
      plaintext: text,
    );

    if (mounted) {
      setState(() {
        _sending = false;
        if (ok) {
          final int idx = _messages.indexOf(optimistic);
          if (idx >= 0) {
            _messages[idx] = optimistic.copyWith(pending: false);
          }
        } else {
          _messages.remove(optimistic);
          _broTyping = false;
          _typingTimer?.cancel();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Échec d\'envoi du message')),
          );
        }
      });
    }
  }

  /// Insère un préfixe de commande dans le champ de saisie et donne le focus.
  void _insertPrefix(String prefix) {
    _inputCtrl.text = prefix;
    _inputCtrl.selection = TextSelection.fromPosition(
      TextPosition(offset: prefix.length),
    );
  }

  /// Demande confirmation avant d'envoyer #reset.
  Future<void> _confirmReset() async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext ctx) => AlertDialog(
        title: const Text('Effacer les souvenirs ?'),
        content: const Text(
          'BRO effacera tous tes souvenirs (slots 0-12).\n'
          'Cette action est irréversible.',
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Annuler'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Effacer'),
          ),
        ],
      ),
    );
    if (confirmed == true) await _send('#reset');
  }

  void _scrollToBottom({bool animated = true}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollCtrl.hasClients) {
        if (animated) {
          _scrollCtrl.animateTo(
            _scrollCtrl.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        } else {
          _scrollCtrl.jumpTo(_scrollCtrl.position.maxScrollExtent);
        }
      }
    });
  }

  // ── Widgets ──────────────────────────────────────────────────────────────────

  Widget _buildBubble(NostrMessage msg) {
    final bool isMe = msg.isFromMe(_myHexPubkey ?? '');
    final ColorScheme cs = Theme.of(context).colorScheme;
    final Color bubbleColor =
        isMe ? cs.primary : cs.surfaceContainerHighest;
    final Color textColor = isMe ? cs.onPrimary : cs.onSurface;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onLongPress: () {
          Clipboard.setData(ClipboardData(text: msg.content));
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Copié'),
              duration: Duration(seconds: 1),
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.only(
            left: isMe ? 48 : 8,
            right: isMe ? 8 : 48,
            top: 2,
            bottom: 2,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: bubbleColor,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(18),
              topRight: const Radius.circular(18),
              bottomLeft: Radius.circular(isMe ? 18 : 4),
              bottomRight: Radius.circular(isMe ? 4 : 18),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withAlpha(20),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SelectableText(
                msg.content,
                style: TextStyle(color: textColor, fontSize: 15),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    _formatTime(msg.dateTime),
                    style: TextStyle(
                        fontSize: 11, color: textColor.withAlpha(160)),
                  ),
                  if (isMe) ...<Widget>[
                    const SizedBox(width: 4),
                    Icon(
                      msg.pending ? Icons.access_time : Icons.done,
                      size: 13,
                      color: textColor.withAlpha(160),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Bulle animée indiquant que BRO est en train de répondre.
  Widget _buildTypingBubble() {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(left: 8, top: 4, bottom: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: cs.surfaceContainerHighest,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
            bottomRight: Radius.circular(18),
            bottomLeft: Radius.circular(4),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              width: 14,
              height: 14,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: cs.primary,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'BRO réfléchit…',
              style: TextStyle(
                color: cs.onSurface.withAlpha(150),
                fontSize: 13,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime dt) =>
      '${dt.hour.toString().padLeft(2, '0')}:'
      '${dt.minute.toString().padLeft(2, '0')}';

  Widget _buildDateSeparator(DateTime dt) {
    final DateTime now = DateTime.now();
    final DateTime yesterday = now.subtract(const Duration(days: 1));
    final bool isToday = dt.year == now.year &&
        dt.month == now.month &&
        dt.day == now.day;
    final bool isYesterday = dt.year == yesterday.year &&
        dt.month == yesterday.month &&
        dt.day == yesterday.day;
    final String label = isToday
        ? 'Aujourd\'hui'
        : isYesterday
            ? 'Hier'
            : '${dt.day}/${dt.month}/${dt.year}';

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSurface.withAlpha(30),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMessageList() {
    final List<Widget> items = <Widget>[];
    DateTime? lastDate;
    for (final NostrMessage msg in _messages) {
      final DateTime dt = msg.dateTime.toLocal();
      final DateTime day = DateTime(dt.year, dt.month, dt.day);
      if (lastDate == null || day != lastDate) {
        items.add(_buildDateSeparator(dt));
        lastDate = day;
      }
      items.add(_buildBubble(msg));
    }
    if (_broTyping) {
      items.add(_buildTypingBubble());
    }
    return ListView(
      controller: _scrollCtrl,
      padding: const EdgeInsets.symmetric(vertical: 8),
      children: items,
    );
  }

  /// Barre de chips de raccourcis — 3 modes :
  /// - Commande directe : s'envoie immédiatement (#mem)
  /// - Préfixe : insère dans le champ, l'utilisateur complète (#rec, #badge, #craft)
  /// - Confirmation : affiche un dialog (#reset)
  Widget _buildQuickCommands() {
    final bool canInteract = !_loading && !_sending && _broHexPubkey != null;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: <Widget>[
          // Commandes directes
          for (final String cmd in _directSend)
            _chip(
              label: cmd,
              tooltip: 'Afficher les souvenirs enregistrés',
              onTap: canInteract ? () => _send(cmd) : null,
            ),
          // Préfixes
          for (final MapEntry<String, String> entry in _prefixInsert.entries)
            _chip(
              label: entry.key,
              tooltip: _chipTooltip(entry.key),
              onTap: canInteract ? () => _insertPrefix(entry.value) : null,
            ),
          // Reset avec confirmation
          _chip(
            label: '#reset',
            tooltip: 'Effacer tous les souvenirs (confirmation demandée)',
            onTap: canInteract ? _confirmReset : null,
            danger: true,
          ),
        ],
      ),
    );
  }

  String _chipTooltip(String label) {
    switch (label) {
      case '#rec ':
        return 'Mémoriser : #rec <texte> ou #rec #N <texte>';
      case '#badge ':
        return 'Générer un badge image : #badge <nom-du-skill>';
      case '#craft ':
        return 'Analyser un tutoriel : #craft <URL>';
      default:
        return label;
    }
  }

  Widget _chip({
    required String label,
    required VoidCallback? onTap,
    String? tooltip,
    bool danger = false,
  }) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final Widget chip = Padding(
      padding: const EdgeInsets.only(right: 6),
      child: ActionChip(
        label: Text(
          label.trimRight(), // affiche sans espace trailing
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
        onPressed: onTap,
        visualDensity: VisualDensity.compact,
        side: BorderSide.none,
        backgroundColor: danger
            ? cs.errorContainer.withAlpha(onTap != null ? 255 : 120)
            : cs.primaryContainer.withAlpha(onTap != null ? 255 : 120),
        labelStyle: TextStyle(
          color: danger ? cs.onErrorContainer : cs.onPrimaryContainer,
        ),
      ),
    );
    return tooltip != null
        ? Tooltip(message: tooltip, child: chip)
        : chip;
  }

  Widget _buildInput() {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      padding: EdgeInsets.only(
        left: 8,
        right: 8,
        top: 4,
        bottom: MediaQuery.of(context).viewInsets.bottom + 8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildQuickCommands(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: TextField(
                    controller: _inputCtrl,
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    minLines: 1,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                      hintText: 'Question libre ou #commande…',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                    ),
                    onSubmitted: (_) => _send(),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              FloatingActionButton.small(
                heroTag: 'bro_send_fab',
                onPressed: _sending ? null : () => _send(),
                child: _sending
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white),
                      )
                    : const Icon(Icons.send),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Sheet d'aide ─────────────────────────────────────────────────────────────

  void _showHelp() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext ctx) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.4,
        maxChildSize: 0.95,
        expand: false,
        builder: (_, ScrollController sc) => _BroHelpSheet(
          scrollController: sc,
          stationHostname: _stationHostname,
          broHex: _broHexPubkey,
        ),
      ),
    );
  }

  // ── Scaffold ─────────────────────────────────────────────────────────────────

  Widget _buildBody(ColorScheme cs) {
    if (_errorMsg != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(Icons.error_outline, size: 48, color: cs.error),
              const SizedBox(height: 12),
              Text(_errorMsg!, textAlign: TextAlign.center),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                icon: const Icon(Icons.refresh),
                label: const Text('Réessayer'),
                onPressed: _init,
              ),
            ],
          ),
        ),
      );
    }

    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: <Widget>[
        Expanded(
          child: _messages.isEmpty && !_broTyping
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.smart_toy_outlined,
                          size: 64, color: cs.onSurface.withAlpha(80)),
                      const SizedBox(height: 12),
                      Text(
                        'Dis bonjour à BRO !',
                        style:
                            TextStyle(color: cs.onSurface.withAlpha(150)),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'IA locale · Mémoire · Badges',
                        style: TextStyle(
                          fontSize: 12,
                          color: cs.onSurface.withAlpha(100),
                        ),
                      ),
                      const SizedBox(height: 16),
                      OutlinedButton.icon(
                        icon: const Icon(Icons.help_outline, size: 18),
                        label: const Text('Voir les commandes'),
                        onPressed: _showHelp,
                      ),
                    ],
                  ),
                )
              : _buildMessageList(),
        ),
        _buildInput(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final bool ready = _broHexPubkey != null && !_loading;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: <Widget>[
            Stack(
              alignment: Alignment.bottomRight,
              children: <Widget>[
                CircleAvatar(
                  radius: 18,
                  backgroundColor: cs.primaryContainer,
                  child: Icon(Icons.smart_toy,
                      color: cs.onPrimaryContainer, size: 20),
                ),
                // Point de statut (vert = station joignable, gris = init)
                Container(
                  width: 9,
                  height: 9,
                  decoration: BoxDecoration(
                    color: ready ? Colors.green : Colors.grey,
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: cs.surface, width: 1.5),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _stationHostname != null
                        ? 'BRO · $_stationHostname'
                        : 'BRO',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Assistant IA · NIP-44 · Qdrant RAG',
                    style: TextStyle(
                      fontSize: 11,
                      color: cs.onSurface.withAlpha(150),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: _showHelp,
            tooltip: 'Aide & commandes',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _init,
            tooltip: 'Rafraîchir',
          ),
        ],
      ),
      body: _buildBody(cs),
    );
  }
}

// ── Sheet d'aide détaillée ────────────────────────────────────────────────────

class _BroHelpSheet extends StatelessWidget {
  const _BroHelpSheet({
    required this.scrollController,
    this.stationHostname,
    this.broHex,
  });

  final ScrollController scrollController;
  final String? stationHostname;
  final String? broHex;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius:
            const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: ListView(
        controller: scrollController,
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
        children: <Widget>[
          // Poignée
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: cs.onSurface.withAlpha(60),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // En-tête
          Row(
            children: <Widget>[
              CircleAvatar(
                radius: 22,
                backgroundColor: cs.primaryContainer,
                child: Icon(Icons.smart_toy,
                    color: cs.onPrimaryContainer, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('BRO — Assistant IA de ta Station',
                        style: tt.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    if (stationHostname != null)
                      Text('Station : $stationHostname',
                          style: tt.bodySmall?.copyWith(
                              color: cs.onSurface.withAlpha(160))),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          _divider(cs),

          // Présentation
          _section(
            context,
            icon: Icons.info_outline,
            title: 'Qu\'est-ce que BRO ?',
            body:
                'BRO est le démon IA de ta station Astroport.ONE. Il traite tes '
                'messages en local, avec accès à :\n'
                '• Sa base de connaissance (docs NextCloud + Qdrant)\n'
                '• Ta mémoire personnelle (13 slots)\n'
                '• Les services de génération (ComfyUI pour les images)\n\n'
                'Les échanges sont chiffrés bout-à-bout (NIP-44) et ne '
                'transitent jamais en clair sur le réseau.',
          ),

          _divider(cs),

          // Questions libres
          _section(
            context,
            icon: Icons.chat_bubble_outline,
            title: 'Questions libres',
            body:
                'Tout message sans commande est envoyé à l\'IA avec le contexte '
                'de ta base de connaissance (RAG Qdrant).\n\n'
                'Exemples :\n'
                '  "Comment déployer nginx ?"\n'
                '  "Résume les réunions de cette semaine"\n'
                '  "Qu\'ai-je mémorisé sur ce projet ?"',
          ),

          _divider(cs),

          // Mémoire
          _section(
            context,
            icon: Icons.memory,
            title: 'Mémoire personnelle — #mem / #rec / #reset',
            body:
                'BRO dispose de 13 slots de mémoire personnelle :\n'
                '  • Slot 0 : accessible à tous\n'
                '  • Slots 1–12 : réservés aux sociétaires\n\n'
                'Mémoriser :\n'
                '  #rec Mon idée importante\n'
                '  #rec #3 Contexte technique projet X\n\n'
                'Lire :\n'
                '  #mem              → lister tous les slots non-vides\n'
                '  #mem #3           → afficher les 5 derniers souvenirs du slot 3\n\n'
                'Effacer :\n'
                '  #reset            → effacer tous les slots\n'
                '  #reset #3         → effacer uniquement le slot 3\n\n'
                'Question avec contexte de slots :\n'
                '  "Que dois-je faire ensuite ? #1 #3"',
          ),

          _divider(cs),

          // Mémoire partagée
          _section(
            context,
            icon: Icons.people_outline,
            title: 'Mémoire partagée — Skills',
            body:
                'Partage des connaissances avec la communauté via les skills.\n\n'
                'Contribuer :\n'
                '  #rec:devops Je sais configurer Traefik\n'
                '  #rec:cuisine Recette tarte aux pommes\n\n'
                'Consulter :\n'
                '  #mem:devops           → lire la mémoire partagée DevOps\n'
                '  #mem:                 → lister tous les skills disponibles\n\n'
                'Contexte pédagogique (question ciblée) :\n'
                '  [ctx:devops:2] Comment configurer un reverse proxy ?',
          ),

          _divider(cs),

          // Génération
          _section(
            context,
            icon: Icons.auto_awesome,
            title: 'Génération — #badge / #craft',
            body:
                '#badge <nom-skill> — Génère une image de badge personnalisé '
                '(via ComfyUI, si disponible sur ta station).\n'
                '  Ex : #badge artisan-du-bois\n\n'
                '#craft <URL> — Analyse un tutoriel ou article et le '
                'décompose en recette JSON structurée (format WoTx²).\n'
                '  Ex : #craft https://example.com/tuto-docker',
          ),

          _divider(cs),

          // Latence
          _section(
            context,
            icon: Icons.timer_outlined,
            title: 'Délais de réponse',
            body:
                'BRO traite les messages en asynchrone :\n'
                '  • Question simple (Ollama local) : 2–15 s\n'
                '  • Question avec Qdrant RAG : 5–20 s\n'
                '  • Génération d\'image #badge : 20–60 s\n'
                '  • Analyse #craft : 10–30 s\n\n'
                'Si BRO est sur un Brain-Node distant (GPU), '
                'les réponses sont plus rapides mais dépendent du réseau.',
          ),

          // NODEHEX (debug)
          if (broHex != null) ...<Widget>[
            _divider(cs),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'NODEHEX : ${broHex!.substring(0, 16)}…',
                      style: tt.bodySmall?.copyWith(
                          fontFamily: 'monospace',
                          color: cs.onSurface.withAlpha(100)),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy, size: 16),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: broHex!));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('NODEHEX copié'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                    tooltip: 'Copier le NODEHEX complet',
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _section(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String body,
  }) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, size: 18, color: cs.primary),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            body,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  height: 1.6,
                  color: cs.onSurface.withAlpha(200),
                ),
          ),
        ],
      ),
    );
  }

  Widget _divider(ColorScheme cs) => Divider(
        color: cs.onSurface.withAlpha(30),
        height: 1,
      );
}
