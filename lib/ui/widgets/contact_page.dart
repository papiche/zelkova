import 'dart:async';
import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
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
import '../../g1/g1_v2_helper.dart';
import '../../g1/nostr/nostr_keys.dart';
import '../../g1/nostr/nostr_profile.dart';
import '../../g1/nostr/nostr_relay_service.dart';
import '../../shared_prefs_helper_v2.dart';
import '../../g1/sign_and_send.dart';
import '../../main.dart';
import '../../shared_prefs_helper.dart';
import '../clipboard_helper.dart';
import '../dialogs/profile_editor_dialog.dart';
import '../in_dev_helper.dart';
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
  Map<String, dynamic>? _ocUrls; // OC urls depuis MULTIPASS si me=true
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
          setState(() {
            _ocUrls = Map<String, dynamic>.from(raw);
          });
        }
      }
    } catch (_) {}
  }

  /// Ouvre une URL dans le navigateur externe
  Future<void> _openExternalUrl(String url) async {
    if (url.isEmpty) return;
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
        title: Row(
          children: <Widget>[
            const Icon(Icons.electric_bolt, color: Color(0xFFBF5AFF)),
            const SizedBox(width: 8),
            const Text('Clef NOSTR', style: TextStyle(fontSize: 16)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            QrImageView(data: npub, size: 200, version: QrVersions.auto),
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
    if (!relay.isConnected) return;
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

      // Step 1b: Fallback — chercher via tag NIP-39 g1pub sur le relay
      nostrHex ??= await relay.findNostrHexByG1Pub(widget.contact.pubKey);

      if (nostrHex == null || !mounted) return;

      // Step 2: Persist nostrHex in the Contact (in-memory, not serialized)
      if (widget.contact.nostrHex != nostrHex) {
        context
            .read<ContactsCubit>()
            .updateContact(widget.contact.copyWith(nostrHex: nostrHex));
        // Step 3: Register in our kind 3 follow list (async, fire & forget)
        unawaited(_publishContactToKind3(relay, nostrHex));
      }

      // Step 4: Fetch full profile for UI display
      final NostrProfile? profile = await relay.fetchProfile(nostrHex);
      if (profile != null && mounted) {
        setState(() {
          _nostrProfile = profile;
          if (profile.banner?.isNotEmpty == true) {
            _bannerUrl = profile.banner;
          }
        });
      }
    } catch (_) {}
  }

  /// Register this contact's NOSTR hex in our kind 3 follow list.
  /// This ensures the NIP-101 relay can route kind 7 payments to them.
  Future<void> _publishContactToKind3(
      NostrRelayService relay, String contactNostrHex) async {
    try {
      final String? nsec =
          await SharedPreferencesHelperV2().getNostrNsec();
      if (nsec == null || nsec.isEmpty) return;

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
      GinkgoApp.routeObserver.subscribe(this, route);
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
    GinkgoApp.routeObserver.unsubscribe(this);
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
    final List<SpeedDialChild> actions = <SpeedDialChild>[
      // Edit profile action for own account
      if (me && isV2)
        SpeedDialChild(
          child: const Icon(Icons.edit),
          label: tr('profile.edit_title'),
          onTap: () {
            _openProfileEditor(contact);
          },
        ),
      if (isContact)
        SpeedDialChild(
          child: const Icon(Symbols.person_edit),
          label: tr('form_contact_title'),
          onTap: () {
            onEditContact(context, contact);
          },
        ),
      if (!isContact && !me)
        SpeedDialChild(
          child: const Icon(Icons.person_add),
          label: tr('add_contact'),
          onTap: () {
            addContact(context, contact);
          },
        ),
      if (!me)
        SpeedDialChild(
          child: const Icon(Icons.send),
          label: tr('send_g1'),
          onTap: () {
            Navigator.pop(context);
            onSentContact(context, contact);
          },
        ),
    ];
    if (isV2 && !isPassProtected && me) {
      // v2PasswordLess: must upgrade before using identity features
      actions.add(
        SpeedDialChild(
          child: const Icon(Icons.lock_outline),
          label: tr('account_upgrade_required_title'),
          onTap: () => _upgradeAccountToProtected(currentAccount),
        ),
      );
    } else if (isV2 && isPassProtected) {
      getWotMenuActions(context, me, contactWotInfo)
          .forEach((WotMenuAction action) {
        actions.add(
          SpeedDialChild(
            child: Icon(action.icon, color: action.color),
            label: action.name,
            onTap: () async {
              final SignAndSendResult result = await action.action();
              if (!context.mounted) {
                return;
              }
              if (result.cancelled) {
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
                  if (!context.mounted) {
                    return;
                  }
                  await Future<dynamic>.delayed(
                      const Duration(milliseconds: 1000));
                  pd.close();
                  if (!context.mounted) {
                    return;
                  }
                  setState(() {});
                  await _refresh();
                },
                onError: (dynamic error) {
                  if (!context.mounted) {
                    return;
                  }
                  pd.close();
                  showAlertDialog(
                    context,
                    tr('error'),
                    tr(error.toString()),
                  );
                },
              );
            },
          ),
        );
      });
    }
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(me ? tr('your_account_info') : tr('account_info')),
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
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: actions.isEmpty
            ? null
            : SpeedDial(
                icon: Icons.add,
                activeIcon: Icons.close,
                direction: SpeedDialDirection.down,
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
                renderOverlay: false,
                children: actions,
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
            if (_ocUrls?['cloud']?.toString().isNotEmpty == true)
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
            if (_ocUrls?['membre']?.toString().isNotEmpty == true)
              ListTile(
                leading: const Icon(Icons.autorenew,
                    color: Color(0xFFDD6633)),
                title: Text(tr('subscription_monthly_title')),
                subtitle: const Text('~4 Ẑ/mois · Accès continu'),
                trailing: const Icon(Icons.open_in_new, size: 16),
                onTap: () =>
                    _openExternalUrl(_ocUrls!['membre']!.toString()),
              )
            else
              ListTile(
                leading: const Icon(Icons.autorenew,
                    color: Color(0xFFDD6633)),
                title: Text(tr('subscription_monthly_title')),
                subtitle: const Text('~4 Ẑ/mois · Accès continu'),
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
                      child: _nostrProfile?.picture?.isNotEmpty == true
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
                          _nostrProfile?.picture?.isNotEmpty == true
                              ? Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(_nostrProfile!.picture!),
                                      fit: BoxFit.cover,
                                      onError: (_, __) {},
                                    ),
                                  ),
                                )
                              : contact.avatar != null
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
              if (_nostrProfile!.city?.isNotEmpty == true)
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
              if (_nostrProfile!.about?.isNotEmpty == true)
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
