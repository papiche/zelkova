import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/models/nostr_message.dart';
import '../../g1/nostr/nostr_profile.dart';
import '../../g1/nostr/nostr_relay_service.dart';
import '../../services/encrypted_file_service.dart';
import '../widgets/encrypted_image_bubble.dart';
import '../widgets/image_composition_sheet.dart';

/// WhatsApp/Telegram-style chat screen for NIP-44 encrypted DMs.
class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    required this.myHexPubkey,
    required this.myHexPrivkey,
    required this.peerHexPubkey,
    this.peerProfile,
  });

  final String myHexPubkey;
  final String myHexPrivkey;
  final String peerHexPubkey;
  final NostrProfile? peerProfile;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _inputCtrl = TextEditingController();
  final ScrollController _scrollCtrl = ScrollController();
  final List<NostrMessage> _messages = <NostrMessage>[];
  bool _loading = true;
  bool _sending = false;
  bool _uploadingImage = false;
  bool _showEmojiPicker = false;
  String? _dmSubId;

  // Tag JSON pour identifier un message image chiffré dans le DM NIP-44
  static const String _imgTag = '_uenc_img';

  String get _peerName =>
      widget.peerProfile?.name ?? widget.peerHexPubkey.substring(0, 12);

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  @override
  void dispose() {
    if (_dmSubId != null) {
      NostrRelayService().cancelDmSubscription(_dmSubId!);
    }
    _inputCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadHistory() async {
    setState(() => _loading = true);
    try {
      final List<NostrMessage> msgs =
          await NostrRelayService().fetchNip44Messages(
        myHexPubkey: widget.myHexPubkey,
        myHexPrivkey: widget.myHexPrivkey,
        peerHexPubkey: widget.peerHexPubkey,
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
    } catch (_) {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  void _subscribeLive() {
    _dmSubId = NostrRelayService().subscribeToDms(
      myHexPubkey: widget.myHexPubkey,
      myHexPrivkey: widget.myHexPrivkey,
      onMessage: (NostrMessage msg) {
        if (!mounted) {
          return;
        }
        if (msg.senderHex != widget.peerHexPubkey) {
          return;
        }
        // Remove optimistic if any
        setState(() {
          _messages.removeWhere(
              (NostrMessage m) => m.pending && m.content == msg.content);
          _messages.add(msg);
        });
        _scrollToBottom();
      },
    );
  }

  Future<void> _send() async {
    final String text = _inputCtrl.text.trim();
    if (text.isEmpty || _sending) {
      return;
    }

    _inputCtrl.clear();

    // Optimistic message
    final NostrMessage optimistic = NostrMessage(
      id: 'pending_${DateTime.now().millisecondsSinceEpoch}',
      senderHex: widget.myHexPubkey,
      recipientHex: widget.peerHexPubkey,
      content: text,
      createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      pending: true,
    );
    setState(() {
      _messages.add(optimistic);
      _sending = true;
    });
    _scrollToBottom();

    final bool ok = await NostrRelayService().sendNip44Message(
      hexPrivateKey: widget.myHexPrivkey,
      recipientHexPubkey: widget.peerHexPubkey,
      plaintext: text,
    );

    if (mounted) {
      setState(() {
        _sending = false;
        if (ok) {
          // Mark as confirmed
          final int idx = _messages.indexOf(optimistic);
          if (idx >= 0) {
            _messages[idx] = optimistic.copyWith(pending: false);
          }
        } else {
          // Remove optimistic on failure
          _messages.remove(optimistic);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(tr('message_send_failed'))),
          );
        }
      });
    }
  }

  /// Extrait les métadonnées d'une image chiffrée depuis le contenu JSON d'un DM.
  Map<String, String>? _extractImagePayload(String content) {
    try {
      final Map<String, dynamic> json =
          jsonDecode(content) as Map<String, dynamic>;
      final Map<String, dynamic>? img =
          json[_imgTag] as Map<String, dynamic>?;
      if (img == null) return null;
      final String cid = img['cid'] as String? ?? '';
      final String encKey = img['enc_key'] as String? ?? '';
      if (cid.isEmpty || encKey.isEmpty) return null;
      return <String, String>{
        'cid': cid,
        'enc_key': encKey,
        'enc_type': img['enc_type'] as String? ?? 'aes256gcm',
        'filename': img['filename'] as String? ?? 'image',
      };
    } catch (_) {
      return null;
    }
  }

  /// Sélectionne une image, ouvre le dialog de composition, envoie chiffré.
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

    final Uint8List bytes = await xfile.readAsBytes();
    final String filename = xfile.name;

    // Dialog de composition : titre + légende + emoji
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

      // Le payload image est encapsulé dans le DM NIP-44 (déjà chiffré)
      final String plaintext = jsonEncode(<String, dynamic>{
        _imgTag: result.toJson(),
      });

      final NostrMessage optimistic = NostrMessage(
        id: 'pending_${DateTime.now().millisecondsSinceEpoch}',
        senderHex: widget.myHexPubkey,
        recipientHex: widget.peerHexPubkey,
        content: plaintext,
        createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        pending: true,
      );

      setState(() {
        _messages.add(optimistic);
        _sending = true;
      });
      _scrollToBottom();

      final bool ok = await NostrRelayService().sendNip44Message(
        hexPrivateKey: widget.myHexPrivkey,
        recipientHexPubkey: widget.peerHexPubkey,
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
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(tr('message_send_failed'))),
            );
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _sending = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur upload image : $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _uploadingImage = false);
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

  // ── Widgets ───────────────────────────────────────────────────────────────

  Widget _buildBubble(NostrMessage msg) {
    final bool isMe = msg.isFromMe(widget.myHexPubkey);
    final Map<String, String>? imgPayload = _extractImagePayload(msg.content);

    final Color bubbleColor = isMe
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.surfaceContainerHighest;
    final Color textColor = isMe
        ? Theme.of(context).colorScheme.onPrimary
        : Theme.of(context).colorScheme.onSurface;

    final String time = _formatTime(msg.dateTime);

    // Bulle image chiffrée — widget dédié avec miniature auto-chargée
    if (imgPayload != null) {
      return EncryptedImageBubble(
        cid: imgPayload['cid']!,
        encKeyHex: imgPayload['enc_key']!,
        isMe: isMe,
        time: time,
        pending: msg.pending,
        filename: imgPayload['filename'],
        title: imgPayload['title'],
        caption: imgPayload['caption'],
        bubbleColor: bubbleColor,
        textColor: textColor,
      );
    }

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onLongPress: () {
          Clipboard.setData(ClipboardData(text: msg.content));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(tr('message_copied')),
              duration: const Duration(seconds: 1),
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.only(
            left: isMe ? 64 : 8,
            right: isMe ? 8 : 64,
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
                    time,
                    style: TextStyle(
                      fontSize: 11,
                      color: textColor.withAlpha(160),
                    ),
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

  String _formatTime(DateTime dt) {
    return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }

  Widget _buildDateSeparator(DateTime dt) {
    final String label = _isToday(dt)
        ? tr('date_today')
        : _isYesterday(dt)
            ? tr('date_yesterday')
            : '${dt.day}/${dt.month}/${dt.year}';
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Theme.of(context)
                .colorScheme
                .onSurface
                .withAlpha(30),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withAlpha(150),
            ),
          ),
        ),
      ),
    );
  }

  bool _isToday(DateTime dt) {
    final DateTime now = DateTime.now();
    return dt.year == now.year &&
        dt.month == now.month &&
        dt.day == now.day;
  }

  bool _isYesterday(DateTime dt) {
    final DateTime yesterday =
        DateTime.now().subtract(const Duration(days: 1));
    return dt.year == yesterday.year &&
        dt.month == yesterday.month &&
        dt.day == yesterday.day;
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

    return ListView(
      controller: _scrollCtrl,
      padding: const EdgeInsets.symmetric(vertical: 8),
      children: items,
    );
  }

  Widget _buildInput() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          color: Theme.of(context).colorScheme.surface,
          padding: EdgeInsets.only(
            left: 8,
            right: 8,
            top: 8,
            bottom:
                _showEmojiPicker ? 8 : MediaQuery.of(context).viewInsets.bottom + 8,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              // Bouton image chiffrée
              Tooltip(
                message: 'Envoyer une image (chiffrée)',
                child: IconButton(
                  onPressed:
                      (_sending || _uploadingImage) ? null : _pickAndSendImage,
                  icon: _uploadingImage
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.image_outlined),
                ),
              ),
              // Champ de texte + toggle emoji
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: _inputCtrl,
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          minLines: 1,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                            hintText: tr('message_hint'),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                          ),
                          onSubmitted: (_) => _send(),
                          onTap: () {
                            if (_showEmojiPicker) {
                              setState(() => _showEmojiPicker = false);
                            }
                          },
                        ),
                      ),
                      // Bouton emoji
                      IconButton(
                        tooltip: 'Emoji',
                        icon: Icon(
                          Icons.emoji_emotions_outlined,
                          color: _showEmojiPicker
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withAlpha(140),
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
        ),
        // Emoji picker (affiché à la place du clavier)
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

  @override
  Widget build(BuildContext context) {
    final String? picture = widget.peerProfile?.picture;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: <Widget>[
            CircleAvatar(
              radius: 18,
              backgroundImage:
                  picture != null && picture.isNotEmpty
                      ? NetworkImage(picture)
                      : null,
              onBackgroundImageError: (_, __) {},
              child: (picture == null || picture.isEmpty)
                  ? Text(
                      _peerName.isNotEmpty ? _peerName[0].toUpperCase() : '?',
                      style: const TextStyle(fontSize: 14),
                    )
                  : null,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _peerName,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (widget.peerProfile?.city?.isNotEmpty ?? false)
                    Text(
                      widget.peerProfile!.city!,
                      style: const TextStyle(fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadHistory,
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : _messages.isEmpty
                    ? Center(child: Text(tr('messages_empty_chat')))
                    : _buildMessageList(),
          ),
          _buildInput(),
        ],
      ),
    );
  }
}
