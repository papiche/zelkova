import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../data/models/app_cubit.dart';
import '../../data/models/contact.dart';
import '../../data/models/multi_wallet_transaction_cubit.dart';
import '../../g1/api.dart';
import '../../g1/g1_helper.dart';
import '../ui_helpers.dart';
import 'fourth_screen/transactions_and_balance_widget.dart';

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
    // Clear the txs from the state when the page is closed
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

  Scaffold _buildContactWidget(Contact contact, BuildContext context) {
    final String pubKey = contact.pubKey;
    final String v2Address = contact.address;

    return Scaffold(
      appBar: AppBar(
        title: Text(tr('account_info')),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: Theme.of(context).colorScheme.secondaryContainer,
              width: double.infinity,
              height: isAvatarExpanded
                  ? MediaQuery.of(context).size.height / 2
                  : 132,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Center(
                  child: Column(children: <Widget>[
                GestureDetector(
                    onTap: () {
                      setState(() {
                        isAvatarExpanded = !isAvatarExpanded;
                      });
                    },
                    child: AnimatedContainer(
                        width: isAvatarExpanded
                            ? MediaQuery.of(context).size.width
                            : 64,
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
                                  child:
                                      avatar(contact.avatar, avatarSize: 44)),
                              AnimatedOpacity(
                                opacity: isAvatarExpanded ? 1.0 : 0.0,
                                duration: const Duration(milliseconds: 300),
                                child: contact.avatar == null
                                    ? avatar(contact.avatar, avatarSize: 44)
                                    : Container(
                                        width: double.infinity,
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: MemoryImage(contact.avatar!),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                              ),
                            ]))),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextScroll('${contact.titleWithoutNick}      ',
                      style: Theme.of(context).textTheme.titleLarge),
                )
              ])),
            ),
            const SizedBox(height: 20),
            if (contact.nick != null)
              ListTile(
                leading: const Icon(Symbols.editor_choice),
                title: Text('@${contact.nick}'),
              ),
            QrListTile(pubKeyOrAddress: pubKey, isV2: false),
            if (context.read<AppCubit>().isExpertMode)
              QrListTile(pubKeyOrAddress: v2Address, isV2: true),
            if (contact.notes != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: const Icon(Icons.note),
                  title: Text(contact.notes!),
                ),
              ),
            if (context.watch<MultiWalletTransactionCubit>().balance(pubKey) >
                0)
              ListTile(
                  leading: const Icon(Icons.savings),
                  title: Row(children: <Widget>[
                    Text(tr('balance')),
                    const Spacer(),
                    BalanceWidget(pubKey: contact.pubKey, small: true)
                  ])),
            ListTile(
              // leading: const Icon(Icons.savings),
              title: Text(tr('transactions')),
            ),
            TransactionsAndBalanceWidget(
              isExternalAccount: true,
              // isScrollEnabled: true,
              pubKey: contact.pubKey,
            ),
          ],
        ),
      ),
    );
  }
}

class QrListTile extends StatelessWidget {
  const QrListTile(
      {super.key, required this.pubKeyOrAddress, required this.isV2});

  final String pubKeyOrAddress;
  final bool isV2;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          showQrDialog(
              context: context,
              publicKey:
                  isV2 ? pubKeyOrAddress : getFullPubKey(pubKeyOrAddress),
              noTitle: true,
              feedbackText: 'some_key_copied_to_clipboard');
        },
        child: ListTile(
            leading: const Icon(Icons.key),
            trailing: !isV2
                ? const Icon(Icons.qr_code)
                : const Badge(
                    label: Text('v2'),
                    child: Icon(Icons.qr_code),
                  ),
            title: Text(!isV2
                ? tr('form_contact_pub_key')
                : tr('form_contact_address_v2')),
            subtitle: Text(!isV2
                ? humanizePubKey(pubKeyOrAddress)
                : humanizeAddress(pubKeyOrAddress))));
  }
}
