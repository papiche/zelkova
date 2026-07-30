import 'dart:typed_data';

import 'package:bip340/bip340.dart' as bip340;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../data/models/love_contact.dart';
import '../../g1/multipass_service.dart';
import '../../g1/nostr/nostr_keys.dart';
import '../../g1/nostr/nostr_relay_service.dart';
import '../../services/encrypted_file_service.dart';
import '../../shared_prefs_helper_v2.dart';
import '../logger.dart';
import '../qr_manager.dart';
import '../widgets/encrypted_avatar.dart';

/// Raccourcis de contacts "love" — échangés par QR code (leur HEX_LOVE),
/// utilisés pour envoyer des ♥ (kind 7 → Ğ1-N²) et pour publier une follow
/// list kind 3 signée par la clé LOVE (voir [_publishLoveFollowList]) —
/// mécanisme de réciprocité LOVE↔LOVE nécessaire au calcul du DU
/// hyper-relativiste (N2_Economics.py).
///
/// Distinct de la liste de contacts NOSTR/WoT classique (`ContactsCubit`) —
/// ici uniquement des identités LOVE, jamais des MULTIPASS.
class LoveContactsScreen extends StatefulWidget {
  const LoveContactsScreen({super.key});

  @override
  State<LoveContactsScreen> createState() => _LoveContactsScreenState();
}

class _LoveContactsScreenState extends State<LoveContactsScreen> {
  static const Color _loveRose = Color(0xFFE91E8C);
  static const Color _loveRoseLight = Color(0xFFFCE4EC);

  final TextEditingController _searchCtrl = TextEditingController();

  bool _loading = true;
  bool _needsActivation = false;
  String? _myLoveHexPriv;
  String? _myLoveHexPub;
  List<LoveContact> _contacts = <LoveContact>[];
  String _query = '';

