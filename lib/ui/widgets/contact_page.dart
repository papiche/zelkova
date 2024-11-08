import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../data/models/app_cubit.dart';
import '../../data/models/contact.dart';
import '../../data/models/contact_cubit.dart';
import '../../data/models/multi_wallet_transaction_cubit.dart';
import '../../data/models/node_manager.dart';
import '../../g1/api.dart';
import '../../shared_prefs_helper.dart';
import '../ui_helpers.dart';
import 'contacts_actions.dart';
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

  @override
  void initState() {
    super.initState();
    _txsCubit = context.read<MultiWalletTransactionCubit>();
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
    return FutureBuilder<Contact>(
      future: getProfile(widget.contact.pubKey, resize: false),
      builder: (BuildContext context, AsyncSnapshot<Contact> snapshot) {
        if (snapshot.hasData) {
          return _buildContactWidget(snapshot.data!, context);
        }
        return _buildContactWidget(contact, context);
      },
    );
  }

  DefaultTabController _buildContactWidget(
      Contact contact, BuildContext context) {
    // FIXME, duplicated code in contact_menu
    final bool isContact =
        context.read<ContactsCubit>().isContact(contact.pubKey);
    final String myPubKey = SharedPreferencesHelper().getPubKey();
    final bool me = isMe(contact, myPubKey);
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
                  _buildInfoTab(contact),
                  _buildTransactionsTab(contact),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: SpeedDial(
          icon: Icons.add,
          activeIcon: Icons.close,
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          renderOverlay: false,
          children: <SpeedDialChild>[
            if (!me && inDevelopment)
              SpeedDialChild(
                child: const Icon(Icons.verified),
                label: tr('certify'),
                onTap: () {},
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
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTab(Contact contact) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (contact.nick != null)
            ListTile(
              leading: const Icon(Symbols.editor_choice),
              title: Text('@${contact.nick}'),
            ),
          _buildQrListTile(contact),
          if (context.watch<AppCubit>().isExpertMode)
            _buildQrListTile(contact, isV2: true),
          if (context
                  .watch<MultiWalletTransactionCubit>()
                  .balance(contact.pubKey) >
              0)
            ListTile(
              leading: const Icon(Icons.savings),
              title: Row(
                children: <Widget>[
                  Text(tr('balance')),
                  const Spacer(),
                  BalanceWidget(pubKey: contact.pubKey, small: true),
                ],
              ),
            ),
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
              child: TextScroll(
                '${contact.titleWithoutNick}      ',
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
}
