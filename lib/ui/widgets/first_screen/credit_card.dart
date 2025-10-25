import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../data/models/app_cubit.dart';
import '../../../data/models/stored_account.dart';
import '../../../g1/g1_helper.dart';
import '../../../shared_prefs_helper.dart';
import '../../logger.dart';
import '../../ui_helpers.dart';
import '../card_helper.dart';
import '../contacts_actions.dart';
import 'card_name_editable.dart';
import 'card_text_style.dart';

class CreditCard extends StatelessWidget {
  const CreditCard({super.key, required this.account});

  final StoredAccount account;

  @override
  Widget build(BuildContext context) {
    const double cardRadius = 10.0;
    final String publicKey =
        account.type.isV2 ? account.address : account.pubKey;
    final bool allowEditName = account.type == AccountType.v1PasswordLess &&
        !context.read<AppCubit>().state.v2mode;

    return Card(
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cardRadius),
        ),
        child: AspectRatio(
            aspectRatio: cardAspectRatio, // Credit card aspect ratio
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              // Calculate all sizes based on card dimensions
              final double cardWidth = constraints.maxWidth;
              final double cardHeight = constraints.maxHeight;

              // Responsive padding and sizes based on card height
              final double verticalPadding = cardHeight * 0.08; // 8% of height
              final double horizontalPadding =
                  cardWidth * 0.055; // 5.5% of width
              final double titleSize = cardHeight * 0.11; // 11% of height
              final double iconSize = bigScreen(context) ? 28 : 20;
              final double chipWidth = cardWidth < smallScreenWidth ? 25 : 40;
              final double spacing = cardHeight * 0.02; // 2% of height
              loggerDev(
                  'Card: ${cardWidth.toStringAsFixed(1)}x${cardHeight.toStringAsFixed(1)}, Chip: ${chipWidth.toStringAsFixed(1)}');
              return Container(
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
                      SharedPreferencesHelper().getTheme().primaryColor,
                      SharedPreferencesHelper().getTheme().secondaryColor
                    ],
                  ),
                ),
                child: Stack(children: <Widget>[
                  // Background logo
                  Positioned(
                    right: -cardWidth * 0.05,
                    top: cardHeight * 0.05,
                    child: Opacity(
                      opacity: 0.1,
                      child: Image.asset(
                        'assets/img/gbrevedot_alt.png',
                        width: cardWidth * 0.55,
                        height: cardHeight * 0.55,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  // Main content
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: verticalPadding,
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
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(width: spacing),
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
                            SizedBox(width: spacing * 2),
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
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: GestureDetector(
                                onTap: () => showMyContactPage(context),
                                child: Text(
                                  simplifyPubKey(extractPublicKey(publicKey)),
                                  style: cardTextStyle(context),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            /* GestureDetector(
                              onTap: () => showMyContactPage(context),
                              child: Text(
                                ' **** ****',
                                style: cardTextStyle(context),
                                maxLines: 1,
                              ),
                            ), */
                          ],
                        ),
                      ],
                    ),
                  ),
                ]),
              );
            })));
  }
}