  @override
  void initState() {
    super.initState();
    _init();
    _searchCtrl.addListener(() {
      setState(() => _query = _searchCtrl.text.trim().toLowerCase());
    });
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  Future<void> _init() async {
    setState(() => _loading = true);
    final String? loveNsec = await SharedPreferencesHelperV2().getLoveNsec();
    if (loveNsec == null || loveNsec.isEmpty) {
      setState(() {
        _loading = false;
        _needsActivation = true;
      });
      return;
    }
    final String hexPriv = NostrKeys.nsecToHex(loveNsec);
    final String hexPub = bip340.getPublicKey(hexPriv);
    final List<LoveContact> contacts =
        await SharedPreferencesHelperV2().getLoveContacts();
    if (!mounted) {
      return;
    }
    setState(() {
      _myLoveHexPriv = hexPriv;
      _myLoveHexPub = hexPub;
      _contacts = contacts;
      _loading = false;
    });
  }

  List<LoveContact> get _filtered {
    if (_query.isEmpty) {
      return _contacts;
    }
    return _contacts
        .where((LoveContact c) =>
            c.nickname.toLowerCase().contains(_query) ||
            c.hexLove.toLowerCase().contains(_query))
        .toList();
  }

  /// Republie la follow list (kind 3) signée par la clé LOVE — la liste
  /// complète des raccourcis remplace la précédente (NIP-01 replaceable).
  Future<void> _publishLoveFollowList() async {
    if (_myLoveHexPriv == null) {
      return;
    }
    final bool ok = await NostrRelayService().publishContacts(
      hexPrivateKey: _myLoveHexPriv!,
      hexPubkeys: _contacts.map((LoveContact c) => c.hexLove).toList(),
    );
    if (!ok) {
      logger('[LoveContactsScreen] échec publication kind 3 LOVE');
    }
  }

  Future<void> _saveContacts(List<LoveContact> updated) async {
    setState(() => _contacts = updated);
    await SharedPreferencesHelperV2().saveLoveContacts(updated);
    await _publishLoveFollowList();
  }

  void _showMyQr() {
    if (_myLoveHexPub == null) {
      return;
    }
    showDialog<void>(
      context: context,
      builder: (BuildContext ctx) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                'Ton QR love — fais-le scanner',
                style: TextStyle(fontWeight: FontWeight.w600, color: _loveRose),
              ),
              const SizedBox(height: 16),
              QrImageView(
                data: 'love:${_myLoveHexPub!}',
                size: 220,
                eyeStyle: const QrEyeStyle(
                    eyeShape: QrEyeShape.square, color: _loveRose),
                dataModuleStyle: const QrDataModuleStyle(
                    dataModuleShape: QrDataModuleShape.square,
                    color: Colors.black87),
              ),
              const SizedBox(height: 12),
              Text(
                '${_myLoveHexPub!.substring(0, 16)}…',
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Fermer'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _scanAndAdd() async {
    final String? raw = await QrManager.qrScan(context);
    if (raw == null || raw.isEmpty || !mounted) {
      return;
    }
    final String hex = raw.startsWith('love:') ? raw.substring(5) : raw;
    if (hex.length != 64) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('QR code invalide (pas une clé love)')),
      );
      return;
    }
    if (_myLoveHexPub != null && hex == _myLoveHexPub) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("C'est ton propre QR code")),
      );
      return;
    }
    if (_contacts.any((LoveContact c) => c.hexLove == hex)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Déjà dans tes raccourcis')),
      );
      return;
    }
    await _openAddContactDialog(hex);
  }

  Future<void> _openAddContactDialog(String hex) async {
    final TextEditingController nameCtrl =
        TextEditingController(text: hex.substring(0, 8));
    Uint8List? photoBytes;
    bool uploading = false;

    await showDialog<void>(
      context: context,
      builder: (BuildContext ctx) => StatefulBuilder(
        builder: (BuildContext ctx, StateSetter setSheetState) => AlertDialog(
          title: const Text('Ajouter ce raccourci love'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircleAvatar(
                radius: 32,
                backgroundColor: _loveRoseLight,
                backgroundImage:
                    photoBytes != null ? MemoryImage(photoBytes!) : null,
                child: photoBytes == null
                    ? const Icon(Icons.favorite, color: _loveRose, size: 32)
                    : null,
              ),
              const SizedBox(height: 8),
              TextButton.icon(
                onPressed: uploading
                    ? null
                    : () async {
                        final ImagePicker picker = ImagePicker();
                        final XFile? xfile = await picker.pickImage(
                          source: ImageSource.camera,
                          maxWidth: 800,
                          maxHeight: 800,
                          imageQuality: 80,
                        );
                        if (xfile == null) {
                          return;
                        }
                        final Uint8List bytes = await xfile.readAsBytes();
                        setSheetState(() => photoBytes = bytes);
                      },
                icon: const Icon(Icons.camera_alt, size: 18, color: _loveRose),
                label: const Text('Prendre une photo',
                    style: TextStyle(color: _loveRose)),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: 'Surnom'),
              ),
              const SizedBox(height: 8),
              Text('${hex.substring(0, 24)}…',
                  style: const TextStyle(fontSize: 11, color: Colors.black45)),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Annuler'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: _loveRose),
              onPressed: uploading
                  ? null
                  : () async {
                      String? photoCid;
                      String? photoEncKeyHex;
                      if (photoBytes != null) {
                        setSheetState(() => uploading = true);
                        try {
                          final EncryptedUploadResult result =
                              await EncryptedFileService.upload(
                            fileBytes: photoBytes!,
                            filename: 'love_contact.jpg',
                          );
                          photoCid = result.cid;
                          photoEncKeyHex = result.encKeyHex;
                        } catch (e) {
                          logger('[LoveContactsScreen] upload photo error: $e');
                        }
                      }
                      final LoveContact contact = LoveContact(
                        hexLove: hex,
                        nickname: nameCtrl.text.trim().isEmpty
                            ? hex.substring(0, 8)
                            : nameCtrl.text.trim(),
                        addedAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
                        photoCid: photoCid,
                        photoEncKeyHex: photoEncKeyHex,
                      );
                      if (ctx.mounted) {
                        Navigator.pop(ctx);
                      }
                      await _saveContacts(<LoveContact>[..._contacts, contact]);
                    },
              child: const Text('Ajouter', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _removeContact(LoveContact contact) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext ctx) => AlertDialog(
        title: Text('Retirer ${contact.nickname} ?'),
        actions: <Widget>[
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Annuler')),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red.shade400),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Retirer', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
    if (confirmed ?? false) {
      await _saveContacts(
          _contacts.where((LoveContact c) => c.hexLove != contact.hexLove).toList());
    }
  }

  Future<void> _openSendLoveSheet(LoveContact contact) async {
    if (_myLoveHexPriv == null) {
      return;
    }
    await showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext ctx) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Envoyer du love à ${contact.nickname}',
                style: const TextStyle(
                    fontWeight: FontWeight.w600, color: _loveRose)),
            const SizedBox(height: 16),
            Wrap(
              spacing: 10,
              children: <int>[1, 5, 10, 20].map((int amount) {
                return ActionChip(
                  avatar: const Icon(Icons.favorite, size: 16, color: _loveRose),
                  label: Text('$amount Ẑ'),
                  backgroundColor: _loveRoseLight,
                  onPressed: () async {
                    Navigator.pop(ctx);
                    await _sendLove(contact, amount);
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendLove(LoveContact contact, int amount) async {
    if (_myLoveHexPriv == null) {
      return;
    }
    final bool ok = await NostrRelayService().publishReaction(
      hexPrivateKey: _myLoveHexPriv!,
      reactedAuthorHexPubkey: contact.hexLove,
      content: '+$amount',
    );
    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(ok
            ? '♥ $amount Ẑ envoyé à ${contact.nickname}'
            : "Échec de l'envoi — réessaie"),
      ),
    );
  }

  Widget _buildContactTile(LoveContact contact) {
    return ListTile(
      leading: EncryptedAvatar(
        cid: contact.photoCid,
        encKeyHex: contact.photoEncKeyHex,
        radius: 22,
      ),
      title: Text(contact.nickname),
      subtitle: FutureBuilder<double?>(
        future: MultipassService.fetchG1n2Balance(contact.hexLove),
        builder: (BuildContext context, AsyncSnapshot<double?> snap) {
          if (!snap.hasData || snap.data == null) {
            return const Text('♥ …', style: TextStyle(fontSize: 12));
          }
          return Text('♥ ${snap.data!.toStringAsFixed(2)} Ẑ',
              style: const TextStyle(fontSize: 12, color: _loveRose));
        },
      ),
      onTap: () => _openSendLoveSheet(contact),
      trailing: IconButton(
        icon: const Icon(Icons.delete_outline, size: 20),
        onPressed: () => _removeContact(contact),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: _loveRose,
        title: const Text('Raccourcis love'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.qr_code),
            tooltip: 'Mon QR code',
            onPressed: _myLoveHexPub != null ? _showMyQr : null,
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: _loveRose))
          : _needsActivation
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Text(
                      "Active d'abord ATOM4LOVE depuis l'onglet LOVE pour créer ta clé dédiée.",
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : Column(
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: TextField(
                        controller: _searchCtrl,
                        decoration: InputDecoration(
                          hintText: 'Rechercher un raccourci…',
                          prefixIcon: const Icon(Icons.search),
                          filled: true,
                          fillColor: _loveRoseLight,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: _filtered.isEmpty
                          ? Center(
                              child: Text(
                                _contacts.isEmpty
                                    ? "Aucun raccourci — scanne le QR d'un ami pour commencer"
                                    : 'Aucun résultat',
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.black45),
                              ),
                            )
                          : ListView.builder(
                              itemCount: _filtered.length,
                              itemBuilder: (BuildContext context, int i) =>
                                  _buildContactTile(_filtered[i]),
                            ),
                    ),
                  ],
                ),
      floatingActionButton: (_needsActivation || _loading)
          ? null
          : FloatingActionButton(
              backgroundColor: _loveRose,
              onPressed: _scanAndAdd,
              child: const Icon(Icons.qr_code_scanner, color: Colors.white),
            ),
    );
  }
}
