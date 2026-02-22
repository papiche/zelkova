import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/bottom_nav_cubit.dart';
import '../../../data/models/contact.dart';
import '../../../data/models/multi_wallet_transaction_cubit.dart';
import '../../../data/models/stored_account.dart';
import '../../../data/models/wallet_themes.dart';
import '../../../g1/g1_helper.dart';
import '../../../shared_prefs_helper.dart';
import '../../logger.dart';
import '../../ui_helpers.dart';
import '../account_card_theme_selector.dart';
import 'simple_card_name_text.dart';

class DrawerWalletCard extends StatelessWidget {
  const DrawerWalletCard(
      {super.key,
      required this.card,
      required this.cardIndex,
      required this.settingsVisible});

  final StoredAccount card;
  final bool settingsVisible;
  final int cardIndex;

  void _showThemeSelector(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(tr('card_theme_select')),
          content: SizedBox(
              width: double.maxFinite,
              child: AccountCardThemeSelector(
                  account: card,
                  onTap: (WalletTheme theme) =>
                      SharedPreferencesHelper().setTheme(theme: theme))),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const double cardRadius = 10.0;
    final bool bigDevice = bigScreen(context);
    final double cardInternalElPadding = bigDevice ? 5 : 6.0;
    return Padding(
        padding: const EdgeInsets.all(10),
        child: settingsVisible
            ? _buildCard(cardRadius, context, cardInternalElPadding, bigDevice)
            : GestureDetector(
                onTap: () => onCardTap(context),
                child: _buildCard(
                    cardRadius, context, cardInternalElPadding, bigDevice)));
  }

  Card _buildCard(double cardRadius, BuildContext context,
      double cardInternalElPadding, bool bigDevice) {
    final Contact c = card.contact;
    final bool isHighlighted = (SharedPreferencesHelper().highlightedGroupId ==
            (card.derivationParentId ?? card.pubKey)) &&
        SharedPreferencesHelper().isHighlightVisible;

    return Card(
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cardRadius),
          side: isHighlighted
              ? const BorderSide(color: Colors.white, width: 2.0)
              : BorderSide.none,
        ),
        child: AspectRatio(
            aspectRatio: cardAspectRatio,
            // Credit cart aspect ratio
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(cardRadius),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: isHighlighted ? Colors.white54 : Colors.grey[400]!,
                      blurRadius: isHighlighted ? 12.0 : 3.0,
                      spreadRadius: 1.0,
                    )
                  ],
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: <Color>[
                      card.theme.primaryColor,
                      card.theme.secondaryColor
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Stack(children: <Widget>[
                    if (settingsVisible)
                      Positioned(
                        bottom: 4,
                        right: 4,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (card.type.isV2 &&
                                card.derivationParentId == null)
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: FloatingActionButton(
                                  mini: true,
                                  backgroundColor: Colors.white10,
                                  elevation: 1,
                                  onPressed: () {
                                    SharedPreferencesHelper()
                                        .highlightGroup(card.pubKey);
                                    _deriveAccount(context);
                                  },
                                  child: const Icon(Icons.add_link,
                                      color: Colors.white),
                                ),
                              ),
                            if (SharedPreferencesHelper().hasMultipleWallets)
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: FloatingActionButton(
                                  mini: true,
                                  backgroundColor: Colors.white12,
                                  elevation: 1,
                                  onPressed: () {
                                    showDialog<bool>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text(
                                                tr('please_confirm_delete')),
                                            content: Text(tr(SharedPreferencesHelper()
                                                    .isPasswordLessWallet()
                                                ? 'please_confirm_delete_desc_g1nkgo'
                                                : 'please_confirm_delete_desc')),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.of(context)
                                                        .pop(false),
                                                child: Text(tr('cancel')),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  SharedPreferencesHelper()
                                                      .removeCurrentWallet();
                                                  SharedPreferencesHelper()
                                                      .selectCurrentWalletIndex(
                                                          0);
                                                  Navigator.pop(context);
                                                },
                                                child: Text(tr('accept')),
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  child: const Icon(Icons.delete,
                                      color: Colors.white),
                                ),
                              ),
                            FloatingActionButton(
                              mini: true,
                              backgroundColor: Colors.white10,
                              elevation: 1,
                              onPressed: () => _showThemeSelector(context),
                              child: const Icon(Icons.settings,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    if (card.derivationParentId != null)
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: GestureDetector(
                          onTap: () {
                            SharedPreferencesHelper()
                                .highlightGroup(card.derivationParentId);
                            final Iterable<StoredAccount> parents =
                                SharedPreferencesHelper().accounts.where(
                                    (StoredAccount a) =>
                                        a.pubKey == card.derivationParentId);
                            final StoredAccount? parent =
                                parents.isNotEmpty ? parents.first : null;
                            final String parentName = parent != null
                                ? (parent.type.isV2
                                    ? simplifyPubKey(
                                        extractPublicKey(parent.address))
                                    : simplifyPubKey(
                                        extractPublicKey(parent.pubKey)))
                                : simplifyPubKey(
                                    extractPublicKey(card.derivationParentId!));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(tr('linked_to',
                                    namedArgs: {'name': parentName})),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.link,
                                color: Colors.white70, size: 24),
                          ),
                        ),
                      ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(120, 10, 0, 0),
                        child: Opacity(
                          opacity: 0.2,
                          child: Image.asset('assets/img/gbrevedot_alt.png',
                              width: 100, height: 100),
                        )),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          if (c.hasTitle)
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: cardInternalElPadding,
                                    vertical: cardInternalElPadding),
                                child: Row(children: <Widget>[
                                  Expanded(
                                    child: SimpleCardNameText(
                                        currentText:
                                            c.titleWithoutAddressOrPubKey,
                                        onTap: null,
                                        addSuffix: true,
                                        account: card),
                                  ),
                                ])),
                          if (!c.hasTitle)
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: cardInternalElPadding,
                                    vertical: cardInternalElPadding),
                                child: Row(children: <Widget>[
                                  Expanded(
                                    child: SimpleCardNameText(
                                        currentText: card.type.isV2
                                            ? simplifyPubKey(
                                                extractPublicKey(card.address))
                                            : simplifyPubKey(
                                                extractPublicKey(card.pubKey)),
                                        onTap: null,
                                        addSuffix: false,
                                        account: card),
                                  ),
                                ])),
                          if (bigDevice) const SizedBox(height: 6.0),
                          const SizedBox(height: 8.0),
                        ]),
                  ]),
                ))));
  }

  Future<void> onCardTap(BuildContext context) async {
    logger("Card ${humanizeContact('', card.contact)} was tapped!");
    await SharedPreferencesHelper().selectCurrentWallet(card.pubKey);
    if (context.mounted) {
      context.read<BottomNavCubit>().updateIndex(0);
    }
    // Add a small delay to let the user see the card reordering
    await Future<void>.delayed(const Duration(milliseconds: 500));
    if (context.mounted) {
      Navigator.pop(context);
    }
    // It's this causing a slowdown when switching wallets?
    await context.read<MultiWalletTransactionCubit>().fetchTransactions();
  }

  Future<void> _deriveAccount(BuildContext context) async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(tr('link_account_title')),
        content: Text(tr('link_account_desc')),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(tr('cancel')),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(tr('accept')),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await SharedPreferencesHelper().deriveNextAccount(card);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(tr('link_account_success'))),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(tr('link_account_error',
                    namedArgs: {'error': e.toString()}))),
          );
        }
      }
    }
  }
}
