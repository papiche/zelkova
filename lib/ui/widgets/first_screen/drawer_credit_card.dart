import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/app_cubit.dart';
import '../../../data/models/bottom_nav_cubit.dart';
import '../../../data/models/contact.dart';
import '../../../data/models/multi_wallet_transaction_cubit.dart';
import '../../../data/models/stored_account.dart';
import '../../../data/models/wallet_themes.dart';
import '../../../g1/g1_helper.dart';
import '../../../shared_prefs_helper.dart';
import '../../logger.dart';
import '../../secure_unlock_widget.dart';
import '../../ui_helpers.dart';
import '../account_card_theme_selector.dart';
import '../avatar_badge.dart';
import '../avatar_dialog.dart';
import 'simple_card_name_text.dart';

class DrawerWalletCard extends StatefulWidget {
  const DrawerWalletCard(
      {super.key,
      required this.card,
      required this.cardIndex,
      required this.settingsVisible});

  final StoredAccount card;
  final bool settingsVisible;
  final int cardIndex;

  @override
  State<DrawerWalletCard> createState() => _DrawerWalletCardState();
}

class _DrawerWalletCardState extends State<DrawerWalletCard> {
  static DateTime? _lastDeletionTime;
  static const Duration _deletionCooldown = Duration(milliseconds: 500);
  bool _isDeleting = false;

