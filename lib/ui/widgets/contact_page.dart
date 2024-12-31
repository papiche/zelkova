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
import '../../data/models/multi_wallet_transaction_cubit.dart';
import '../../data/models/node_manager.dart';
import '../../data/models/wot_menu_action.dart';
import '../../g1/api.dart';
import '../../g1/duniter_indexer_helper.dart';
import '../../g1/g1_v2_helper_others.dart';
import '../../g1/sing_and_send.dart';
import '../../g1/wot_actions.dart';
import '../../generated/gdev/pallets/certification.dart';
import '../../generated/gdev/types/pallet_certification/types/idty_cert_meta.dart';
import '../../generated/gdev/types/pallet_identity/types/idty_value.dart';
import '../../shared_prefs_helper.dart';
import '../ui_helpers.dart';
import 'certifications_page.dart';
import 'contacts_actions.dart';
import 'default_progress_dialog.dart';
import 'fourth_screen/transactions_and_balance_widget.dart';
import 'qr_list_tile.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key, required this.contact});

  final Contact contact;

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  late MultiWalletTransactionCubit _txsCubit;
  bool isAvatarExpanded = false;
  late bool isV2;

  @override
  void initState() {
    super.initState();
    _txsCubit = context.read<MultiWalletTransactionCubit>();
    isV2 = context.read<AppCubit>().isV2();
    _updateBalance();
  }

  Future<void> _updateBalance() async {
    _txsCubit.fetchTransactions(pubKey: widget.contact.pubKey);
    setState(() {});
  }

  @override
  void dispose() {
    _txsCubit.removeStateForKey(widget.contact.pubKey);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Contact contact = widget.contact;

    return FutureBuilder<ContactWotInfo>(
      future: _getWotInfo(widget.contact),
      builder: (BuildContext context, AsyncSnapshot<ContactWotInfo> snapshot) {
        if (snapshot.hasData) {
          return _buildContactWidget(snapshot.data!, context);
        }
        return _buildContactWidget(
            ContactWotInfo(
                me: Contact(pubKey: SharedPreferencesHelper().getPubKey()),
                you: contact),
            context);
      },
    );
  }

  DefaultTabController _buildContactWidget(
      ContactWotInfo contactWotInfo, BuildContext context) {
    final Contact contact = contactWotInfo.you;
    // FIXME, duplicated code in contact_menu
    final bool isContact =
        context.read<ContactsCubit>().isContact(contact.pubKey);
    final String myPubKey = SharedPreferencesHelper().getPubKey();
    final bool me = isMe(contact, myPubKey);
    final List<SpeedDialChild> actions = <SpeedDialChild>[
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
    if (isV2) {
      getWotMenuActions(context, me, contactWotInfo)
          .forEach((WotMenuAction action) {
        actions.add(
          SpeedDialChild(
            child: Icon(action.icon),
            label: action.name,
            onTap: () async {
              final SignAndSendResult result = await action.action();
              if (!context.mounted) {
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
                  setState(() {});
                  pd.close();
                },
                onError: (dynamic error) {
                  if (!context.mounted) {
                    return;
                  }
                  pd.close();
                  showAlertDialog(
                    context,
                    tr('result'),
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
          title: Text(tr('account_info')),
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
                  _buildInfoTab(contact, contactWotInfo.canCertOn),
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

  Widget _buildInfoTab(Contact contact, DateTime? canCertOn) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (contact.nick != null)
            ListTile(
              leading: const Icon(Symbols.editor_choice),
              title: Text('@${contact.nick}'),
            ),
          if (!contact.createdOnV2) _buildQrListTile(contact),
          if (context.watch<AppCubit>().isExpertMode)
            _buildQrListTile(contact, isV2: true),
          if (contact.status != null)
            ListTile(
              leading: const Icon(Icons.card_membership_outlined),
              title: Text(tr('idty_status_title')),
              subtitle: Text(tr('idty_status_${contact.status!.name}')),
            ),
          if (canCertOn != null && !canCertOn.isAfter(DateTime.now()))
            ListTile(
              leading: const Icon(Icons.verified_outlined),
              title: Text(tr('can_cert')),
              subtitle: Text(tr('yes')),
            ),
          if (canCertOn != null && canCertOn.isAfter(DateTime.now()))
            ListTile(
              leading: const Icon(Icons.timelapse),
              title: Text(tr('can_cert_on')),
              subtitle: Text(
                  humanizeTimeFuture(
                        context.locale.languageCode,
                        (canCertOn.millisecondsSinceEpoch -
                                DateTime.now().millisecondsSinceEpoch) ~/
                            1000,
                      ) ??
                      '??',
                  // In red
                  style: const TextStyle(color: Colors.red)),
            ),
          // FIXME: Add: Available for Cert yer or no??
          if (inDevelopment && contact.createdOn != null)
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: Text(tr('created_on')),
              subtitle: Text(contact.createdOn!.toString()),
            ),
          if (contact.certsReceived != null &&
              contact.certsReceived!.isNotEmpty)
            _buildReceivedCerts(context, contact),
          if (contact.certsIssued != null && contact.certsIssued!.isNotEmpty)
            _buildIssuedCerts(context, contact),
          if (context
                  .watch<MultiWalletTransactionCubit>()
                  .balance(contact.pubKey) >
              0)
            _buildBalance(contact),
          if (contact.description != null && contact.description!.isNotEmpty)
            _buildDescriptionTile(contact),
          if (contact.city != null && contact.city!.isNotEmpty)
            _buildAddressTile(contact),
          if (contact.socials != null && contact.socials!.isNotEmpty)
            _buildSocialsTile(contact),
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

  ListTile _buildIssuedCerts(BuildContext context, Contact contact) {
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
          ),
        ));
      },
    );
  }

  ListTile _buildReceivedCerts(BuildContext context, Contact contact) {
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
          ),
        ));
      },
    );
  }

  Widget _buildTransactionsTab(Contact contact) {
    return TransactionsAndBalanceWidget(
      isExternalAccount: true,
      pubKey: contact.pubKey,
    );
  }

  Widget _buildQrListTile(Contact contact, {bool isV2 = false}) {
    return QrListTile(
      pubKeyOrAddress: isV2 ? contact.address : contact.pubKey,
      isV2: isV2,
    );
  }

  Widget _buildAvatarSection(Contact contact) {
    final String title =
        contact.nick ?? contact.name ?? humanizePubKey(contact.pubKey);
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
                      child: contact.avatar == null && contact.avatarCid == null
                          ? avatar(contact, avatarSize: 44)
                          : Container(
                              width: double.infinity,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: contact.avatarCid != null
                                      ? NetworkImage(NodeManager()
                                          .ipfsUrl(contact.avatarCid!))
                                      : MemoryImage(contact.avatar!),
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

  Future<ContactWotInfo> _getWotInfo(Contact contact) async {
    final Contact you =
        await getProfile(widget.contact.pubKey, resize: false, complete: true);
    final Contact me = await getProfile(SharedPreferencesHelper().getPubKey(),
        resize: false, complete: true);
    final ContactWotInfo wotInfo = ContactWotInfo(me: me, you: you);
    if (isV2) {
      if (you.status == null) {
        // Can create Identity from:
        // https://duniter.org/wiki/duniter-v2/doc/wot/

        // storage.identity.identities(AliceIndex).status is Member
        final bool iAmMember = me.isMember ?? false;

        // EveAccount exists with minimum amount of 2 ĞD (existential deposit plus fee buffer)
        // storage.system.account(EveAccount).data.free is higher than 200
        final BigInt? youBalance =
            await getBalanceV2(address: widget.contact.address);
        final bool enoughBalance =
            youBalance != null && youBalance > BigInt.from(200);
        // EveAccount is not already used by an identity
        // storage.identity.identities(EveAccount) is None
        final bool identityUsed =
            (await getIdentity(address: you.address)) != null;
        wotInfo.canCreateIdty = iAmMember && enoughBalance && !identityUsed;
      }
      final int currentBlock = await polkadotCurrentBlock();

      final bool youAMember = you.isMember ?? false;
      if (youAMember) {
        final IdtyValue? youIdty = await polkadotIdentity(you);
        final IdtyCertMeta? youCertMeta = await polkadotIdtyCertMeta(you);
        if (youIdty != null && youCertMeta != null) {
          wotInfo.canCertOn = estimateDate(
              futureBlock: youCertMeta.nextIssuableOn,
              currentBlockHeight: currentBlock);
        }
      }
      // Can Certificate
      final IdtyValue? myIdty = await polkadotIdentity(me);
      final IdtyCertMeta? idtyCertMeta = await polkadotIdtyCertMeta(me);
      if (myIdty != null && idtyCertMeta != null) {
        // From: https://duniter.org/wiki/duniter-v2/doc/wot/
        // storage.identity.identities(AliceIndex).nextCreatableIdentityOn is lower than current block
        // storage.certification.storageIdtyCertMeta(AliceIndex).nextIssuableOn is lower than current block
        // storage.certification.storageIdtyCertMeta(AliceIndex).issuedCount is lower than constants.certification.maxByIssuer()
        final bool canCert = myIdty.nextCreatableIdentityOn < currentBlock &&
            idtyCertMeta.nextIssuableOn < currentBlock &&
            idtyCertMeta.issuedCount < Constants().maxByIssuer;
        wotInfo.canCert = canCert;
      }

      // Waiting for Certifications
      if (you.certsReceived != null &&
          you.certsReceived!.isNotEmpty &&
          you.certsReceived!.length <
              gdevConstants().wot.minCertForMembership) {
        wotInfo.waitingForCerts = true;
      }
    }
    return wotInfo;
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

// Based on duniter-vue
DateTime estimateDate(
    {required int futureBlock, required int currentBlockHeight}) {
  const int millisPerBlock = 6000;
  final int diff = futureBlock - currentBlockHeight;
  return DateTime.now().add(Duration(milliseconds: diff * millisPerBlock));
}
