import 'dart:typed_data';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

/// Résultat retourné par [showImageCompositionSheet].
class ImageCompositionResult {
  const ImageCompositionResult({
    required this.title,
    required this.caption,
  });

  final String title;
  final String caption;
}

/// Ouvre le bottom sheet de composition d'image.
///
/// [imageBytes] est la preview. Retourne [ImageCompositionResult] si l'utilisateur
/// valide, ou `null` s'il annule.
Future<ImageCompositionResult?> showImageCompositionSheet({
  required BuildContext context,
  required Uint8List imageBytes,
  required String filename,
}) {
  return showModalBottomSheet<ImageCompositionResult>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _ImageCompositionSheet(
      imageBytes: imageBytes,
      filename: filename,
    ),
  );
}

class _ImageCompositionSheet extends StatefulWidget {
  const _ImageCompositionSheet({
    required this.imageBytes,
    required this.filename,
  });

  final Uint8List imageBytes;
  final String filename;

  @override
  State<_ImageCompositionSheet> createState() => _ImageCompositionSheetState();
}

class _ImageCompositionSheetState extends State<_ImageCompositionSheet> {
  final TextEditingController _captionCtrl = TextEditingController();
  final TextEditingController _titleCtrl = TextEditingController();
  bool _showEmojiPicker = false;
  // true = focus sur légende, false = focus sur titre
  bool _emojiTargetCaption = true;

  @override
  void dispose() {
    _captionCtrl.dispose();
    _titleCtrl.dispose();
    super.dispose();
  }

  void _toggleEmoji({required bool forCaption}) {
    setState(() {
      if (_showEmojiPicker && _emojiTargetCaption == forCaption) {
        _showEmojiPicker = false;
      } else {
        _showEmojiPicker = true;
        _emojiTargetCaption = forCaption;
        FocusScope.of(context).unfocus();
      }
    });
  }

  void _send() {
    Navigator.of(context).pop(ImageCompositionResult(
      title: _titleCtrl.text.trim(),
      caption: _captionCtrl.text.trim(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final double kbHeight = MediaQuery.of(context).viewInsets.bottom;
    return AnimatedPadding(
      duration: const Duration(milliseconds: 150),
      padding: EdgeInsets.only(bottom: kbHeight),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // ── Drag handle ──────────────────────────────────────────
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            // ── Preview de l'image ────────────────────────────────────
            Container(
              height: 220,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withAlpha(30),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Image.memory(widget.imageBytes, fit: BoxFit.cover),
                  // Overlay avec nom de fichier
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: <Color>[Colors.black54, Colors.transparent],
                        ),
                      ),
                      child: Text(
                        widget.filename,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // ── Champ titre ─────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _InputRow(
                controller: _titleCtrl,
                hint: 'Titre (optionnel)',
                icon: Icons.title,
                onEmojiTap: () => _toggleEmoji(forCaption: false),
                emojiActive: _showEmojiPicker && !_emojiTargetCaption,
              ),
            ),
            const SizedBox(height: 10),

            // ── Champ légende ─────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _InputRow(
                controller: _captionCtrl,
                hint: 'Légende / message…',
                icon: Icons.chat_bubble_outline,
                onEmojiTap: () => _toggleEmoji(forCaption: true),
                emojiActive: _showEmojiPicker && _emojiTargetCaption,
                maxLines: 3,
              ),
            ),
            const SizedBox(height: 12),

            // ── Boutons action ────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Annuler'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: _send,
                      icon: const Icon(Icons.send, size: 18),
                      label: const Text('Envoyer'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // ── Emoji picker (togglable) ─────────────────────────────
            Offstage(
              offstage: !_showEmojiPicker,
              child: SizedBox(
                height: 280,
                child: EmojiPicker(
                  textEditingController: _emojiTargetCaption
                      ? _captionCtrl
                      : _titleCtrl,
                  config: Config(
                    height: 280,
                    checkPlatformCompatibility: true,
                    emojiViewConfig: const EmojiViewConfig(
                      emojiSizeMax: 28,
                      columns: 8,
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
        ),
      ),
    );
  }
}

/// Ligne de saisie avec bouton emoji intégré.
class _InputRow extends StatelessWidget {
  const _InputRow({
    required this.controller,
    required this.hint,
    required this.icon,
    required this.onEmojiTap,
    required this.emojiActive,
    this.maxLines = 1,
  });

  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final VoidCallback onEmojiTap;
  final bool emojiActive;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.only(left: 12, top: 12, bottom: 12),
            child: Icon(icon, size: 18,
                color: Theme.of(context).colorScheme.onSurface.withAlpha(120)),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              minLines: 1,
              maxLines: maxLines,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 12),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.emoji_emotions_outlined,
              color: emojiActive
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurface.withAlpha(120),
            ),
            onPressed: onEmojiTap,
            tooltip: 'Emoji',
          ),
        ],
      ),
    );
  }
}
