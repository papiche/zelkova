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
import 'card_name_editable.dart';
import 'card_text_style.dart';

class CreditCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    const double cardRadius = 10.0;
    final String publicKey =
        account.type.isV2 ? account.address : account.pubKey;
    final bool allowEditName =
        account.type == AccountType.v1PasswordLess && !isV2Mode;
    final WalletTheme cardTheme = theme ?? account.theme;

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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                account,
                                iconSize,
                                true,
                              ),
                            ],
                          ),
                          // Middle: Chip and name
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
                                  key: Key(account.pubKey),
                                  publicKey: publicKey,
                                  cardName: account.title,
                                  isEditable: allowEditName,
                                  isPassProtected:
                                      account.type.isPasswordProtected,
                                  defValue:
                                      allowEditName ? tr('your_name_here') : '',
                                ),
                              ),
                            ],
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
