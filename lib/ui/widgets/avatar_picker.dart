import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AvatarPicker extends StatefulWidget {
  const AvatarPicker({
    super.key,
    required this.onSelected,
    this.existingBase64,
    this.label,
    this.avatarRadius = 80,
  });

  /// Callback when avatar is successfully selected and converted to base64
  final void Function(String base64) onSelected;

  /// Optional: pre-existing avatar to display
  final String? existingBase64;

  /// Optional: label for the button
  final String? label;

  /// Optional: size of the avatar circle (default: 80)
  final double avatarRadius;

  @override
  State<AvatarPicker> createState() => _AvatarPickerState();
}

class _AvatarPickerState extends State<AvatarPicker> {
  static const int maxAvatarSizeBytes = 1024 * 1024; // 1MB
  static const List<String> allowedMimeTypes = [
    'image/png',
    'image/jpeg',
    'image/jpg',
  ];

  final ImagePicker _picker = ImagePicker();

  String? _selectedBase64;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _selectedBase64 = widget.existingBase64;
  }

  Future<void> _pickImage() async {
    try {
      if (_isProcessing) {
        return;
      }

      setState(() => _isProcessing = true);

      final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
      if (file == null) {
        setState(() => _isProcessing = false);
        return;
      }

      final bytes = await file.readAsBytes();

      // Validate size
      if (bytes.lengthInBytes > maxAvatarSizeBytes) {
        _showErrorSnackBar('Image size exceeds 1MB limit');
        setState(() => _isProcessing = false);
        return;
      }

      // Validate MIME type
      final mimeType = file.mimeType ?? 'image/jpeg';
      if (!allowedMimeTypes.contains(mimeType.toLowerCase())) {
        _showErrorSnackBar('Only PNG and JPG images are allowed');
        setState(() => _isProcessing = false);
        return;
      }

      // Convert to base64
      final base64String = base64Encode(bytes);

      setState(() {
        _selectedBase64 = base64String;
        _isProcessing = false;
      });

      // Notify parent
      widget.onSelected(base64String);
    } catch (e) {
      _showErrorSnackBar('Error picking image: $e');
      setState(() => _isProcessing = false);
    }
  }

  void _showErrorSnackBar(String message) {
    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Uint8List? _getAvatarBytes() {
    if (_selectedBase64 != null) {
      try {
        return base64Decode(_selectedBase64!);
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final avatarBytes = _getAvatarBytes();

    return Column(
      children: [
        GestureDetector(
          onTap: _isProcessing ? null : _pickImage,
          child: Stack(
            children: [
              CircleAvatar(
                radius: widget.avatarRadius,
                backgroundImage:
                    avatarBytes != null ? MemoryImage(avatarBytes) : null,
                child: avatarBytes == null
                    ? const Icon(Icons.person, size: 48)
                    : null,
              ),
              if (!_isProcessing)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(51),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                )
              else
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          widget.label ?? 'Tap to change photo',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
