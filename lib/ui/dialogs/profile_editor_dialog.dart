import 'dart:convert';
import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/models/contact.dart';
import '../../env.dart';
import '../../g1/multipass_service.dart';
import '../../g1/nostr/nostr_keys.dart';
import '../../g1/nostr/nostr_profile.dart';
import '../../g1/nostr/nostr_relay_service.dart';
import '../../shared_prefs_helper_v2.dart';
import '../../ui/logger.dart';
import '../widgets/avatar_picker.dart';

class ProfileEditorDialog extends StatefulWidget {
  const ProfileEditorDialog({
    super.key,
    required this.currentContact,
    required this.onSaved,
    this.nostrProfile,
  });
  final Contact currentContact;
  final VoidCallback onSaved;
  /// Current NOSTR kind-0 profile. When provided, the form fields are
  /// pre-filled with the live profile values (name, about, city, picture URL).
  final NostrProfile? nostrProfile;

  @override
  State<ProfileEditorDialog> createState() => _ProfileEditorDialogState();
}

class _ProfileEditorDialogState extends State<ProfileEditorDialog> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _cityController;
  late List<Map<String, String>> _socials;

  String? _selectedAvatarBase64;
  String? _selectedBannerBase64;
  bool _isSaving = false;

  // Picture URL from the live kind-0 profile (shown as preview when no new
  // image has been picked yet).
  String? _existingPictureUrl;
  // _existingBannerUrl intentionally omitted until banner editing is implemented

  @override
  void initState() {
    super.initState();
    final NostrProfile? np = widget.nostrProfile;
    // Priority: NOSTR kind-0 > Contact (local cache)
    _titleController = TextEditingController(
        text: np?.name ?? widget.currentContact.name ?? '');
    _descriptionController = TextEditingController(
        text: np?.about ?? widget.currentContact.description ?? '');
    _cityController = TextEditingController(
        text: np?.city ?? widget.currentContact.city ?? '');
    _socials = List<Map<String, String>>.from(
        np?.socials ?? widget.currentContact.socials ?? <Map<String, String>>[]);
    _existingPictureUrl = np?.picture;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  bool _validateInputs() {
    if (_titleController.text.isEmpty) {
      _showError('profile.name.required'.tr());
      return false;
    }
    if (_titleController.text.length > 200) {
      _showError('profile.name.max_length'.tr());
      return false;
    }
    if (_descriptionController.text.length > 1000) {
      _showError('profile.description.max_length'.tr());
      return false;
    }
    return true;
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future<void> _saveProfile() async {
    if (!_validateInputs()) {
      return;
    }

    setState(() => _isSaving = true);

    try {
      // Publish to NOSTR relay
      bool nostrSuccess = false;

      // Publish profile via NOSTR relay
      final NostrRelayService relay = NostrRelayService();

      if (!relay.isConnected) {
        loggerDev('NostrRelay not connected, trying to connect...');
        await relay.connect(Env.resolvedNostrRelay);
      }

      if (relay.isConnected) {
        try {
          final SharedPreferencesHelperV2 helper = SharedPreferencesHelperV2();
          final String? nsec = await helper.getNostrNsec();
          if (nsec != null) {
            final String hexPrivateKey = NostrKeys.nsecToHex(nsec);
            // Derive npub from private key for API calls
            final String hexPubkey =
                NostrRelayService.derivePublicKey(hexPrivateKey);
            final String npub = NostrKeys.hexToNpub(hexPubkey);

            // Upload avatar to IPFS via UPassport API if changed
            String? pictureUrl;
            if (_selectedAvatarBase64 != null) {
              try {
                final List<int> imageBytes =
                    base64Decode(_selectedAvatarBase64!);
                pictureUrl = await MultipassService.uploadImage(
                  npub: npub,
                  imageBytes: Uint8List.fromList(imageBytes),
                  imageType: 'avatar',
                  filename: 'avatar.jpg',
                );
                loggerDev('Avatar uploaded: $pictureUrl');
              } catch (e) {
                loggerDev('Avatar upload error: $e');
              }
            }

            // Upload banner to IPFS via UPassport API if changed
            String? bannerUrl;
            if (_selectedBannerBase64 != null) {
              try {
                final List<int> bannerBytes =
                    base64Decode(_selectedBannerBase64!);
                bannerUrl = await MultipassService.uploadImage(
                  npub: npub,
                  imageBytes: Uint8List.fromList(bannerBytes),
                  imageType: 'banner',
                  filename: 'banner.jpg',
                );
                loggerDev('Banner uploaded: $bannerUrl');
              } catch (e) {
                loggerDev('Banner upload error: $e');
              }
            }

            final NostrProfile profile = NostrProfile(
              npub: npub,
              name: _titleController.text,
              about: _descriptionController.text.isEmpty
                  ? null
                  : _descriptionController.text,
              city: _cityController.text.isEmpty ? null : _cityController.text,
              picture: pictureUrl,
              banner: bannerUrl,
              picture64: _selectedAvatarBase64,
              socials: _socials.isEmpty ? null : _socials,
            );
            nostrSuccess =
                await relay.publishProfile(profile, hexPrivateKey);
            loggerDev('NOSTR profile publish: $nostrSuccess');
          } else {
            loggerDev('Nostr nsec not found, cannot publish profile');
          }
        } catch (e) {
          loggerDev('Error publishing NOSTR profile: $e');
        }
      } else {
        loggerDev('NostrRelay connection failed');
      }

      if (!mounted) {
        return;
      }

      if (nostrSuccess) {
        // Update local storage
        final SharedPreferencesHelperV2 helper = SharedPreferencesHelperV2();
        helper.updateProfile(
          name: _titleController.text,
          description: _descriptionController.text.isEmpty
              ? null
              : _descriptionController.text,
          city: _cityController.text.isEmpty ? null : _cityController.text,
          socials: _socials.isEmpty ? null : _socials,
        );

        _showSuccess('profile.saved'.tr());
        widget.onSaved();
        if (mounted) {
          Navigator.pop(context);
        }
      } else {
        loggerDev('Nostr publish failed (nostrSuccess=false)');
        _showError('profile.save_error'.tr());
      }
    } catch (e) {
      _showError('profile.save_error'.tr());
      logger('Error saving profile: $e');
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  void _addSocial() {
    setState(() {
      _socials.add(<String, String>{'type': '', 'url': ''});
    });
  }

  void _removeSocial(int index) {
    setState(() {
      _socials.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 800),
        child: Column(
          children: <Widget>[
            // Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'profile.edit_title'.tr(),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            const Divider(),
            // Body
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Banner Picker
                    _BannerPicker(
                      existingBase64: _selectedBannerBase64,
                      onSelected: (String base64) {
                        setState(() => _selectedBannerBase64 = base64);
                      },
                    ),
                    const SizedBox(height: 16),
                    // Avatar Picker
                    Center(
                      child: AvatarPicker(
                        existingBase64: _selectedAvatarBase64
                            ?? (widget.currentContact.avatar != null
                                ? base64Encode(widget.currentContact.avatar!)
                                : null),
                        // Show NOSTR picture URL as preview when no local base64
                        existingUrl: _existingPictureUrl,
                        onSelected: (String base64) {
                          setState(() => _selectedAvatarBase64 = base64);
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Title field
                    Text('profile.name'.tr(),
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        hintText: 'profile.name.hint'.tr(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      maxLength: 200,
                      enabled: !_isSaving,
                    ),
                    const SizedBox(height: 16),
                    // Description field
                    Text('profile.description'.tr(),
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        hintText: 'profile.description.hint'.tr(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      maxLines: 4,
                      maxLength: 1000,
                      enabled: !_isSaving,
                    ),
                    const SizedBox(height: 16),
                    // City field
                    Text('profile.city'.tr(),
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _cityController,
                      decoration: InputDecoration(
                        hintText: 'profile.city.hint'.tr(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      enabled: !_isSaving,
                    ),
                    const SizedBox(height: 16),
                    // Socials
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('profile.socials'.tr(),
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: _isSaving ? null : _addSocial,
                        ),
                      ],
                    ),
                    ..._socials
                        .asMap()
                        .entries
                        .map((MapEntry<int, Map<String, String>> entry) {
                      final int index = entry.key;
                      final Map<String, String> social = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: TextFormField(
                                initialValue: social['type'] ?? '',
                                decoration: InputDecoration(
                                  labelText: 'Type',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                enabled: !_isSaving,
                                onChanged: (String value) {
                                  _socials[index]['type'] = value;
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              flex: 2,
                              child: TextFormField(
                                initialValue: social['url'] ?? '',
                                decoration: InputDecoration(
                                  labelText: 'URL',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                enabled: !_isSaving,
                                onChanged: (String value) {
                                  _socials[index]['url'] = value;
                                },
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed:
                                  _isSaving ? null : () => _removeSocial(index),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
            const Divider(),
            // Footer with buttons
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    onPressed: _isSaving ? null : () => Navigator.pop(context),
                    child: Text('common.cancel'.tr()),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: _isSaving ? null : _saveProfile,
                    icon: _isSaving
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Icon(Icons.save),
                    label: Text(
                        _isSaving ? 'common.saving'.tr() : 'common.save'.tr()),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Banner picker widget — rectangular image for NOSTR profile banner
class _BannerPicker extends StatefulWidget {
  const _BannerPicker({
    required this.onSelected,
    this.existingBase64,
  });

  final void Function(String base64) onSelected;
  final String? existingBase64;

  @override
  State<_BannerPicker> createState() => _BannerPickerState();
}

class _BannerPickerState extends State<_BannerPicker> {
  static const int maxBannerSizeBytes = 2 * 1024 * 1024; // 2MB
  final ImagePicker _picker = ImagePicker();
  String? _selectedBase64;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _selectedBase64 = widget.existingBase64;
  }

  Future<void> _pickBanner() async {
    if (_isProcessing) return;
    setState(() => _isProcessing = true);

    try {
      final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
      if (file == null) {
        setState(() => _isProcessing = false);
        return;
      }

      final Uint8List bytes = await file.readAsBytes();
      if (bytes.lengthInBytes > maxBannerSizeBytes) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Banner image exceeds 2MB limit'),
              backgroundColor: Colors.red,
            ),
          );
        }
        setState(() => _isProcessing = false);
        return;
      }

      final String base64String = base64Encode(bytes);
      setState(() {
        _selectedBase64 = base64String;
        _isProcessing = false;
      });
      widget.onSelected(base64String);
    } catch (e) {
      setState(() => _isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    Uint8List? bannerBytes;
    if (_selectedBase64 != null) {
      try {
        bannerBytes = base64Decode(_selectedBase64!);
      } catch (_) {}
    }

    return GestureDetector(
      onTap: _isProcessing ? null : _pickBanner,
      child: Container(
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
          image: bannerBytes != null
              ? DecorationImage(
                  image: MemoryImage(bannerBytes),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: Stack(
          children: <Widget>[
            if (bannerBytes == null)
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.panorama,
                        size: 32,
                        color: Theme.of(context).colorScheme.onSurfaceVariant),
                    const SizedBox(height: 4),
                    Text(
                      'profile.banner.tap'.tr(),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            Positioned(
              bottom: 8,
              right: 8,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withAlpha(200),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(8),
                child: _isProcessing
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Icon(Icons.camera_alt,
                        color: Colors.white, size: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
