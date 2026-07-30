import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../services/encrypted_file_service.dart';

/// Cache mémoire partagé (par CID) — même principe que
/// [EncryptedImageBubble], vit le temps de la session.
final Map<String, Uint8List> _decryptedAvatarCache = <String, Uint8List>{};

/// Avatar circulaire pour un raccourci "love" — affiche la photo chiffrée
/// IPFS (UENC) si disponible, sinon une icône cœur par défaut.
class EncryptedAvatar extends StatefulWidget {
  const EncryptedAvatar({
    super.key,
    this.cid,
    this.encKeyHex,
    this.radius = 24,
    this.fallbackColor,
    this.iconColor,
  });

  final String? cid;
  final String? encKeyHex;
  final double radius;
  final Color? fallbackColor;
  final Color? iconColor;

  @override
  State<EncryptedAvatar> createState() => _EncryptedAvatarState();
}

class _EncryptedAvatarState extends State<EncryptedAvatar> {
  Uint8List? _bytes;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _maybeLoad();
  }

  @override
  void didUpdateWidget(covariant EncryptedAvatar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.cid != widget.cid) {
      _bytes = null;
      _maybeLoad();
    }
  }

  Future<void> _maybeLoad() async {
    final String? cid = widget.cid;
    final String? encKeyHex = widget.encKeyHex;
    if (cid == null || cid.isEmpty || encKeyHex == null || encKeyHex.isEmpty) {
      return;
    }
    if (_decryptedAvatarCache.containsKey(cid)) {
      if (mounted) {
        setState(() => _bytes = _decryptedAvatarCache[cid]);
      }
      return;
    }
    if (!mounted) {
      return;
    }
    setState(() => _loading = true);
    try {
      final Uint8List bytes = await EncryptedFileService.downloadAndDecrypt(
        cid: cid,
        encKeyHex: encKeyHex,
      );
      _decryptedAvatarCache[cid] = bytes;
      if (mounted) {
        setState(() {
          _bytes = bytes;
          _loading = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color bg = widget.fallbackColor ?? const Color(0xFFFCE4EC);
    final Color fg = widget.iconColor ?? const Color(0xFFE91E8C);

    if (_bytes != null) {
      return CircleAvatar(
        radius: widget.radius,
        backgroundImage: MemoryImage(_bytes!),
      );
    }
    return CircleAvatar(
      radius: widget.radius,
      backgroundColor: bg,
      child: _loading
          ? SizedBox(
              width: widget.radius,
              height: widget.radius,
              child: CircularProgressIndicator(strokeWidth: 2, color: fg),
            )
          : Icon(Icons.favorite, color: fg, size: widget.radius),
    );
  }
}
