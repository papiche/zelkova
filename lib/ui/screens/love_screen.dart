import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:bip340/bip340.dart' as bip340;
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/models/nostr_message.dart';
import '../../g1/nostr/nostr_keys.dart';
import '../../g1/nostr/nostr_relay_service.dart';
import '../../services/astroport_station_service.dart';
import '../../services/encrypted_file_service.dart';
import '../../shared_prefs_helper_v2.dart';
import '../logger.dart';
import '../widgets/encrypted_image_bubble.dart';
import '../widgets/image_composition_sheet.dart';

/// Interface LOVE — Assistance aux rencontres via BRO canal "love" (NIP-44).
///
/// ## Protocole
///
/// Les messages envoyés sont chiffrés NIP-44 au NODEHEX de la station.
/// Le contenu décrypté est un JSON avec channel "love" :
///   {"channel":"love","payload":{"action":"ask","text":"Ma question"}}
///
/// Les réponses de BRO arrivent en texte brut (non JSON).
///
/// ## Actions disponibles
///
/// | action    | Effet                                             | Tier |
/// |-----------|---------------------------------------------------|------|
/// | ask       | Question libre avec contexte love (RAG + mémoire) | 1    |
/// | mem       | Lister les souvenirs enregistrés                  | 1    |
/// | rec       | Mémoriser une préférence                          | 1    |
/// | reset     | Effacer tous les souvenirs                        | 1    |
/// | profile   | Voir / mettre à jour le profil                    | 1    |
/// | suggest   | Idées de rendez-vous personnalisées               | 1    |
/// | kin       | Analyse compatibilité KIN Dreamspell              | 1    |
/// | match     | Trouver des profils compatibles (station, +18)    | 2    |
class LoveScreen extends StatefulWidget {
  const LoveScreen({super.key});

  @override
  State<LoveScreen> createState() => _LoveScreenState();
}

class _LoveScreenState extends State<LoveScreen> {
  final TextEditingController _inputCtrl = TextEditingController();
  final ScrollController _scrollCtrl = ScrollController();
  final List<NostrMessage> _messages = <NostrMessage>[];

  bool _loading = true;
  bool _sending = false;
  bool _broTyping = false;
  bool _uploadingImage = false;
  bool _showEmojiPicker = false;
  String? _errorMsg;

  String? _myHexPubkey;
  String? _myHexPrivkey;
  String? _broHexPubkey;
  String? _stationHostname;

  String? _dmSubId;
  Timer? _typingTimer;

  // Couleurs love (rose doux + corail)
  static const Color _loveRose = Color(0xFFE91E8C);
  static const Color _loveRoseLight = Color(0xFFFCE4EC);
  static const Color _loveCoral = Color(0xFFFF6B8A);

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

      final Map<String, dynamic>? stationData =
          await AstroportStationService().fetchStationData();
      final String? broHex = stationData?['NODEHEX'] as String?;
      if (broHex == null || broHex.length != 64) {
        _setError('Station LOVE introuvable — vérifie ta connexion.');
        return;
      }
      final String? hostname = stationData?['hostname'] as String?;

