import 'dart:async';
import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sn_progress_dialog/options/completed.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:text_scroll/text_scroll.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/models/app_cubit.dart';
import '../../data/models/contact.dart';
import '../../data/models/contact_cubit.dart';
import '../../data/models/contact_wot_info.dart';
import '../../data/models/identity_status.dart';
import '../../data/models/multi_wallet_transaction_cubit.dart';
import '../../data/models/stored_account.dart';
import '../../data/wot_info_fetcher.dart';
import '../../env.dart';
import '../../g1/nostr/nostr_keys.dart';
import '../../g1/nostr/nostr_profile.dart';
import '../../g1/nostr/nostr_relay_service.dart';
import '../../g1/sign_and_send.dart';
import '../../main.dart';
import '../../shared_prefs_helper.dart';
import '../../shared_prefs_helper_v2.dart';
import '../clipboard_helper.dart';
import '../dialogs/profile_editor_dialog.dart';
import '../in_dev_helper.dart';
import '../screens/chat_screen.dart';
import '../secure_unlock_widget.dart';
import '../ui_helpers.dart';
import 'balance_widget.dart';
import 'certifications_page.dart';
import 'contacts_actions.dart';
import 'default_progress_dialog.dart';
import 'fourth_screen/transactions_list/transactions_list_widget.dart';
import 'qr_list_tile.dart';
import 'wot_actions.dart';
import 'wot_menu_action.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key, required this.contact});

  final Contact contact;

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> with RouteAware {
  late MultiWalletTransactionCubit _txsCubit;
  bool isAvatarExpanded = false;
  late bool isV2;
  late Stream<ContactWotInfo> _wotInfoStream;
  String? _bannerUrl;
  NostrProfile? _nostrProfile;
  bool _isNostrFollowed = false;
  bool _isMuted = false;

  // Expert-mode secrets (own MULTIPASS only)
  String? _expertNsec;
  String? _expertSsss;  // ssss_player — used as QR for /scan terminal
  Map<String, dynamic>? _ocUrls; // OC urls depuis MULTIPASS si me=true
  String? _matchUrl; // Lien de résonance atomique (KIN Tzolkin)

  // KIN Dreamspell + phi2x (depuis Kind 30078 d=atom4love)
  int? _kinNum;
  String? _kinGlyph;
  String? _kinColor;
  String? _kinTone;
  String? _kinAction;
  double? _personalPhase; // φ (phi2x personal phase)
  double? _omegaBio;      // ω biologique (Hz)
  late ScrollController _scrollController;
  bool _isRefreshing = false;

  @override
  void initState() {
    _txsCubit = context.read<MultiWalletTransactionCubit>();
    final AppCubit appCubit = context.read<AppCubit>();
    isV2 = appCubit.isV2;
    _updateBalance();
    _wotInfoStream = _getWotInfo(appCubit);
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _fetchBanner();
    _loadOcUrls();
    super.initState();
  }

  /// Charge les URLs OC depuis le MULTIPASS stocké (pour afficher les liens de recharge)
  Future<void> _loadOcUrls() async {
    try {
      final Map<String, dynamic>? data =
          await SharedPreferencesHelperV2().getMultipassData(widget.contact.pubKey);
      if (data != null && mounted) {
        final dynamic raw = data['oc_urls'];
        if (raw is Map) {
          final String? matchUrl = data['match_url'] as String?;
          setState(() {
            _ocUrls = Map<String, dynamic>.from(raw);
            if (matchUrl != null && matchUrl.isNotEmpty) {
              _matchUrl = matchUrl;
            }
          });
        }
      }
    } catch (_) {}
  }

  /// Convertit la couleur KIN en emoji.
  String _kinColorEmoji(String? color) {
    switch (color?.toLowerCase()) {
      case 'rouge':
      case 'red':
        return '🔴';
      case 'blanc':
      case 'white':
        return '⚪';
      case 'bleu':
      case 'blue':
        return '🔵';
      case 'jaune':
      case 'yellow':
        return '🟡';
      default:
        return '🌀';
    }
  }

  /// Récupère les données KIN Dreamspell depuis Kind 30078 d=atom4love du contact.
  Future<void> _fetchKinData(NostrRelayService relay, String nostrHex) async {
    try {
      final List<Map<String, dynamic>> events = await relay.queryEvents(
        kinds: <int>[30078],
        authors: <String>[nostrHex],
        tags: <List<String>>[<String>['d', 'atom4love']],
        limit: 1,
      );
      if (events.isEmpty || !mounted) {
        return;
      }
      final Map<String, dynamic> event = events.first;
      final List<dynamic> tags = (event['tags'] as List<dynamic>?) ?? <dynamic>[];
      int? kin;
      String? glyph;
      String? color;
      String? tone;
      String? action;
      for (final dynamic t in tags) {
        if (t is! List || t.length < 2) {
          continue;
        }
        final String tagName = t[0] as String;
        final String tagVal = t[1] as String;
        switch (tagName) {
          case 'kin':
            kin = int.tryParse(tagVal);
          case 'glyph':
            glyph = tagVal;
          case 'color':
            color = tagVal;
          case 'tone':
            tone = tagVal;
          case 'action':
            action = tagVal;
        }
      }
      // Parse content JSON for phi2x fields
      double? personalPhase;
      double? omegaBio;
      try {
        final String? contentStr = event['content'] as String?;
        if (contentStr != null && contentStr.isNotEmpty) {
          final Map<String, dynamic> content =
              jsonDecode(contentStr) as Map<String, dynamic>;
          personalPhase = (content['personal_phase'] as num?)?.toDouble();
          omegaBio = (content['omega_bio'] as num?)?.toDouble();
        }
      } catch (_) {}

      if (kin != null && mounted) {
        setState(() {
          _kinNum = kin;
          _kinGlyph = glyph;
          _kinColor = color;
          _kinTone = tone;
          _kinAction = action;
          _personalPhase = personalPhase;
          _omegaBio = omegaBio;
        });
      }
    } catch (_) {}
  }

  /// Charge l'état muet depuis SharedPreferences.
  Future<void> _loadMuteState(String nostrHex) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final List<String> muted =
          prefs.getStringList('nostr_muted_list') ?? <String>[];
      if (mounted) {
        setState(() => _isMuted = muted.contains(nostrHex));
      }
    } catch (_) {}
  }

  /// Bascule l'état muet et le persiste localement.
  Future<void> _toggleMute(String nostrHex) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final List<String> muted =
          prefs.getStringList('nostr_muted_list') ?? <String>[];
      final bool nowMuted = !_isMuted;
      if (nowMuted) {
        if (!muted.contains(nostrHex)) {
          muted.add(nostrHex);
        }
      } else {
        muted.remove(nostrHex);
      }
      await prefs.setStringList('nostr_muted_list', muted);
      if (mounted) {
        setState(() => _isMuted = nowMuted);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(nowMuted
              ? 'Notifications désactivées pour ce contact'
              : 'Notifications réactivées'),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ));
      }
    } catch (_) {}
  }

  /// Exécute une action WoT avec dialogue de progression.
  Future<void> _handleWotAction(WotMenuAction action) async {
    final SignAndSendResult result = await action.action();
    if (!mounted || result.cancelled) {
      return;
    }
    final ProgressDialog pd = ProgressDialog(context: context);
    pd.show(
      progressType: defProgressType,
      msg: '',
      hideValue: defProgressHideValue,
      progressBgColor: defProgressBgColor,
      barrierDismissible: defProgressBarrierDismissible,
      msgMaxLines: defProgressMsgMaxLines,
      completed: Completed(),
    );
    result.progressStream.listen(
      (String progressMessage) {
        pd.update(msg: progressMessage);
      },
      onDone: () async {
        if (!mounted) {
          return;
        }
        await Future<dynamic>.delayed(const Duration(milliseconds: 1000));
        pd.close();
        if (!mounted) {
          return;
        }
        setState(() {});
        await _refresh();
      },
      onError: (dynamic error) {
        if (!mounted) {
          return;
        }
        pd.close();
        showAlertDialog(context, tr('error'), tr(error.toString()));
      },
    );
  }

  /// Ouvre une URL dans le navigateur externe
  Future<void> _openExternalUrl(String url) async {
    if (url.isEmpty) {
      return;
    }
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  /// Affiche un dialog QR avec le npub/hex NOSTR pour être suivi facilement
  void _showNpubQr(String npub) {
    showDialog<void>(
      context: context,
      builder: (BuildContext ctx) => AlertDialog(
        title: const Row(
          children: <Widget>[
            Icon(Icons.electric_bolt, color: Color(0xFFBF5AFF)),
            SizedBox(width: 8),
            Text('Clef NOSTR', style: TextStyle(fontSize: 16)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // SizedBox required: QrImageView uses LayoutBuilder internally which
            // crashes inside AlertDialog when Flutter tries to compute intrinsic
            // dimensions speculatively (Flutter bug / LayoutBuilder constraint).
            SizedBox(
              width: 200,
              height: 200,
              child: QrImageView(data: npub),
            ),
            const SizedBox(height: 8),
            SelectableText(
              npub,
              style: const TextStyle(fontSize: 9, fontFamily: 'monospace'),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: <Widget>[
          TextButton.icon(
            icon: const Icon(Icons.copy, size: 14),
            label: const Text('Copier'),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: npub));
              Navigator.of(ctx).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Clef NOSTR copiée'), duration: Duration(seconds: 2)),
              );
            },
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }

  /// Fetch NOSTR profile for this contact.
  /// Uses NIP-39 tag lookup (["i", "g1pub:PUBKEY"]) to find the correct
  /// NOSTR hex pubkey — different from the Duniter base58 pubkey.
  Future<void> _fetchBanner() async {
    final NostrRelayService relay = NostrRelayService();
    if (!relay.isConnected) {
      return;
    }
    try {
      // Step 1a: Si c'est notre propre compte, dériver nostrHex depuis nsec
      // (évite une requête réseau et fonctionne même si le relay n'a pas encore
      // reçu le kind 0 — le profil est fetché directement avec le hex dérivé)
      String? nostrHex;
      final String myPubKey =
          SharedPreferencesHelper().getCurrentAccount().pubKey;
      if (widget.contact.pubKey == myPubKey) {
        final String? nsec =
            await SharedPreferencesHelperV2().getNostrNsec();
        if (nsec != null && nsec.isNotEmpty) {
          nostrHex = NostrRelayService.derivePublicKey(
              NostrKeys.nsecToHex(nsec));
        }
      }

      // Step 1b: Use pre-computed nostrHex passed by the caller (e.g. NOSTR contacts list)
      nostrHex ??= widget.contact.nostrHex;
      // Step 1c: Lookup by G1 pubKey (V1)
      nostrHex ??= await relay.findNostrHexByG1Pub(widget.contact.pubKey);
      // Step 1d: Lookup by V2 address — for MULTIPASS contacts opened from NOSTR list
      if (nostrHex == null && widget.contact.address.isNotEmpty) {
        nostrHex = await relay.findNostrHexByG1Pub(widget.contact.address);
      }

      if (nostrHex == null || !mounted) {
        return;
      }

      // Step 2: Persist nostrHex in the Contact (in-memory, not serialized)
      if (widget.contact.nostrHex != nostrHex) {
        context
            .read<ContactsCubit>()
            .updateContact(widget.contact.copyWith(nostrHex: nostrHex));
        // Step 3: Register in our kind 3 follow list (async, fire & forget)
        unawaited(_publishContactToKind3(relay, nostrHex));
      }

      // Step 4: Fetch full profile + check follow status
      final NostrProfile? profile = await relay.fetchProfile(nostrHex);
      if (profile != null && mounted) {
        setState(() {
          _nostrProfile = profile;
          if (profile.banner?.isNotEmpty ?? false) {
            _bannerUrl = profile.banner;
          }
        });
      }

      // Step 4b: Fetch Kind 30078 d=atom4love for KIN Dreamspell data
      _fetchKinData(relay, nostrHex);

      // Step 4c: Load local mute state for this contact
      _loadMuteState(nostrHex);

      // Step 5: Check follow status (are we following this nostrHex?)
      try {
        final String? nsec = await SharedPreferencesHelperV2().getNostrNsec();
        if (nsec != null && nsec.isNotEmpty) {
          final String myHex =
              NostrRelayService.derivePublicKey(NostrKeys.nsecToHex(nsec));
          final List<String> follows = await relay.fetchContacts(myHex);
          if (mounted) {
            setState(() => _isNostrFollowed = follows.contains(nostrHex));
          }
        }
      } catch (_) {}

      // Step 6: Load expert secrets (own MULTIPASS, expert mode only)
      try {
        final String myPubKey =
            SharedPreferencesHelper().getCurrentAccount().pubKey;
        if (widget.contact.pubKey == myPubKey ||
            widget.contact.address == myPubKey) {
          final String? nsecRaw =
              await SharedPreferencesHelperV2().getNostrNsec();
          final Map<String, dynamic>? mpData =
              await SharedPreferencesHelperV2().getMultipassData();
          if (mounted) {
            setState(() {
              _expertNsec = nsecRaw;
              _expertSsss = mpData?['ssss_player'] as String?;
            });
          }
        }
      } catch (_) {}
    } catch (_) {}
  }

  /// Toggle follow/unfollow this contact on NOSTR kind 3.
  Future<void> _toggleNostrFollow(String contactNostrHex) async {
    try {
      final String? nsec = await SharedPreferencesHelperV2().getNostrNsec();
      if (nsec == null || nsec.isEmpty) {
        return;
      }
      final NostrRelayService relay = NostrRelayService();
      if (!relay.isConnected) {
        return;
      }
      final String hexPriv = NostrKeys.nsecToHex(nsec);
      final String myHex = NostrRelayService.derivePublicKey(hexPriv);
      final List<String> current = await relay.fetchContacts(myHex);

      List<String> updated;
      if (_isNostrFollowed) {
        updated = current.where((String h) => h != contactNostrHex).toList();
      } else {
        updated = <String>[...current, contactNostrHex];
      }
      await relay.publishContacts(
          hexPrivateKey: hexPriv, hexPubkeys: updated);
      if (mounted) {
        setState(() => _isNostrFollowed = !_isNostrFollowed);
      }
    } catch (_) {}
  }

  /// Send a ẐEN invitation via ALL available channels:
  ///
  ///   1. NOSTR kind-1 note (if the contact has a NOSTR hex pubkey on the relay)
  ///   2. Cesium+ Elastic Search message (if the sender has a MULTIPASS — i.e.
  ///      CesiumWallet salt/pepper — and the recipient has a G1 V1 pubkey)
  ///
  /// The invitation text contains:
  ///   • {UPASSPORT_URL}/ipns/coracle.copylaradio.com  ← ẐEN app (Coracle)
  ///   • {UPASSPORT_URL}/nostr                         ← demo / landing page
  ///
  /// References for Cesium+ message format:
  ///   jaklis/lib/cesium.py  — sendMsg()
  ///   jaklis/lib/cesiumCommon.py — signing helpers
  Future<void> _openChat(String peerHexPubkey) async {
    final String? nsec = await SharedPreferencesHelperV2().getNostrNsec();
    if (nsec == null || nsec.isEmpty) {
      return;
    }
    final String myPrivHex = NostrKeys.nsecToHex(nsec);
    final String myPubHex =
        NostrRelayService.derivePublicKey(myPrivHex);
    if (!mounted) {
      return;
    }
    unawaited(Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => ChatScreen(
          myHexPubkey: myPubHex,
          myHexPrivkey: myPrivHex,
          peerHexPubkey: peerHexPubkey,
          peerProfile: _nostrProfile,
        ),
      ),
    ));
  }

  Future<void> _sendZenInvitation([String? contactNostrHex]) async {
    // Build invitation text (shared by both channels)
    const String appUrl =
        '${Env.upassportUrl}/ipns/coracle.copylaradio.com';
    const String demoUrl = '${Env.upassportUrl}/nostr';
    final String content = tr('zen_invitation_message',
        namedArgs: <String, String>{
          'app_url': appUrl,
          'demo_url': demoUrl,
        });
    bool nostrNoteSent = false;
    bool nip44Sent = false;

    final String? nsec = await SharedPreferencesHelperV2().getNostrNsec();
    if (nsec != null && nsec.isNotEmpty) {
      final String myPrivHex = NostrKeys.nsecToHex(nsec);
      final NostrRelayService relay = NostrRelayService();

      if (relay.isConnected && contactNostrHex != null && contactNostrHex.isNotEmpty) {
        // ── Canal 1: note publique NOSTR kind-1 mentionnant le contact ───
        try {
          nostrNoteSent = await relay.publishNote(
            hexPrivateKey: myPrivHex,
            content: content,
            mentionHex: contactNostrHex,
          );
        } catch (_) {}

        // ── Canal 2: DM NIP-44 chiffré (remplace Cesium+ message) ───────
        try {
          nip44Sent = await relay.sendNip44Message(
            hexPrivateKey: myPrivHex,
            recipientHexPubkey: contactNostrHex,
            plaintext: content,
          );
        } catch (_) {}
      }
    }

    if (mounted) {
      final bool anySent = nostrNoteSent || nip44Sent;
      final String channels = <String>[
        if (nostrNoteSent) 'NOSTR',
        if (nip44Sent) 'NIP-44',
      ].join(' & ');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(anySent
            ? tr('zen_invitation_sent') +
                (channels.isNotEmpty ? ' ($channels)' : '')
            : tr('zen_invitation_failed')),
      ));
    }
  }

  /// Register this contact's NOSTR hex in our kind 3 follow list.
  /// This ensures the NIP-101 relay can route kind 7 payments to them.
  Future<void> _publishContactToKind3(
      NostrRelayService relay, String contactNostrHex) async {
    try {
      final String? nsec =
          await SharedPreferencesHelperV2().getNostrNsec();
      if (nsec == null || nsec.isEmpty) {
        return;
      }

      final String hexPrivateKey = NostrKeys.nsecToHex(nsec);
      final String myHexPubkey =
          NostrRelayService.derivePublicKey(hexPrivateKey);

      // Fetch current follow list and add the new contact if not present
      final List<String> currentContacts =
          await relay.fetchContacts(myHexPubkey);
      if (!currentContacts.contains(contactNostrHex)) {
        final List<String> updated = <String>[
          ...currentContacts,
          contactNostrHex
        ];
        await relay.publishContacts(
          hexPrivateKey: hexPrivateKey,
          hexPubkeys: updated,
        );
        debugPrint(
            '[ContactPage] Published kind 3 with ${updated.length} follows');
      }
    } catch (e) {
      debugPrint('[ContactPage] Failed to publish kind 3: $e');
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final ModalRoute<dynamic>? route = ModalRoute.of(context);
    if (route != null) {
      ZelkovaApp.routeObserver.subscribe(this, route);
    }
  }

  /// Called when a route above this one was popped and this route is now visible again.
  @override
  void didPopNext() {
    _refresh();
  }

  Future<void> _updateBalance() async {
    await _txsCubit.fetchTransactions(pubKey: widget.contact.pubKey);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    ZelkovaApp.routeObserver.unsubscribe(this);
    _scrollController.dispose();
    _txsCubit.removeStateForKey(widget.contact.pubKey);
    super.dispose();
  }

  void _onScroll() {
    if (!mounted) {
      return;
    }
    // Only refresh if we are at the top AND we are not already refreshing
    if (_scrollController.position.pixels <=
            _scrollController.position.minScrollExtent &&
        !_scrollController.position.outOfRange &&
        !_isRefreshing) {
      _refresh();
    }
  }

  Future<void> _refresh() async {
    if (_isRefreshing) {
      return;
    }
    setState(() {
      _isRefreshing = true;
      final AppCubit appCubit = context.read<AppCubit>();
      _wotInfoStream = _getWotInfo(appCubit, forceRefresh: true);
    });
    await _updateBalance();
    // Reset refreshing state after a delay to debounce
    Future<void>.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isRefreshing = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Contact me = Contact(pubKey: SharedPreferencesHelper().getPubKey());
    return StreamBuilder<ContactWotInfo>(
      stream: _wotInfoStream,
      initialData: ContactWotInfo(
        me: me,
        you: widget.contact,
      ),
      builder: (BuildContext context, AsyncSnapshot<ContactWotInfo> snapshot) {
        if (snapshot.hasData) {
          return _buildContactWidget(snapshot.requireData, context);
        }
        return _buildContactWidget(
            ContactWotInfo(me: me, you: widget.contact), context);
      },
    );
  }

  /// Construit un item de menu contextuel avec icône et libellé.
  Widget _menuItem(IconData icon, String label, {Color? color}) {
    return Row(
      children: <Widget>[
        Icon(icon, size: 20, color: color),
        const SizedBox(width: 12),
        Text(label),
      ],
    );
  }

  DefaultTabController _buildContactWidget(
      ContactWotInfo contactWotInfo, BuildContext context) {
    final Contact contact = contactWotInfo.you;
    final bool isContact =
        context.read<ContactsCubit>().isContact(contact.pubKey);
    final bool me = contactWotInfo.isme;
    final StoredAccount currentAccount =
        SharedPreferencesHelper().getCurrentAccount();
    final bool isPassProtected =
        currentAccount.type != AccountType.v1PasswordLess &&
            currentAccount.type != AccountType.v2PasswordLess;
    // ── Menu contextuel (overflow ···) — actions secondaires ──────────────
    final List<PopupMenuEntry<VoidCallback>> menuItems =
        <PopupMenuEntry<VoidCallback>>[
      if (me && isV2)
        PopupMenuItem<VoidCallback>(
          value: () => _openProfileEditor(contact),
          child: _menuItem(Icons.edit, tr('profile.edit_title')),
        ),
      if (isContact)
        PopupMenuItem<VoidCallback>(
          value: () => onEditContact(context, contact),
          child: _menuItem(Symbols.person_edit, tr('form_contact_title')),
        ),
      if (!me && widget.contact.pubKey.isNotEmpty)
        PopupMenuItem<VoidCallback>(
          value: () => _sendZenInvitation(widget.contact.nostrHex),
          child: _menuItem(Icons.mail_outline, tr('zen_invite')),
        ),
      if (!me)
        PopupMenuItem<VoidCallback>(
          value: () {
            if (contact.isMultipass) {
              Navigator.pop(context);
              onSentContact(context, contact);
            } else {
              _sendZenInvitation();
            }
          },
          child: _menuItem(
            contact.isMultipass ? Icons.send : Icons.mail_outline,
            contact.isMultipass ? tr('send_g1') : tr('send_g1_message_only'),
          ),
        ),
      if (isV2 && !isPassProtected && me)
        PopupMenuItem<VoidCallback>(
          value: () => _upgradeAccountToProtected(currentAccount),
          child: _menuItem(
              Icons.lock_outline, tr('account_upgrade_required_title'),
              color: Colors.orange),
        ),
      if (isV2 && isPassProtected)
        ...getWotMenuActions(context, me, contactWotInfo)
            .map((WotMenuAction action) => PopupMenuItem<VoidCallback>(
                  value: () => _handleWotAction(action),
                  child: _menuItem(action.icon, action.name, color: action.color),
                )),
    ];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(me ? tr('your_account_info') : tr('account_info')),
          actions: <Widget>[
            // ── Chat ─────────────────────────────────────────────────────
            if (!me && widget.contact.nostrHex != null)
              IconButton(
                icon: const Icon(Icons.chat_bubble_outline),
                tooltip: tr('send_message'),
                onPressed: () => _openChat(widget.contact.nostrHex!),
              ),
            // ── Follow / Unfollow ─────────────────────────────────────────
            if (!me && _nostrProfile != null && widget.contact.nostrHex != null)
              IconButton(
                icon: Icon(_isNostrFollowed
                    ? Icons.person_remove
                    : Icons.person_add_alt_1),
                tooltip: _isNostrFollowed
                    ? tr('nostr_unfollow')
                    : tr('nostr_follow'),
                onPressed: () => _toggleNostrFollow(widget.contact.nostrHex!),
              ),
            // ── Mute / Unmute ─────────────────────────────────────────────
            if (!me && widget.contact.nostrHex != null)
              IconButton(
                icon: Icon(_isMuted
                    ? Icons.notifications_off_outlined
                    : Icons.notifications_none),
                tooltip: _isMuted ? 'Réactiver les notifications' : 'Silencieux',
                onPressed: () => _toggleMute(widget.contact.nostrHex!),
              ),
            // ── Overflow ··· ──────────────────────────────────────────────
            if (menuItems.isNotEmpty)
              PopupMenuButton<VoidCallback>(
                onSelected: (VoidCallback fn) => fn(),
                itemBuilder: (BuildContext ctx) => menuItems,
              ),
          ],
        ),
        body: Column(
          children: <Widget>[
            _buildAvatarSection(contact, me: me),
            TabBar(
              tabs: <Widget>[
                Tab(text: tr('info')),
                Tab(text: tr('txMainKey_title')),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: <Widget>[
                  _buildInfoTab(contact, contactWotInfo),
                  _buildTransactionsTab(contact),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTab(Contact contact, ContactWotInfo wotInfo,
      [bool debug = false]) {
    final bool loaded = wotInfo.loaded;
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (contact.nick != null)
            GestureDetector(
                onTap: () {
                  copyToClipboard(
                    context: context,
                    text: contact.nick!,
                    feedbackText: 'nick_copied_to_clipboard',
                  );
                },
                child: ListTile(
                  leading: const Icon(Symbols.editor_choice),
                  title: Text('@${contact.nick}'),
                )),
          // Show internal name if it exists and differs from what is shown in the title
          // The title in the avatar section uses the logic: if name != nick, shows "name (nick)", otherwise only name or nick
          if (contact.name != null &&
              contact.name!.isNotEmpty &&
              contact.nick != null &&
              contact.nick!.isNotEmpty &&
              contact.name != contact.nick)
            GestureDetector(
              onTap: () {
                copyToClipboard(
                  context: context,
                  text: contact.name!,
                  feedbackText: 'internal_name_copied_to_clipboard',
                );
              },
              child: ListTile(
                leading: const Icon(Icons.bookmark_outline),
                title: Text(tr('internal_contact_name')),
                subtitle: Text(contact.name!),
              ),
            ),
          /* if (!contact.createdOnV2)  */
          _buildQrListTile(contact),

          _buildQrListTile(contact, isV2: true),

          // ── Section NOSTR — affiché pour tout contact avec profil kind 0 ──
          if (_nostrProfile != null) ...<Widget>[
            const Divider(),
            ListTile(
              leading: const Icon(Icons.electric_bolt,
                  color: Color(0xFFBF5AFF)),
              title: const Text('Clef NOSTR',
                  style: TextStyle(fontWeight: FontWeight.w700)),
              subtitle: Text(
                _nostrProfile!.npub.length > 16
                    ? '${_nostrProfile!.npub.substring(0, 8)}…${_nostrProfile!.npub.substring(_nostrProfile!.npub.length - 8)}'
                    : _nostrProfile!.npub,
                style: const TextStyle(
                    fontFamily: 'monospace', fontSize: 11),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.copy, size: 18),
                    tooltip: 'Copier npub',
                    onPressed: () {
                      Clipboard.setData(ClipboardData(
                          text: _nostrProfile!.npub));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Clef NOSTR copiée'),
                            duration: Duration(seconds: 2)),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.qr_code, size: 18),
                    tooltip: 'QR Code — partager / suivre',
                    onPressed: () => _showNpubQr(_nostrProfile!.npub),
                  ),
                ],
              ),
            ),
          ],

          // ── Section KIN Dreamspell + phi2x ─────────────────────────────────
          if (_kinNum != null) ...<Widget>[
            const Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
              child: Text(
                'KIN Dreamspell',
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 13),
              ),
            ),
            ListTile(
              leading: Text(
                _kinColorEmoji(_kinColor),
                style: const TextStyle(fontSize: 24),
              ),
              title: Text(
                'KIN $_kinNum${_kinGlyph != null ? ' — ${_kinGlyph!}' : ''}',
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              subtitle: Text(<String>[
                if (_kinColor != null) _kinColor!,
                if (_kinTone != null) 'Tone $_kinTone',
                if (_kinAction != null) _kinAction!,
              ].join(' · ')),
            ),
            if (_personalPhase != null || _omegaBio != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: Wrap(
                  spacing: 8,
                  children: <Widget>[
                    if (_personalPhase != null)
                      Tooltip(
                        message: 'Phase phi2x (cohérence biologique)',
                        child: Chip(
                          avatar: const Text('φ',
                              style: TextStyle(fontStyle: FontStyle.italic)),
                          label: Text(_personalPhase!.toStringAsFixed(4)),
                          visualDensity: VisualDensity.compact,
                        ),
                      ),
                    if (_omegaBio != null)
                      Tooltip(
                        message: 'Fréquence biologique omega',
                        child: Chip(
                          avatar: const Text('ω',
                              style: TextStyle(fontStyle: FontStyle.italic)),
                          label: Text('${_omegaBio!.toStringAsFixed(2)} Hz'),
                          visualDensity: VisualDensity.compact,
                        ),
                      ),
                  ],
                ),
              ),
          ],

          // ── Section Expert : nsec + QR SSSS (own account, expert mode only) ─
          if (wotInfo.isme &&
              context.read<AppCubit>().state.expertMode &&
              (_expertNsec != null || _expertSsss != null)) ...<Widget>[
            const Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
              child: Row(
                children: <Widget>[
                  const Icon(Icons.developer_mode,
                      size: 16, color: Colors.orange),
                  const SizedBox(width: 6),
                  Text(
                    tr('expert_secrets_title'),
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.orange[700],
                        fontSize: 12),
                  ),
                ],
              ),
            ),
            // nsec — private NOSTR key
            if (_expertNsec != null)
              ListTile(
                dense: true,
                leading: const Icon(Icons.vpn_key, color: Colors.orange),
                title: const Text(
                  'nsec (🔑 privée)',
                  style: TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 12),
                ),
                subtitle: SelectableText(
                  _expertNsec!,
                  style: const TextStyle(
                      fontFamily: 'monospace', fontSize: 10),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.copy, size: 18),
                  tooltip: tr('expert_copy_nsec'),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: _expertNsec!));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(tr('expert_nsec_copied')),
                          duration: const Duration(seconds: 2)),
                    );
                  },
                ),
              ),

            // SSSS QR — scan at Astroport /scan terminal
            if (_expertSsss != null && _expertSsss!.isNotEmpty) ...<Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 6, 16, 2),
                child: Text(
                  tr('expert_ssss_qr_title'),
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 12),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  child: SizedBox(
                    // Fixed size required: QrImageView uses LayoutBuilder
                    // which crashes inside AlertDialog without constraints.
                    width: 220,
                    height: 220,
                    child: QrImageView(
                      data: _expertSsss!,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: Text(
                  tr('expert_ssss_qr_hint'),
                  style: TextStyle(
                      color: Colors.grey[600], fontSize: 10),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ],

          // ── Lien de résonance atomique — affiché sur le propre profil ────
          if (wotInfo.isme && _matchUrl != null) ...<Widget>[
            const Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
              child: Text(
                'Mon lien de résonance',
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 13),
              ),
            ),
            ListTile(
              leading: const Text('🌀', style: TextStyle(fontSize: 22)),
              title: const Text('Résonance atomique KIN'),
              subtitle: Text(
                _matchUrl!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 11),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.copy, size: 18),
                    tooltip: 'Copier',
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: _matchUrl!));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Lien copié')),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.open_in_new, size: 18),
                    tooltip: 'Ouvrir',
                    onPressed: () => _openExternalUrl(_matchUrl!),
                  ),
                ],
              ),
            ),
          ],

          // ── Section recharge ẐEN — affiché sur le propre profil ──────────
          if (wotInfo.isme) ...<Widget>[
            const Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
              child: Text(
                'Recharger mon MULTIPASS',
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 13),
              ),
            ),
            if (_ocUrls?['cloud']?.toString().isNotEmpty ?? false)
              ListTile(
                leading: const Icon(Icons.cloud,
                    color: Color(0xFF00BB77)),
                title: Text(tr('subscription_recharge_title')),
                subtitle: const Text('Montant libre · 1 € = 1 Ẑ · crédité immédiatement'),
                trailing: const Icon(Icons.open_in_new, size: 16),
                onTap: () =>
                    _openExternalUrl(_ocUrls!['cloud']!.toString()),
              )
            else
              ListTile(
                leading: const Icon(Icons.cloud,
                    color: Color(0xFF00BB77)),
                title: Text(tr('subscription_recharge_title')),
                subtitle: const Text('Montant libre · 1 € = 1 Ẑ'),
                trailing: const Icon(Icons.open_in_new, size: 16),
                onTap: () => _openExternalUrl(
                    'https://opencollective.com/monnaie-libre/projects/coeurbox/contribute/cotisation-services-cloud-usage-98388'),
              ),
            if (_ocUrls?['membre']?.toString().isNotEmpty ?? false)
              ListTile(
                leading: const Icon(Icons.autorenew,
                    color: Color(0xFFDD6633)),
                title: Text(tr('subscription_monthly_title')),
                subtitle: const Text('5 Ẑ/semaine · Accès continu'),
                trailing: const Icon(Icons.open_in_new, size: 16),
                onTap: () =>
                    _openExternalUrl(_ocUrls!['membre']!.toString()),
              )
            else
              ListTile(
                leading: const Icon(Icons.autorenew,
                    color: Color(0xFFDD6633)),
                title: Text(tr('subscription_monthly_title')),
                subtitle: const Text('5 Ẑ/semaine · Accès continu'),
                trailing: const Icon(Icons.open_in_new, size: 16),
                onTap: () => _openExternalUrl(
                    'https://opencollective.com/monnaie-libre/projects/coeurbox/contribute/membre-resident-soutien-mensuel-98389'),
              ),
          ],
          // ──────────────────────────────────────────────────────────────────

          if (debug && inDevelopment)
            ListTile(title: Text('Status: ${contact.status}')),
          if (debug && inDevelopment)
            ListTile(
                title: Text(
                    'Me account type: ${SharedPreferencesHelper().getCurrentAccount().type}')),
          /* Right now, the are accounts with negative balance (maybe a bug) so, lets show this for now        if (context
                  .watch<MultiWalletTransactionCubit>()
                  .balance(contact.pubKey) >
              0) */
          _buildBalance(contact),
          // Separator
          if (loaded && contact.status != null) const Divider(),
          if (contact.status != null)
            ListTile(
                leading: const Icon(Icons.card_membership),
                title: Text(tr('idty_status_title')),
                subtitle: Text(
                    '${tr('idty_status_${contact.status!.name}')}${_getIdentityStatusDescription(contact.status!, wotInfo.waitingForCerts ?? false)}')),
          if (wotInfo.expireOn != null)
            ListTile(
                leading: const Icon(Icons.timer),
                title: Text(tr(wotInfo.expireOn!.isBefore(DateTime.now())
                    ? 'cert_expire_on_past'
                    : 'cert_expire_on')),
                subtitle: Text(
                  humanizeTimeFuture(
                        context.locale.languageCode,
                        (wotInfo.expireOn!.millisecondsSinceEpoch -
                                DateTime.now().millisecondsSinceEpoch) ~/
                            1000,
                      ) ??
                      '??',
                )),
          // Show if YOU can certify now
          if (wotInfo.youCanCertOn != null &&
              !wotInfo.youCanCertOn!.isAfter(DateTime.now()))
            ListTile(
              leading: const Icon(Icons.verified),
              title: Text(tr('can_cert')),
              subtitle: Text(tr('yes')),
            ),

          // Distance Rule - only show for non-members who need distance evaluation
          if (wotInfo.distRuleOk != null &&
              contact.status != null &&
              contact.status != IdentityStatus.MEMBER)
            ListTile(
              leading: const Icon(Icons.social_distance),
              title: Text(tr('distance_rule')),
              subtitle: Text(
                '${(wotInfo.distRuleRatio! * 100).toStringAsFixed(1)}% (${wotInfo.distRuleOk! ? 'OK' : 'KO'})',
                style: TextStyle(
                    color: wotInfo.distRuleOk! ? Colors.green : Colors.red),
              ),
            ),
          // Show when YOU will be able to certify
          if (wotInfo.youCanCertOn != null &&
              wotInfo.youCanCertOn!.isAfter(DateTime.now()))
            ListTile(
              leading: const Icon(Icons.timelapse),
              title: Text(tr('can_cert_on')),
              subtitle: Text(
                  humanizeTimeFuture(
                        context.locale.languageCode,
                        (wotInfo.youCanCertOn!.millisecondsSinceEpoch -
                                DateTime.now().millisecondsSinceEpoch) ~/
                            1000,
                      ) ??
                      '??',
                  // In red
                  style: const TextStyle(color: Colors.red)),
            ),
          if (inDevelopment && debug && contact.createdOn != null)
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: Text(tr('created_on')),
              subtitle: Text(contact.createdOn!.toString()),
            ),
          if (contact.certsReceived != null &&
              contact.certsReceived!.isNotEmpty &&
              wotInfo.currentBlockHeight != null)
            _buildReceivedCerts(context, contact, wotInfo.currentBlockHeight!),
          if (contact.certsIssued != null &&
              contact.certsIssued!.isNotEmpty &&
              wotInfo.currentBlockHeight != null)
            _buildIssuedCerts(context, contact, wotInfo.currentBlockHeight!),
          if (loaded &&
              (contact.socials != null ||
                  contact.city != null ||
                  contact.description != null))
            const Divider(),
          if (contact.description != null && contact.description!.isNotEmpty)
            _buildDescriptionTile(contact),
          if (contact.city != null && contact.city!.isNotEmpty)
            _buildAddressTile(contact),
          if (contact.socials != null && contact.socials!.isNotEmpty)
            _buildSocialsTile(contact),
          // if not loaded add spinner
          if (!loaded) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }

  ListTile _buildBalance(Contact contact) {
    return ListTile(
      leading: const Icon(Icons.savings),
      title: Row(
        children: <Widget>[
          Text(tr('balance')),
          const Spacer(),
          BalanceWidget(pubKey: contact.pubKey, small: true),
        ],
      ),
    );
  }

  ListTile _buildIssuedCerts(
      BuildContext context, Contact contact, int currentBlockHeight) {
    final String title = tr('certs_issued');
    return ListTile(
      leading: const Icon(Icons.verified_rounded),
      title: Text(title),
      trailing: _buildBadge(context, contact.certsIssued!.length),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute<void>(
          builder: (BuildContext context) => CertificationsPage(
            issued: true,
            title: contact.title,
            subtitle: title,
            certifications: contact.certsIssued!,
            currentBlockHeight: currentBlockHeight,
          ),
        ));
      },
    );
  }

  ListTile _buildReceivedCerts(
      BuildContext context, Contact contact, int currentBlockHeight) {
    final String title = tr('certs_received');
    return ListTile(
      leading: const Icon(Icons.verified_user),
      title: Text(title),
      trailing: _buildBadge(context, contact.certsReceived!.length),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute<void>(
          builder: (BuildContext context) => CertificationsPage(
              issued: false,
              title: contact.title,
              subtitle: title,
              certifications: contact.certsReceived!,
              currentBlockHeight: currentBlockHeight),
        ));
      },
    );
  }

  Widget _buildTransactionsTab(Contact contact) {
    return TransactionsListWidget(
      pubKey: contact.pubKey,
      key: ValueKey<String>('tx-list-${contact.pubKey}'),
    );
  }

  Widget _buildQrListTile(Contact contact, {bool isV2 = false}) {
    return QrListTile(
      pubKeyOrAddress: isV2 ? contact.address : contact.pubKey,
      isV2: isV2,
    );
  }

  Widget _buildAvatarSection(Contact contact, {bool me = false}) {
    final String title = contact.title;
    // contact.nick ?? contact.name ?? humanizePubKey(contact.pubKey);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        image: _bannerUrl != null
            ? DecorationImage(
                image: NetworkImage(_bannerUrl!),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withAlpha(80),
                  BlendMode.darken,
                ),
              )
            : null,
      ),
      clipBehavior: Clip.hardEdge,
      width: double.infinity,
      height: isAvatarExpanded ? MediaQuery.of(context).size.height / 2 : 132,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Center(
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                setState(() {
                  isAvatarExpanded = !isAvatarExpanded;
                });
              },
              child: AnimatedContainer(
                width:
                    isAvatarExpanded ? MediaQuery.of(context).size.width : 64,
                height: isAvatarExpanded
                    ? MediaQuery.of(context).size.height / 2 - 60
                    : 64,
                duration: const Duration(milliseconds: 300),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    AnimatedOpacity(
                      opacity: isAvatarExpanded ? 0.0 : 1.0,
                      duration: const Duration(milliseconds: 300),
                      // Picture NOSTR en avatar compact si disponible
                      child: _nostrProfile?.picture?.isNotEmpty ?? false
                          ? CircleAvatar(
                              radius: 44,
                              backgroundImage:
                                  NetworkImage(_nostrProfile!.picture!),
                              onBackgroundImageError: (_, __) {},
                            )
                          : avatar(contact, avatarSize: 44),
                    ),
                    AnimatedOpacity(
                      opacity: isAvatarExpanded ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 300),
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: <Widget>[
                          // Priority: NOSTR picture URL → Cesium+ binary
                          if (_nostrProfile?.picture?.isNotEmpty ?? false) Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(_nostrProfile!.picture!),
                                      fit: BoxFit.cover,
                                      onError: (_, __) {},
                                    ),
                                  ),
                                ) else contact.avatar != null
                                  ? Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: MemoryImage(contact.avatar!),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                                  : avatar(contact, avatarSize: 44),
                          // Edit button: only for own MULTIPASS
                          if (me && isAvatarExpanded)
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: FloatingActionButton.small(
                                heroTag: 'edit_profile_pic',
                                onPressed: () => _openProfileEditor(contact),
                                tooltip: tr('profile.edit_title'),
                                child: const Icon(Icons.edit, size: 18),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: title.length > 10
                  ? TextScroll(
                      textAlign: TextAlign.center,
                      title,
                      numberOfReps: 2,
                      selectable: true,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: _bannerUrl != null ? Colors.white : null,
                            shadows: _bannerUrl != null
                                ? <Shadow>[
                                    const Shadow(
                                        blurRadius: 4, color: Colors.black54)
                                  ]
                                : null,
                          ),
                    )
                  : Text(
                      title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: _bannerUrl != null ? Colors.white : null,
                            shadows: _bannerUrl != null
                                ? <Shadow>[
                                    const Shadow(
                                        blurRadius: 4, color: Colors.black54)
                                  ]
                                : null,
                          ),
                    ),
            ),
            // NOSTR bio/about — shown when avatar is expanded
            if (isAvatarExpanded && _nostrProfile != null) ...<Widget>[
              if (_nostrProfile!.city?.isNotEmpty ?? false)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Icon(Icons.location_on, size: 14, color: Colors.white70),
                      const SizedBox(width: 4),
                      Text(
                        _nostrProfile!.city!,
                        style: const TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              if (_nostrProfile!.about?.isNotEmpty ?? false)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                  child: Text(
                    _nostrProfile!.about!.length > 120
                        ? '${_nostrProfile!.about!.substring(0, 120)}…'
                        : _nostrProfile!.about!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      shadows: <Shadow>[Shadow(blurRadius: 3, color: Colors.black87)],
                    ),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDescriptionTile(Contact contact) {
    return ListTile(
      leading: const Icon(Icons.info),
      title: Text(tr('contact_about_me')),
      subtitle: Text(contact.description!),
    );
  }

  Widget _buildAddressTile(Contact contact) {
    return ListTile(
      leading: const Icon(Icons.location_on),
      title: Text(tr('contact_address')),
      subtitle: Text(contact.city!),
    );
  }

  Widget _buildSocialsTile(Contact contact) {
    return ListTile(
      leading: const Icon(Icons.web),
      title: Text(tr('contact_socials')),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: contact.socials!.map((Map<String, String> social) {
          return GestureDetector(
            onTap: () {
              if (social['url'] != null) {
                openUrl(social['url']!);
              }
            },
            child: Text(
              social['url'] ?? '',
              style: const TextStyle(
                color: Colors.blue,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Stream<ContactWotInfo> _getWotInfo(AppCubit appCubit,
      {bool forceRefresh = false}) async* {
    // 0. Try to get cached data from AppCubit first (pre-fetched)
    if (!forceRefresh &&
        appCubit.state.wotInfo != null &&
        appCubit.state.wotInfo!.you.pubKey == widget.contact.pubKey) {
      yield appCubit.state.wotInfo!;
      if (appCubit.state.wotInfo!.loaded) {
        return;
      }
    }

    yield* WotInfoFetcher.fetch(widget.contact, appCubit);
  }

  void _openProfileEditor(Contact contact) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ProfileEditorDialog(
          currentContact: contact,
          // Pass the fetched kind-0 profile so the dialog pre-fills name,
          // about, city and picture URL with current NOSTR values.
          nostrProfile: _nostrProfile,
          onSaved: _refreshAfterProfileEdit,
        );
      },
    );
  }

  void _refreshAfterProfileEdit() {
    if (mounted) {
      _refresh();
    }
  }

  Future<void> _upgradeAccountToProtected(StoredAccount account) async {
    // Show informative dialog first
    final bool? proceed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text(tr('account_upgrade_required_title')),
          content: Text(tr('account_upgrade_required_desc')),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: Text(tr('ok')),
            ),
          ],
        );
      },
    );
    if (proceed != true || !mounted) {
      return;
    }
    // Request pattern/password setup
    final Uint8List? key = await requestSecureUnlock(isSetup: true);
    if (key == null || key.isEmpty || !mounted) {
      return;
    }
    // Upgrade the account
    final bool success = await SharedPreferencesHelper()
        .upgradeToPasswordProtected(account, key);
    if (!mounted) {
      return;
    }
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tr('account_upgrade_success'))),
      );
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tr('account_upgrade_failed'))),
      );
    }
  }
}

Widget _buildBadge(BuildContext context, int count) {
  return Container(
    width: 30,
    height: 30,
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.primary,
      borderRadius: BorderRadius.circular(30),
    ),
    child: Center(
        child: Text(
      '$count',
      style: const TextStyle(color: Colors.white),
    )),
  );
}

String _getIdentityStatusDescription(IdentityStatus status, bool waitingCerts) {
  switch (status) {
    case IdentityStatus.UNCONFIRMED:
      return " (${tr('idty_waiting_confirmation')})";
    case IdentityStatus.UNVALIDATED:
      return waitingCerts
          ? " (${tr('idty_waiting_certifications')})"
          : " (${tr('idty_waiting_distance_evaluation')})";
    case IdentityStatus.MEMBER:
    case IdentityStatus.NOTMEMBER:
    case IdentityStatus.REMOVED:
    case IdentityStatus.REVOKED:
      return '';
  }
}
