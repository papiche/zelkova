import 'dart:async';

import 'package:bip340/bip340.dart' as bip340;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../data/models/nostr_message.dart';
import '../../g1/nostr/nostr_keys.dart';
import '../../g1/nostr/nostr_relay_service.dart';
import '../../shared_prefs_helper_v2.dart';
import '../logger.dart';

/// Interface de chat dédiée BRO — ton clone personnel, via self-DM NIP-44.
///
/// BRO (Astroport.ONE/IA/bro_watch_core.py::process_incoming_commands) est
/// distinct de NODE (voir node_screen.dart, l'assistant RAG de la station) :
/// ici, le message est envoyé à SA PROPRE clé (auteur == destinataire ==
/// ma pubkey principale) — pas à la station. Le démon, qui détient la
/// clé NOSTR de ce compte côté serveur (design MULTIPASS), déchiffre et
/// répond en signant AUSSI avec cette même clé — la conversation apparaît
/// donc entièrement comme "moi-même", des deux côtés.
///
/// Un tag NOSTR dédié (`["client","bro"]`, voir
/// Astroport.ONE/IA/bro/nostr.py::BRO_ORIGIN_TAG) distingue les réponses du
/// démon des messages réellement tapés par l'utilisateur — c'est
/// [NostrMessage.isBotReply], jamais une comparaison de pubkey (identiques
/// des deux côtés ici).
///
/// Le même mécanisme est exposé côté web par UPlanet/earth/atomic_chat.html
/// (onglet "🤖 BRO", toujours épinglé en 1ère position).
///
/// BRO couvre un périmètre large et évolutif (mémoire, veille sociale,
/// génération média #image/#video/#music, interprétation en langage
/// naturel…) — volontairement pas détaillé exhaustivement ici pour éviter
/// toute liste figée qui divergerait du comportement réel du démon.
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

  String? _dmSubId;
  Timer? _typingTimer;

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

      logger('[BroScreen] self-DM → ${hexPub.substring(0, 8)}…');

      if (mounted) {
        setState(() {
          _myHexPubkey = hexPub;
          _myHexPrivkey = hexPriv;
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
    if (_myHexPubkey == null || _myHexPrivkey == null) {
      return;
    }
    setState(() => _loading = true);
    try {
      final List<NostrMessage> msgs =
          await NostrRelayService().fetchSelfDmMessages(
        myHexPubkey: _myHexPubkey!,
        myHexPrivkey: _myHexPrivkey!,
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
    if (_myHexPubkey == null || _myHexPrivkey == null) {
      return;
    }
    _dmSubId = NostrRelayService().subscribeToSelfDms(
      myHexPubkey: _myHexPubkey!,
      myHexPrivkey: _myHexPrivkey!,
      onMessage: (NostrMessage msg) {
        if (!mounted) return;
        setState(() {
          // Écho d'un message que je viens d'envoyer : remplace le placeholder
          // optimiste au lieu de dupliquer la bulle.
          final int pendingIdx = _messages.indexWhere(
              (NostrMessage m) => m.pending && m.content == msg.content);
          if (pendingIdx >= 0 && !msg.isBotReply) {
            _messages[pendingIdx] = msg;
            return;
          }
          if (msg.isBotReply) {
            _typingTimer?.cancel();
            _broTyping = false;
          }
          if (!_messages.any((NostrMessage m) => m.id == msg.id)) {
            _messages.add(msg);
          }
        });
        _scrollToBottom();
      },
    );
  }

  Future<void> _send() async {
    final String text = _inputCtrl.text.trim();
    if (text.isEmpty || _sending) return;
    if (_myHexPrivkey == null || _myHexPubkey == null) return;

    _inputCtrl.clear();

    final NostrMessage optimistic = NostrMessage(
      id: 'pending_${DateTime.now().millisecondsSinceEpoch}',
      senderHex: _myHexPubkey!,
      recipientHex: _myHexPubkey!,
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

    // Timer de sécurité : certaines commandes BRO (génération média) peuvent
    // prendre plus de temps qu'un simple RAG — indicateur abandonné après 60s.
    _typingTimer?.cancel();
    _typingTimer = Timer(const Duration(seconds: 60), () {
      if (mounted) setState(() => _broTyping = false);
    });

    final bool ok = await NostrRelayService().sendNip44Message(
      hexPrivateKey: _myHexPrivkey!,
      recipientHexPubkey: _myHexPubkey!,
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
    final bool isMe = !msg.isBotReply;
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

  Widget _buildInput() {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      padding: EdgeInsets.only(
        left: 8,
        right: 8,
        top: 4,
        bottom: MediaQuery.of(context).viewInsets.bottom + 8,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color:
                    Theme.of(context).colorScheme.surfaceContainerHighest,
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
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                onSubmitted: (_) => _send(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          FloatingActionButton.small(
            heroTag: 'bro_self_send_fab',
            onPressed: _sending ? null : _send,
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
        initialChildSize: 0.6,
        minChildSize: 0.35,
        maxChildSize: 0.9,
        expand: false,
        builder: (_, ScrollController sc) =>
            _BroHelpSheet(scrollController: sc),
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
                      Icon(Icons.person_pin_circle_outlined,
                          size: 64, color: cs.onSurface.withAlpha(80)),
                      const SizedBox(height: 12),
                      Text(
                        'Dis bonjour à ton BRO !',
                        style:
                            TextStyle(color: cs.onSurface.withAlpha(150)),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Ton clone personnel · self-DM chiffré',
                        style: TextStyle(
                          fontSize: 12,
                          color: cs.onSurface.withAlpha(100),
                        ),
                      ),
                      const SizedBox(height: 16),
                      OutlinedButton.icon(
                        icon: const Icon(Icons.help_outline, size: 18),
                        label: const Text('Qu\'est-ce que BRO ?'),
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
    final bool ready = _myHexPubkey != null && !_loading;

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
                  child: Icon(Icons.person_pin_circle,
                      color: cs.onPrimaryContainer, size: 20),
                ),
                Container(
                  width: 9,
                  height: 9,
                  decoration: BoxDecoration(
                    color: ready ? Colors.green : Colors.grey,
                    shape: BoxShape.circle,
                    border: Border.all(color: cs.surface, width: 1.5),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'BRO',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Ton clone personnel · self-DM NIP-44',
                    style: TextStyle(fontSize: 11),
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
            tooltip: 'Qu\'est-ce que BRO ?',
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

// ── Sheet d'aide ──────────────────────────────────────────────────────────────

class _BroHelpSheet extends StatelessWidget {
  const _BroHelpSheet({required this.scrollController});

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: ListView(
        controller: scrollController,
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
        children: <Widget>[
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
          Row(
            children: <Widget>[
              CircleAvatar(
                radius: 22,
                backgroundColor: cs.primaryContainer,
                child: Icon(Icons.person_pin_circle,
                    color: cs.onPrimaryContainer, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text('BRO — ton clone personnel',
                    style: tt.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _divider(cs),
          _section(
            context,
            icon: Icons.info_outline,
            title: 'Qu\'est-ce que BRO ?',
            body:
                'BRO est ta propre identité MULTIPASS qui te répond : le '
                'message que tu envoies est adressé à toi-même — self-DM. '
                'Ta station (qui détient ta clé NOSTR côté serveur, comme '
                'tout compte MULTIPASS) le déchiffre, l\'interprète, et te '
                'répond en signant avec cette même clé. La conversation '
                'apparaît donc entièrement comme "toi-même", des deux côtés.\n\n'
                'Distinct de NODE (l\'assistant RAG de la station, autre '
                'onglet) : BRO, c\'est ton clone — mémoire, veille, '
                'génération, interprétation en langage naturel.',
          ),
          _divider(cs),
          _section(
            context,
            icon: Icons.chat_bubble_outline,
            title: 'Comment lui parler',
            body:
                'Question libre ou commande #hashtag — quelques exemples '
                'stables :\n'
                '  #mem              → lister tes souvenirs enregistrés\n'
                '  #rec <texte>      → mémoriser une préférence\n'
                '  #reset            → effacer tes souvenirs\n\n'
                'BRO couvre bien plus (génération d\'image/vidéo/musique, '
                'veille sociale, outils…) et évolue régulièrement — cette '
                'liste n\'est volontairement pas exhaustive pour ne jamais '
                'diverger du comportement réel du démon.',
          ),
          _divider(cs),
          _section(
            context,
            icon: Icons.lock_outline,
            title: 'Confidentialité',
            body:
                'Les échanges sont chiffrés bout-à-bout (NIP-44) et ne '
                'transitent jamais en clair sur le réseau. Ta station les '
                'déchiffre pour te répondre — c\'est le prix de l\'IA '
                'auto-hébergée, sans dépendre d\'un service tiers.',
          ),
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
