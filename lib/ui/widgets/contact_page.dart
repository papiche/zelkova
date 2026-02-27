import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:sn_progress_dialog/options/completed.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../data/models/app_cubit.dart';
import '../../data/models/contact.dart';
import '../../data/models/contact_cubit.dart';
import '../../data/models/contact_wot_info.dart';
import '../../data/models/identity_status.dart';
import '../../data/models/multi_wallet_transaction_cubit.dart';
import '../../data/models/stored_account.dart';
import '../../data/wot_info_fetcher.dart';
import '../../g1/sign_and_send.dart';
import '../../main.dart';
import '../../shared_prefs_helper.dart';
import '../clipboard_helper.dart';
import '../dialogs/profile_editor_dialog.dart';
import '../in_dev_helper.dart';
import '../ui_helpers.dart';
import '../secure_unlock_widget.dart';
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
    super.initState();
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
            _buildAvatarSection(contact),
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
          // Mostrar nombre interno si existe y difiere de lo que se muestra en el título
          // El título en la sección del avatar usa la lógica: si name != nick, muestra "name (nick)", sino solo name o nick
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

  Widget _buildAvatarSection(Contact contact) {
    final String title = contact.title;
    // contact.nick ?? contact.name ?? humanizePubKey(contact.pubKey);
    return Container(
      color: Theme.of(context).colorScheme.secondaryContainer,
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
                      child: avatar(contact, avatarSize: 44),
                    ),
                    AnimatedOpacity(
                      opacity: isAvatarExpanded ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 300),
                      child: contact.avatar ==
                              null /*  && contact.avatarCid == null */
                          ? avatar(contact, avatarSize: 44)
                          : Container(
                              width: double.infinity,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: /* contact.avatarCid != null
                                      ? NetworkImage(NodeManager()
                                          .ipfsUrl(contact.avatarCid!))
                                      : */
                                      MemoryImage(contact.avatar!),
                                  fit: BoxFit.cover,
                                ),
                              ),
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
                      style: Theme.of(context).textTheme.titleLarge,
                    )
                  : Text(
                      title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
            ),
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
