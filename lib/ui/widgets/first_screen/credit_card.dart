import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../data/models/stored_account.dart';
import '../../../data/models/wallet_themes.dart';
import '../../../g1/g1_helper.dart';
import '../../logger.dart';
import '../../ui_helpers.dart';
import '../card_helper.dart';
import '../contacts_actions.dart';
import '../avatar_badge.dart';
import 'card_name_editable.dart';
import 'card_text_style.dart';

class CreditCard extends StatefulWidget {
  const CreditCard({
    super.key,
    required this.account,
    this.isV2Mode = false,
    this.theme,
  });

  final StoredAccount account;
  final bool isV2Mode;
  final WalletTheme? theme;

  @override
  State<CreditCard> createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCard> {
  void _showAvatarDialog() {
    if (!widget.account.contact.hasAvatar) {
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              color: Colors.black.withValues(alpha: 0.9),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 120,
                    child: ClipOval(
                      child: Image.memory(
                        widget.account.contact.avatar!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    right: 20,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close,
                          color: Colors.white, size: 30),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const double cardRadius = 10.0;
    final String publicKey = widget.account.type.isV2
        ? widget.account.address
        : widget.account.pubKey;
    // Edit is allowed only when the account has no Duniter identity.
    // Accounts with an identity display their nick read-only.
    final bool hasIdentity = (widget.account.contact.nick != null &&
            widget.account.contact.nick!.isNotEmpty) ||
        widget.account.contact.isMember != false;
    final WalletTheme cardTheme = widget.theme ?? widget.account.theme;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // Calculate dimensions to maintain 1.58 aspect ratio
        final double availableWidth = constraints.maxWidth;
        final double calculatedHeight = availableWidth / cardAspectRatio;

        final double cardWidth = availableWidth;
        final double cardHeight = calculatedHeight;

        final bool bigDevice = bigScreen(context);
        final double cardPadding = bigDevice ? 26.0 : 16.0;
        final double titleSize = cardWidth * 0.07;
        final double iconSize = bigDevice ? 28.0 : 20.0;
        final double chipWidth = cardWidth < smallScreenWidth ? 25.0 : 40.0;

        final double actualRatio = cardWidth / cardHeight;
        final String ratioStatus =
            (actualRatio - cardAspectRatio).abs() < 0.01 ? '✓' : '✗ WRONG!';

        loggerDev(
            '$ratioStatus Card: ${cardWidth.toStringAsFixed(1)}x${cardHeight.toStringAsFixed(1)}, Ratio: ${actualRatio.toStringAsFixed(2)} (expected: $cardAspectRatio), Chip: ${chipWidth.toStringAsFixed(1)}');

        return SizedBox(
          width: cardWidth,
          height: cardHeight,
          child: Card(
            elevation: 8.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(cardRadius),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(cardRadius),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(cardRadius),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey[400]!,
                      blurRadius: 10.0,
                      spreadRadius: 1.0,
                    )
                  ],
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: <Color>[
                      cardTheme.primaryColor,
                      cardTheme.secondaryColor
                    ],
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    // Background logo
                    Padding(
                      padding: const EdgeInsets.fromLTRB(160, 10, 0, 0),
                      child: Opacity(
                        opacity: 0.1,
                        child: Image.asset('assets/img/gbrevedot_alt.png'),
                      ),
                    ),
                    // Main content
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: cardPadding,
                        vertical: cardPadding * 0.7,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          // Header: Title and icon
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  tr('g1_wallet'),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: titleSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              walletIconByType(
                                context,
                                widget.account,
                                iconSize,
                                true,
                              ),
                            ],
                          ),
                          // Middle: Chip and name with avatar
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () => showMyContactPage(context),
                                      child: SvgPicture.asset(
                                        'assets/img/chip.svg',
                                        width: chipWidth,
                                      ),
                                    ),
                                    const SizedBox(width: 10.0),
                                    Expanded(
                                      child: CardNameEditable(
                                        key: Key(widget.account.pubKey),
                                        account: widget.account,
                                        defValue: !hasIdentity
                                            ? tr('your_name_here')
                                            : '',
                                      ),
                                    ),
                                  ],
                                ),
                                if (widget.account.contact.hasAvatar &&
                                    bigDevice)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: GestureDetector(
                                      onTap: () => showMyContactPage(context),
                                      child: AvatarBadge(
                                        contact: widget.account.contact,
                                        radius: 16,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          // Bottom: Public key
                          GestureDetector(
                            onTap: () => showMyContactPage(context),
                            child: Text(
                              simplifyPubKey(extractPublicKey(publicKey)),
                              style: cardTextStyle(context),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          const SizedBox(height: 18.0),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
