import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../services/encrypted_file_service.dart';

/// Cache mémoire partagé pour les images déchiffrées (par CID).
/// Vit le temps de la session — libéré à la sortie de l'app.
final Map<String, Uint8List> _decryptedImageCache = {};

/// Bulle d'image chiffrée pour les messageries.
///
/// Affiche automatiquement une miniature (chargée de façon asynchrone),
/// avec titre et légende optionnels. Un tap ouvre l'image en plein écran.
class EncryptedImageBubble extends StatefulWidget {
  const EncryptedImageBubble({
    super.key,
    required this.cid,
    required this.encKeyHex,
    required this.isMe,
    required this.time,
    required this.pending,
    this.filename,
    this.title,
    this.caption,
    this.bubbleColor,
    this.textColor,
  });

  final String cid;
  final String encKeyHex;
  final bool isMe;
  final String time;
  final bool pending;
  final String? filename;
  final String? title;
  final String? caption;
  final Color? bubbleColor;
  final Color? textColor;

  @override
  State<EncryptedImageBubble> createState() => _EncryptedImageBubbleState();
}

class _EncryptedImageBubbleState extends State<EncryptedImageBubble> {
  Uint8List? _bytes;
  bool _loading = false;
  bool _error = false;

  @override
  void initState() {
    super.initState();
    _maybeLoad();
  }

  Future<void> _maybeLoad() async {
    if (_decryptedImageCache.containsKey(widget.cid)) {
      if (mounted) setState(() => _bytes = _decryptedImageCache[widget.cid]);
      return;
    }
    if (!mounted) return;
    setState(() => _loading = true);
    try {
      final Uint8List bytes = await EncryptedFileService.downloadAndDecrypt(
        cid: widget.cid,
        encKeyHex: widget.encKeyHex,
      );
      _decryptedImageCache[widget.cid] = bytes;
      if (mounted) setState(() { _bytes = bytes; _loading = false; });
    } catch (_) {
      if (mounted) setState(() { _loading = false; _error = true; });
    }
  }

  void _openFullscreen() {
    if (_bytes == null) return;
    Navigator.of(context).push(
      PageRouteBuilder<void>(
        opaque: false,
        barrierDismissible: true,
        barrierColor: Colors.black87,
        pageBuilder: (_, __, ___) => _FullscreenImageView(
          bytes: _bytes!,
          title: widget.title ?? widget.filename ?? 'Image',
          caption: widget.caption,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color bg = widget.bubbleColor ??
        (widget.isMe
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.surfaceContainerHighest);
    final Color fg = widget.textColor ??
        (widget.isMe
            ? Theme.of(context).colorScheme.onPrimary
            : Theme.of(context).colorScheme.onSurface);

    return Align(
      alignment:
          widget.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          left: widget.isMe ? 64 : 8,
          right: widget.isMe ? 8 : 64,
          top: 2,
          bottom: 2,
        ),
        constraints: const BoxConstraints(maxWidth: 260),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(18),
            topRight: const Radius.circular(18),
            bottomLeft: Radius.circular(widget.isMe ? 18 : 4),
            bottomRight: Radius.circular(widget.isMe ? 4 : 18),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withAlpha(25),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: _bytes != null ? _openFullscreen : null,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // ── Miniature ──────────────────────────────────────────
              SizedBox(
                height: 180,
                child: _buildThumbnail(fg),
              ),

              // ── Texte (titre + légende + horodatage) ────────────────
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: widget.isMe
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: <Widget>[
                    if (widget.title != null && widget.title!.isNotEmpty)
                      Text(
                        widget.title!,
                        style: TextStyle(
                          color: fg,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    if (widget.caption != null && widget.caption!.isNotEmpty) ...<Widget>[
                      const SizedBox(height: 2),
                      Text(
                        widget.caption!,
                        style:
                            TextStyle(color: fg.withAlpha(220), fontSize: 13),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    const SizedBox(height: 4),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(Icons.lock_outline,
                            size: 10, color: fg.withAlpha(140)),
                        const SizedBox(width: 3),
                        Text(
                          widget.time,
                          style: TextStyle(
                              fontSize: 10, color: fg.withAlpha(140)),
                        ),
                        if (widget.isMe) ...<Widget>[
                          const SizedBox(width: 3),
                          Icon(
                            widget.pending
                                ? Icons.access_time
                                : Icons.done,
                            size: 12,
                            color: fg.withAlpha(140),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThumbnail(Color fg) {
    if (_loading) {
      return Container(
        color: Colors.black12,
        child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
      );
    }
    if (_error || _bytes == null) {
      return Container(
        color: Colors.black12,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.broken_image_outlined, size: 36, color: fg.withAlpha(120)),
            const SizedBox(height: 4),
            Text(
              'Image non disponible',
              style: TextStyle(fontSize: 11, color: fg.withAlpha(120)),
            ),
          ],
        ),
      );
    }
    return Image.memory(
      _bytes!,
      fit: BoxFit.cover,
      gaplessPlayback: true,
    );
  }
}

// ── Plein écran ────────────────────────────────────────────────────────────

class _FullscreenImageView extends StatelessWidget {
  const _FullscreenImageView({
    required this.bytes,
    required this.title,
    this.caption,
  });

  final Uint8List bytes;
  final String title;
  final String? caption;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            // AppBar transparente
            SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Image
            Expanded(
              child: InteractiveViewer(
                child: Center(
                  child: Image.memory(bytes, fit: BoxFit.contain),
                ),
              ),
            ),
            // Légende
            if (caption != null && caption!.isNotEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12),
                color: Colors.black54,
                child: Text(
                  caption!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