  void _showAccountOptions(BuildContext context) {
    // Check if account is v2PasswordLess and can be upgraded
    final bool canUpgrade = widget.card.type == AccountType.v2PasswordLess;
    // Check if account can be used as parent for linked account
    final bool canCreateLinked =
        widget.card.type.isV2 && widget.card.derivationParentId == null;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(tr('card_options')),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.palette),
                  title: Text(tr('change_theme_option')),
                  onTap: () {
                    Navigator.pop(context);
                    _showThemeSelector(context);
                  },
                ),
                if (canUpgrade)
                  ListTile(
                    leading: const Icon(Icons.security),
                    title: Text(tr('secure_account_option')),
                    onTap: () {
                      Navigator.pop(context);
                      _upgradeAccountToProtected(context);
                    },
                  ),
                if (canCreateLinked)
                  ListTile(
                    leading: const Icon(Icons.add_link),
                    title: Text(tr('create_linked_account_option')),
                    onTap: () {
                      Navigator.pop(context);
                      _deriveAccount(context);
                    },
                  ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(tr('cancel')),
            ),
          ],
        );
      },
    );
  }

  void _showThemeSelector(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(tr('card_theme_select')),
          content: SizedBox(
              width: double.maxFinite,
              child: AccountCardThemeSelector(
                  account: widget.card,
                  onTap: (WalletTheme theme) =>
                      SharedPreferencesHelper().setTheme(theme: theme))),
        );
      },
    );
  }

  Future<void> _upgradeAccountToProtected(BuildContext context) async {
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
              onPressed: () => Navigator.of(ctx).pop(false),
              child: Text(tr('cancel')),
            ),
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: Text(tr('accept')),
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
        .upgradeToPasswordProtected(widget.card, key);
    if (!mounted) {
      return;
    }
    if (success) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(tr('account_upgrade_success'))),
        );
      }
      setState(() {});
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(tr('account_upgrade_failed'))),
        );
      }
    }
  }

  void _showAvatarDialog() {
    if (!widget.card.contact.hasAvatar) {
      return;
    }

    showAvatarDialog(context, widget.card.contact.avatar!);
  }

  @override
  Widget build(BuildContext context) {
    const double cardRadius = 10.0;
    final bool bigDevice = bigScreen(context);
    final double cardInternalElPadding = bigDevice ? 5 : 6.0;
    return Padding(
        padding: const EdgeInsets.all(10),
        child: widget.settingsVisible
            ? _buildCard(cardRadius, context, cardInternalElPadding, bigDevice)
            : GestureDetector(
                onTap: () => onCardTap(context),
                child: _buildCard(
                    cardRadius, context, cardInternalElPadding, bigDevice)));
  }

  Card _buildCard(double cardRadius, BuildContext context,
      double cardInternalElPadding, bool bigDevice) {
    final Contact c = widget.card.contact;
    final bool isHighlighted = (SharedPreferencesHelper().highlightedGroupId ==
            (widget.card.derivationParentId ?? widget.card.pubKey)) &&
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
                      widget.card.theme.primaryColor,
                      widget.card.theme.secondaryColor
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Stack(children: <Widget>[
                    if (widget.settingsVisible)
                      Positioned(
                        bottom: 4,
                        right: 4,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            if (SharedPreferencesHelper().hasMultipleWallets)
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: FloatingActionButton(
                                  mini: true,
                                  backgroundColor: Colors.white12,
                                  elevation: 1,
                                  onPressed: _isDeleting
                                      ? null
                                      : () {
                                          if (_lastDeletionTime != null) {
                                            final Duration elapsed =
                                                DateTime.now().difference(
                                                    _lastDeletionTime!);
                                            if (elapsed < _deletionCooldown) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(tr(
                                                      'please_wait_deletion')),
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                ),
                                              );
                                              return;
                                            }
                                          }
                                          final String displayName = widget
                                                  .card.contact.hasTitle
                                              ? widget.card.contact
                                                  .titleWithoutAddressOrPubKey
                                              : (widget.card.type.isV2
                                                  ? simplifyPubKey(
                                                      extractPublicKey(
                                                          widget.card.address))
                                                  : simplifyPubKey(
                                                      extractPublicKey(
                                                          widget.card.pubKey)));
                                          showDialog<bool>(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (BuildContext context) {
                                                return StatefulBuilder(builder:
                                                    (BuildContext context,
                                                        void Function(
                                                                void Function())
                                                            setDialogState) {
                                                  return AlertDialog(
                                                    title: Text(tr(
                                                        'please_confirm_delete')),
                                                    content: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(tr(SharedPreferencesHelper()
                                                                .isPasswordLessWallet()
                                                            ? 'please_confirm_delete_desc_g1nkgo'
                                                            : 'please_confirm_delete_desc')),
                                                        const SizedBox(
                                                            height: 16),
                                                        Text(
                                                          tr('wallet_to_delete',
                                                              namedArgs: <String,
                                                                  String>{
                                                                'name':
                                                                    displayName
                                                              }),
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.of(
                                                                    context)
                                                                .pop(false),
                                                        child:
                                                            Text(tr('cancel')),
                                                      ),
                                                      TextButton(
                                                        onPressed: () async {
                                                          setDialogState(() {
                                                            _isDeleting = true;
                                                          });
                                                          if (mounted) {
                                                            setState(() {
                                                              _isDeleting =
                                                                  true;
                                                            });
                                                          }
                                                          try {
                                                            await SharedPreferencesHelper()
                                                                .removeWallet(
                                                                    widget.card
                                                                        .pubKey);
                                                            await Future<
                                                                    void>.delayed(
                                                                const Duration(
                                                                    milliseconds:
                                                                        100));
                                                            if (context
                                                                .mounted) {
                                                              Navigator.pop(
                                                                  context,
                                                                  true);
                                                            }
                                                          } catch (e) {
                                                            if (context
                                                                .mounted) {
                                                              setDialogState(
                                                                  () {
                                                                _isDeleting =
                                                                    false;
                                                              });
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                  content: Text(
                                                                      tr('delete_wallet_error')),
                                                                ),
                                                              );
                                                            }
                                                          } finally {
                                                            if (mounted) {
                                                              setState(() {
                                                                _isDeleting =
                                                                    false;
                                                              });
                                                            }
                                                          }
                                                        },
                                                        child: _isDeleting
                                                            ? const SizedBox(
                                                                width: 16,
                                                                height: 16,
                                                                child:
                                                                    CircularProgressIndicator(
                                                                  strokeWidth:
                                                                      2,
                                                                  valueColor: AlwaysStoppedAnimation<
                                                                          Color>(
                                                                      Colors
                                                                          .white),
                                                                ),
                                                              )
                                                            : Text(
                                                                tr('accept')),
                                                      ),
                                                    ],
                                                  );
                                                });
                                              }).then((bool? confirmed) {
                                            if (confirmed ?? false) {
                                              _lastDeletionTime =
                                                  DateTime.now();
                                            }
                                          });
                                        },
                                  child: _isDeleting
                                      ? const SizedBox(
                                          width: 16,
                                          height: 16,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.white),
                                          ),
                                        )
                                      : const Icon(Icons.delete,
                                          color: Colors.white),
                                ),
                              ),
                            FloatingActionButton(
                              mini: true,
                              backgroundColor: Colors.white10,
                              elevation: 1,
                              onPressed: () => _showAccountOptions(context),
                              child: const Icon(Icons.settings,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    if (widget.card.derivationParentId != null)
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: GestureDetector(
                          onTap: () {
                            SharedPreferencesHelper()
                                .highlightGroup(widget.card.derivationParentId);
                            final Iterable<StoredAccount> parents =
                                SharedPreferencesHelper().accounts.where(
                                    (StoredAccount a) =>
                                        a.pubKey ==
                                        widget.card.derivationParentId);
                            final StoredAccount? parent =
                                parents.isNotEmpty ? parents.first : null;
                            final String parentName = parent != null
                                ? (parent.type.isV2
                                    ? simplifyPubKey(
                                        extractPublicKey(parent.address))
                                    : simplifyPubKey(
                                        extractPublicKey(parent.pubKey)))
                                : simplifyPubKey(extractPublicKey(
                                    widget.card.derivationParentId!));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(tr('linked_to',
                                    namedArgs: <String, String>{
                                      'name': parentName
                                    })),
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
                                        account: widget.card),
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
                                        currentText: widget.card.type.isV2
                                            ? simplifyPubKey(extractPublicKey(
                                                widget.card.address))
                                            : simplifyPubKey(extractPublicKey(
                                                widget.card.pubKey)),
                                        onTap: null,
                                        addSuffix: false,
                                        account: widget.card),
                                  ),
                                ])),
                          if (widget.card.contact.hasAvatar)
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                  cardInternalElPadding,
                                  12.0,
                                  cardInternalElPadding,
                                  cardInternalElPadding),
                              child: AvatarBadge(
                                contact: widget.card.contact,
                                radius: 16,
                                onTap: _showAvatarDialog,
                              ),
                            ),
                          if (bigDevice) const SizedBox(height: 6.0),
                          const SizedBox(height: 8.0),
                        ]),
                  ]),
                ))));
  }

  Future<void> onCardTap(BuildContext context) async {
    logger("Card ${humanizeContact('', widget.card.contact)} was tapped!");
    await SharedPreferencesHelper().selectCurrentWallet(widget.card.pubKey);
    if (context.mounted) {
      context.read<BottomNavCubit>().updateIndex(0);
      // Pre-fetch WoT info for the selected wallet
      context.read<AppCubit>().updateWotInfo(widget.card.contact);
    }
    // Add a small delay to let the user see the card reordering
    await Future<void>.delayed(const Duration(milliseconds: 500));
    if (context.mounted) {
      Navigator.pop(context);
    }
    // It's this causing a slowdown when switching wallets?
    if (context.mounted) {
      await context.read<MultiWalletTransactionCubit>().fetchTransactions();
    }
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

    if (confirm ?? false) {
      try {
        await SharedPreferencesHelper().deriveNextAccount(widget.card);
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
                    namedArgs: <String, String>{'error': e.toString()}))),
          );
        }
      }
    }
  }
}