      logger('[LoveScreen] NODEHEX → ${broHex.substring(0, 8)}… station=$hostname');

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
      logger('[LoveScreen] init error: $e');
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
      // Filtrer : garder seulement les messages du canal "love" (envoyés) + les réponses BRO
      final List<NostrMessage> loveMsgs = msgs
          .where((NostrMessage m) =>
              !m.isFromMe(_myHexPubkey!) || _isLoveMessage(m.content))
          .toList();
      if (mounted) {
        setState(() {
          _messages
            ..clear()
            ..addAll(loveMsgs);
          _loading = false;
        });
        _scrollToBottom(animated: false);
        _subscribeLive();
      }
    } catch (e) {
      logger('[LoveScreen] loadHistory error: $e');
      if (mounted) setState(() => _loading = false);
    }
  }

  /// Vérifie si un message envoyé appartient au canal "love".
  bool _isLoveMessage(String raw) {
    try {
      final Map<String, dynamic> json = jsonDecode(raw) as Map<String, dynamic>;
      return json['channel'] == 'love';
    } catch (_) {
      return false;
    }
  }

  /// Extrait le texte lisible depuis un message envoyé (JSON) ou une réponse BRO (plain).
  String _displayText(NostrMessage msg) {
    if (msg.isFromMe(_myHexPubkey ?? '')) {
      try {
        final Map<String, dynamic> json =
            jsonDecode(msg.content) as Map<String, dynamic>;
        final Map<String, dynamic>? payload =
            json['payload'] as Map<String, dynamic>?;
        final String? text = payload?['text'] as String?;
        final String? action = payload?['action'] as String?;
        if (text != null && text.isNotEmpty) return text;
        if (action != null && action != 'ask') {
          return _actionLabel(action);
        }
      } catch (_) {}
    }
    return msg.content;
  }

  String _actionLabel(String action) {
    switch (action) {
      case 'status':
        return '📊 Statut LOVE';
      case 'mem':
        return '📋 Voir mes souvenirs';
      case 'reset':
        return '🗑️ Effacer les souvenirs';
      case 'suggest':
        return '✨ Idées de rencontres';
      case 'kin':
        return '🌀 Compatibilité KIN';
      case 'match':
        return '💘 Trouver des profils';
      case 'profile':
        return '👤 Mon profil';
      case 'intro':
        return '✍️ Message d\'accroche';
      case 'image':
        return '🖼️ Image partagée';
      default:
        return action;
    }
  }

  /// Extrait les métadonnées d'un message image chiffré (action="image").
  Map<String, String>? _extractImagePayload(NostrMessage msg) {
    try {
      final Map<String, dynamic> envelope =
          jsonDecode(msg.content) as Map<String, dynamic>;
      if (envelope['channel'] != 'love') return null;
      final Map<String, dynamic>? p =
          envelope['payload'] as Map<String, dynamic>?;
      if (p?['action'] != 'image') return null;
      final String? textRaw = p?['text'] as String?;
      if (textRaw == null || textRaw.isEmpty) return null;
      final Map<String, dynamic> data =
          jsonDecode(textRaw) as Map<String, dynamic>;
      final String cid = data['cid'] as String? ?? '';
      final String encKey = data['enc_key'] as String? ?? '';
      if (cid.isEmpty || encKey.isEmpty) return null;
      return <String, String>{
        'cid': cid,
        'enc_key': encKey,
        'enc_type': data['enc_type'] as String? ?? 'aes256gcm',
        'filename': data['filename'] as String? ?? 'image',
      };
    } catch (_) {
      return null;
    }
  }

  /// Télécharge, déchiffre et affiche l'image dans un dialog.
  /// Sélectionne et envoie une image chiffrée via LOVE.
  Future<void> _pickAndSendImage() async {
    if (_sending || _uploadingImage) return;

    final ImagePicker picker = ImagePicker();
    final XFile? xfile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1920,
      maxHeight: 1920,
      imageQuality: 85,
    );
    if (xfile == null || !mounted) return;

    // Dialogue de composition : titre + légende + emoji
    final Uint8List bytes = await xfile.readAsBytes();
    final String filename = xfile.name;

    if (!mounted) return;
    final ImageCompositionResult? meta = await showImageCompositionSheet(
      context: context,
      imageBytes: bytes,
      filename: filename,
    );
    if (meta == null || !mounted) return;

    setState(() => _uploadingImage = true);

    try {
      EncryptedUploadResult result = await EncryptedFileService.upload(
        fileBytes: bytes,
        filename: filename,
      );
      result = result.withMeta(title: meta.title, caption: meta.caption);

      await _sendAction('image', text: jsonEncode(result.toJson()));
    } catch (e) {
      logger('[LoveScreen] image upload error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur upload image : $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _uploadingImage = false);
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
        _typingTimer?.cancel();
        setState(() {
          _broTyping = false;
          _messages.removeWhere((NostrMessage m) =>
              m.pending && _displayText(m) == _displayText(msg));
          _messages.add(msg);
        });
        _scrollToBottom();
      },
    );
  }

  /// Envoie un message avec le canal "love" encapsulé dans le payload NIP-44.
  Future<void> _sendAction(String action, {String text = ''}) async {
    if (_sending) return;
    if (_myHexPrivkey == null || _broHexPubkey == null) return;

    // Construire le payload JSON pour le canal "love"
    final String plaintext = jsonEncode(<String, dynamic>{
      'channel': 'love',
      'payload': <String, dynamic>{
        'action': action,
        'text': text,
      },
    });

    final NostrMessage optimistic = NostrMessage(
      id: 'pending_${DateTime.now().millisecondsSinceEpoch}',
      senderHex: _myHexPubkey!,
      recipientHex: _broHexPubkey!,
      content: plaintext, // contenu réel (JSON)
      createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      pending: true,
    );

    setState(() {
      _messages.add(optimistic);
      _sending = true;
      _broTyping = true;
    });
    _scrollToBottom();

    _typingTimer?.cancel();
    _typingTimer = Timer(const Duration(seconds: 50), () {
      if (mounted) setState(() => _broTyping = false);
    });

    final bool ok = await NostrRelayService().sendNip44Message(
      hexPrivateKey: _myHexPrivkey!,
      recipientHexPubkey: _broHexPubkey!,
      plaintext: plaintext,
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

  void _insertPrefix(String prefix) {
    _inputCtrl.text = prefix;
    _inputCtrl.selection =
        TextSelection.collapsed(offset: _inputCtrl.text.length);
  }

  Future<void> _sendText() async {
    final String text = _inputCtrl.text.trim();
    if (text.isEmpty) return;
    _inputCtrl.clear();
    // Détecter l'action intro (préfixe inséré par le chip)
    const String introPrefix = 'Rédige une intro pour quelqu\'un qui ';
    if (text.startsWith(introPrefix) && text.length > introPrefix.length) {
      await _sendAction('intro', text: text.substring(introPrefix.length).trim());
    } else {
      await _sendAction('ask', text: text);
    }
  }

  Future<void> _confirmReset() async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext ctx) => AlertDialog(
        title: const Text('Effacer les souvenirs LOVE ?'),
        content: const Text(
          'BRO effacera tous tes souvenirs et préférences LOVE.\n'
          'Ton profil sera conservé.',
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Annuler'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: _loveRose),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Effacer'),
          ),
        ],
      ),
    );
    if (confirmed == true) await _sendAction('reset');
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

    // Message image chiffré — miniature auto-chargée
    final Map<String, String>? imgPayload = _extractImagePayload(msg);
    if (imgPayload != null) {
      return EncryptedImageBubble(
        cid: imgPayload['cid']!,
        encKeyHex: imgPayload['enc_key']!,
        isMe: isMe,
        time: _formatTime(msg.dateTime),
        pending: msg.pending,
        filename: imgPayload['filename'],
        title: imgPayload['title'],
        caption: imgPayload['caption'],
        bubbleColor: isMe ? _loveRose : _loveRoseLight,
        textColor: isMe ? Colors.white : Colors.black87,
      );
    }

    final String displayContent = _displayText(msg);
    final Color bubbleColor = isMe ? _loveRose : _loveRoseLight;
    final Color textColor = isMe ? Colors.white : Colors.black87;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onLongPress: () {
          Clipboard.setData(ClipboardData(text: displayContent));
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
                color: _loveRose.withAlpha(isMe ? 60 : 20),
                blurRadius: 6,
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
                displayContent,
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

  Widget _buildTypingBubble() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(left: 8, top: 4, bottom: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: _loveRoseLight,
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
                color: _loveRose,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'BRO LOVE réfléchit…',
              style: TextStyle(
                color: _loveRose.withAlpha(200),
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
            color: _loveRose.withAlpha(30),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            label,
            style: TextStyle(
                fontSize: 12, color: _loveRose.withAlpha(200)),
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
    if (_broTyping) items.add(_buildTypingBubble());
    return ListView(
      controller: _scrollCtrl,
      padding: const EdgeInsets.symmetric(vertical: 8),
      children: items,
    );
  }

  Widget _buildQuickActions() {
    final bool canInteract =
        !_loading && !_sending && _broHexPubkey != null;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: <Widget>[
          _loveChip(
            icon: Icons.info_outline,
            label: 'Statut',
            onTap: canInteract ? () => _sendAction('status') : null,
            tooltip: 'Quota restant, profil, prochaine étape',
          ),
          _loveChip(
            icon: Icons.favorite_border,
            label: 'Idées',
            onTap: canInteract ? () => _sendAction('suggest') : null,
            tooltip: 'Idées de rendez-vous personnalisées',
          ),
          _loveChip(
            icon: Icons.auto_awesome,
            label: 'KIN',
            onTap: canInteract ? () => _sendAction('kin') : null,
            tooltip: 'Analyse compatibilité KIN Dreamspell',
          ),
          _loveChip(
            icon: Icons.memory,
            label: 'Souvenirs',
            onTap: canInteract ? () => _sendAction('mem') : null,
            tooltip: 'Voir mes souvenirs LOVE',
          ),
          _loveChip(
            icon: Icons.people_outline,
            label: 'Profil',
            onTap: canInteract ? () => _sendAction('profile') : null,
            tooltip: 'Voir / mettre à jour mon profil',
          ),
          _loveChip(
            icon: Icons.person_search,
            label: 'Match +18',
            onTap: canInteract ? () => _sendAction('match') : null,
            tooltip: 'Trouver des profils compatibles (+18 ans, KIN + Phi²)',
          ),
          _loveChip(
            icon: Icons.edit_note,
            label: 'Intro',
            onTap: canInteract
                ? () => _insertPrefix('Rédige une intro pour quelqu\'un qui ')
                : null,
            tooltip: 'Générer un message d\'accroche personnalisé',
          ),
          _loveChip(
            icon: Icons.delete_sweep_outlined,
            label: 'Reset',
            onTap: canInteract ? _confirmReset : null,
            tooltip: 'Effacer les souvenirs LOVE (confirmation)',
            danger: true,
          ),
        ],
      ),
    );
  }

  Widget _loveChip({
    required IconData icon,
    required String label,
    required VoidCallback? onTap,
    String? tooltip,
    bool danger = false,
  }) {
    final Color bg = danger
        ? Colors.red.shade50
        : _loveRoseLight;
    final Color fg = danger ? Colors.red.shade400 : _loveRose;
    final Widget chip = Padding(
      padding: const EdgeInsets.only(right: 6),
      child: ActionChip(
        avatar: Icon(icon, size: 15, color: onTap != null ? fg : fg.withAlpha(100)),
        label: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: onTap != null ? fg : fg.withAlpha(100),
          ),
        ),
        onPressed: onTap,
        visualDensity: VisualDensity.compact,
        side: BorderSide(color: fg.withAlpha(onTap != null ? 80 : 40), width: 1),
        backgroundColor: bg.withAlpha(onTap != null ? 255 : 160),
      ),
    );
    return tooltip != null
        ? Tooltip(message: tooltip, child: chip)
        : chip;
  }

  Widget _buildInput() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          color: Colors.white,
          padding: EdgeInsets.only(
            left: 8,
            right: 8,
            top: 4,
            bottom: _showEmojiPicker ? 8 : MediaQuery.of(context).viewInsets.bottom + 8,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildQuickActions(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  // Bouton image chiffrée
                  Tooltip(
                    message: 'Envoyer une image (chiffrée)',
                    child: IconButton(
                      onPressed:
                          (_sending || _uploadingImage) ? null : _pickAndSendImage,
                      icon: _uploadingImage
                          ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: _loveRose),
                            )
                          : Icon(Icons.image_outlined, color: _loveRose),
                    ),
                  ),
                  // Champ texte + bouton emoji
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: _loveRoseLight,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              controller: _inputCtrl,
                              keyboardType: TextInputType.multiline,
                              maxLines: 4,
                              minLines: 1,
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration(
                                hintText: 'Parle à BRO LOVE…',
                                hintStyle:
                                    TextStyle(color: _loveRose.withAlpha(120)),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                              ),
                              onSubmitted: (_) => _sendText(),
                              onTap: () {
                                if (_showEmojiPicker) {
                                  setState(() => _showEmojiPicker = false);
                                }
                              },
                            ),
                          ),
                          // Toggle emoji
                          IconButton(
                            tooltip: 'Emoji',
                            icon: Icon(
                              Icons.emoji_emotions_outlined,
                              color: _showEmojiPicker
                                  ? _loveRose
                                  : _loveRose.withAlpha(140),
                            ),
                            onPressed: () {
                              setState(
                                  () => _showEmojiPicker = !_showEmojiPicker);
                              if (_showEmojiPicker) {
                                FocusScope.of(context).unfocus();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  FloatingActionButton.small(
                    heroTag: 'love_send_fab',
                    backgroundColor: _loveRose,
                    onPressed: _sending ? null : _sendText,
                    child: _sending
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: Colors.white),
                          )
                        : const Icon(Icons.send, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Emoji picker (rose, à la place du clavier)
        Offstage(
          offstage: !_showEmojiPicker,
          child: SizedBox(
            height: 300,
            child: EmojiPicker(
              textEditingController: _inputCtrl,
              config: Config(
                height: 300,
                checkPlatformCompatibility: true,
                emojiViewConfig: const EmojiViewConfig(
                  emojiSizeMax: 28,
                  columns: 9,
                ),
                searchViewConfig: const SearchViewConfig(
                  hintText: 'Rechercher…',
                ),
                bottomActionBarConfig: const BottomActionBarConfig(
                  showBackspaceButton: true,
                  showSearchViewButton: true,
                ),
                categoryViewConfig: const CategoryViewConfig(
                  initCategory: Category.RECENT,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showHelp() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext ctx) => DraggableScrollableSheet(
        initialChildSize: 0.65,
        minChildSize: 0.4,
        maxChildSize: 0.95,
        expand: false,
        builder: (_, ScrollController sc) =>
            _LoveHelpSheet(scrollController: sc, stationHostname: _stationHostname),
      ),
    );
  }

  Widget _buildBody() {
    if (_errorMsg != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(Icons.heart_broken, size: 48, color: _loveRose),
              const SizedBox(height: 12),
              Text(_errorMsg!, textAlign: TextAlign.center),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: _loveRose),
                icon: const Icon(Icons.refresh, color: Colors.white),
                label: const Text('Réessayer',
                    style: TextStyle(color: Colors.white)),
                onPressed: _init,
              ),
            ],
          ),
        ),
      );
    }

    if (_loading) {
      return Center(
        child: CircularProgressIndicator(color: _loveRose),
      );
    }

    return Column(
      children: <Widget>[
        Expanded(
          child: _messages.isEmpty && !_broTyping
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.favorite, size: 64, color: _loveRose.withAlpha(80)),
                      const SizedBox(height: 12),
                      Text(
                        'Bienvenue en mode LOVE 💕',
                        style: TextStyle(
                          color: _loveRose,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Pose une question libre ou utilise\n'
                        'les commandes rapides ci-dessous',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _loveCoral.withAlpha(180),
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 16),
                      OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: _loveRose,
                          side: BorderSide(color: _loveRose),
                        ),
                        icon: const Icon(Icons.help_outline, size: 18),
                        label: const Text('Guide d\'utilisation'),
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
    final bool ready = _broHexPubkey != null && !_loading;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: _loveRose,
        elevation: 0,
        titleSpacing: 0,
        title: Row(
          children: <Widget>[
            Stack(
              alignment: Alignment.bottomRight,
              children: <Widget>[
                CircleAvatar(
                  radius: 18,
                  backgroundColor: _loveRoseLight,
                  child: Icon(Icons.favorite, color: _loveRose, size: 20),
                ),
                Container(
                  width: 9,
                  height: 9,
                  decoration: BoxDecoration(
                    color: ready ? Colors.green : Colors.grey,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5),
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
                        ? 'LOVE · $_stationHostname'
                        : 'LOVE',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: _loveRose,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Assistant rencontres · NIP-44 · IA locale',
                    style: TextStyle(
                      fontSize: 11,
                      color: _loveCoral.withAlpha(180),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.help_outline, color: _loveRose),
            onPressed: _showHelp,
            tooltip: 'Guide d\'utilisation',
          ),
          IconButton(
            icon: Icon(Icons.refresh, color: _loveRose),
            onPressed: _init,
            tooltip: 'Rafraîchir',
          ),
        ],
      ),
      body: _buildBody(),
    );
  }
}

// ── Sheet d'aide ──────────────────────────────────────────────────────────────

class _LoveHelpSheet extends StatelessWidget {
  const _LoveHelpSheet({
    required this.scrollController,
    this.stationHostname,
  });

  final ScrollController scrollController;
  final String? stationHostname;

  static const Color _loveRose = Color(0xFFE91E8C);
  static const Color _loveRoseLight = Color(0xFFFCE4EC);

  @override
  Widget build(BuildContext context) {
    final TextTheme tt = Theme.of(context).textTheme;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
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
                color: _loveRose.withAlpha(80),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          Row(
            children: <Widget>[
              CircleAvatar(
                radius: 22,
                backgroundColor: _loveRoseLight,
                child: Icon(Icons.favorite, color: _loveRose, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Mode LOVE — Assistance aux rencontres',
                        style: tt.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold, color: _loveRose)),
                    if (stationHostname != null)
                      Text('Station : $stationHostname',
                          style: tt.bodySmall?.copyWith(
                              color: _loveRose.withAlpha(160))),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          _divider(),
          _section(context, icon: Icons.info_outline, title: 'Agence de Rencontre UPlanet — Astria',
              body: 'Astria est ta conseillère personnelle de l\'Agence UPlanet.\n'
                  'Elle t\'accompagne étape par étape dans ta démarche de rencontre.\n\n'
                  '⏱ Quota : 3 prompts IA par jour (renouvellement minuit)\n'
                  '  → actions sans IA illimitées : Statut, Souvenirs, Profil\n\n'
                  '🔒 Confidentialité :\n'
                  '• Tes messages sont chiffrés NIP-44, seule ta station les déchiffre\n'
                  '• L\'historique de dialogue (4 derniers échanges) est stocké\n'
                  '  localement sur ta station, jamais publié sur NOSTR\n'
                  '• Tes préférences et profil restent privés sauf si tu actives\n'
                  '  "public: true" (pour le matching)'),
          _divider(),
          _section(context, icon: Icons.auto_awesome, title: 'Questions libres',
              body: 'Tape directement tes questions ou demandes :\n'
                  '• "Aide-moi à rédiger une invitation pour un pique-nique"\n'
                  '• "Idées de cadeaux originaux pour une première rencontre"\n'
                  '• "Comment dépasser ma timidité pour aborder quelqu\'un ?"\n'
                  '• "Qu\'est-ce que la compatibilité KIN Dreamspell ?"'),
          _divider(),
          _section(context, icon: Icons.memory, title: 'Mémoire LOVE — Tier 1 (tous)',
              body: 'BRO mémorise tes préférences pour des suggestions personnalisées.\n\n'
                  'Mémoriser : #love_rec suivi du texte (ou bouton "Souvenirs")\n'
                  'Lire : bouton "Souvenirs"\n'
                  'Effacer : bouton "Reset" (avec confirmation)\n\n'
                  'Exemples :\n'
                  '• "J\'adore les balades en nature"\n'
                  '• "Je suis végétarien"\n'
                  '• "Je cherche quelqu\'un de curieux et créatif"'),
          _divider(),
          _section(context, icon: Icons.person_outline, title: 'Profil — Tier 1 (tous)',
              body: 'Crée ton profil pour des suggestions encore plus pertinentes.\n\n'
                  'Envoie un JSON (ou utilise le bouton "Profil") :\n'
                  '{"age": 28, "bio": "Amateur de montagne et de BD", "interests": ["randonnée", "cuisine", "jazz"]}\n\n'
                  'Les champs "public" et "age" sont utilisés pour le matching.'),
          _divider(),
          _section(context, icon: Icons.edit_note, title: 'Message d\'accroche — Intro',
              body: 'Génère un premier message authentique pour une mise en relation.\n\n'
                  'Appuie sur "Intro" puis décris la personne :\n'
                  'Ex : "aime la cuisine et la randonnée, curieux et créatif"\n\n'
                  'BRO rédige un message court, sincère et non-intrusif\n'
                  'qui reflète ta personnalité.'),
          _divider(),
          _section(context, icon: Icons.people, title: 'Matching local — Tier 2 (+18)',
              body: 'Score composite sur 100 pts :\n'
                  '• 40 pts — intérêts communs\n'
                  '• 30 pts — compatibilité KIN Dreamspell\n'
                  '  (sceau analogue, même tonalité, couleurs)\n'
                  '• 30 pts — résonance Phi² ATOM4LOVE\n'
                  '  (k=1/(1+|sin(Δφ)|) + cohérence ω)\n\n'
                  'Conditions :\n'
                  '• Avoir déclaré un âge ≥ 18 dans ton profil\n'
                  '• L\'autre membre doit avoir "public": true\n\n'
                  'Pour rendre ton profil visible :\n'
                  '{"public": true}\n\n'
                  'Inscris-toi sur ATOM4LOVE pour activer le score Phi².'),
          _divider(),
          _section(context, icon: Icons.hub_outlined, title: 'Matching Constellation — Tier 3 (Parrains)',
              body: 'Les Parrains (capitaines de station) peuvent accéder au matching\n'
                  'étendu à toute la constellation UPlanet via les profils kind-30500\n'
                  'publiés consensuellement sur le relay NOSTR.\n\n'
                  'Cette fonctionnalité est en cours de déploiement.'),
          _divider(),
          _section(context, icon: Icons.lock_outline, title: 'Vie privée',
              body: '• Aucune information n\'est partagée sans ton consentement\n'
                  '• Seul ton capitaine de station peut lire les logs techniques\n'
                  '• Le matching ne révèle jamais les identités directement\n'
                  '• Tu peux effacer ta mémoire à tout moment avec "Reset"'),
        ],
      ),
    );
  }

  Widget _section(BuildContext context, {required IconData icon, required String title, required String body}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, size: 18, color: _loveRose),
              const SizedBox(width: 8),
              Expanded(
                child: Text(title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold, color: _loveRose)),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(body,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    height: 1.6, color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _divider() => Divider(color: _loveRose.withAlpha(40), height: 1);
}
