import 'dart:async';

import 'package:bip340/bip340.dart' as bip340;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../data/models/stored_account.dart';
import '../../../data/models/wallet_themes.dart';
import '../../../g1/g1_helper.dart';
import '../../../g1/nostr/nostr_keys.dart';
import '../../../g1/nostr/nostr_profile.dart';
import '../../../g1/nostr/nostr_relay_service.dart';
import '../../../shared_prefs_helper.dart';
import '../../../shared_prefs_helper_v2.dart';
import '../../logger.dart';
import '../../ui_helpers.dart';
import '../avatar_badge.dart';
import '../card_helper.dart';
import '../contacts_actions.dart';
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
  String? _nostrBannerUrl;
  String? _nostrPictureUrl;
  StreamSubscription<bool>? _relayConnectionSub;

  @override
  void initState() {
    super.initState();
    _fetchNostrProfile();
    _relayConnectionSub =
        NostrRelayService().onConnectionChange.listen((bool connected) {
      if (connected && mounted && _nostrBannerUrl == null && _nostrPictureUrl == null) {
        _fetchNostrProfile();
      }
    });
  }

  @override
  void dispose() {
    _relayConnectionSub?.cancel();
    super.dispose();
  }

  Future<void> _fetchNostrProfile() async {
    final NostrRelayService relay = NostrRelayService();
    if (!relay.isConnected) {
      try {
        await relay.onConnectionChange
            .firstWhere((bool c) => c)
            .timeout(const Duration(seconds: 15));
      } catch (_) {
        return;
      }
    }
    if (!mounted) return;
    try {
      String? nostrHex;
      final bool isCurrent = widget.account.pubKey ==
          SharedPreferencesHelper().getCurrentAccount().pubKey;
      if (isCurrent) {
        final String? nsec =
            await SharedPreferencesHelperV2().getNostrNsec();
        if (nsec != null && nsec.isNotEmpty) {
          nostrHex =
              bip340.getPublicKey(NostrKeys.nsecToHex(nsec));
        }
      }
      nostrHex ??= await relay.findNostrHexByG1Pub(widget.account.pubKey);
      if (nostrHex == null) return;
      final NostrProfile? nostrProfile = await relay.fetchProfile(nostrHex);
      if (nostrProfile != null && mounted) {
        setState(() {
          _nostrBannerUrl = nostrProfile.banner?.isNotEmpty ?? false
              ? nostrProfile.banner
              : null;
          _nostrPictureUrl = nostrProfile.picture?.isNotEmpty ?? false
              ? nostrProfile.picture
              : null;
        });
        loggerDev('[CreditCard] NOSTR loaded: banner=${_nostrBannerUrl != null} picture=${_nostrPictureUrl != null}');
      }
    } catch (e) {
      loggerDev('[CreditCard] NOSTR fetch error: $e');
    }
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
        (widget.account.contact.isMember ?? true);
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
                  // Banner NOSTR comme fond si disponible,
                  // sinon gradient neutre fixe
                  image: _nostrBannerUrl != null
                      ? DecorationImage(
                          image: NetworkImage(_nostrBannerUrl!),
                          fit: BoxFit.cover,
                          colorFilter: const ColorFilter.mode(
                              Colors.black38, BlendMode.darken),
                          onError: (_, __) {},
                        )
                      : null,
                  gradient: _nostrBannerUrl == null
                      ? const LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: <Color>[
                            Color(0xFF1a237e),
                            Color(0xFF4a148c),
                          ],
                        )
                      : null,
                ),
                child: Stack(
                  children: <Widget>[
                    // Picture NOSTR en avatar rond (coin haut droit)
                    if (_nostrPictureUrl != null)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Colors.white38, width: 1.5),
                            image: DecorationImage(
                              image: NetworkImage(_nostrPictureUrl!),
                              fit: BoxFit.cover,
                              onError: (_, __) {},
                            ),
                          ),
                        ),
                      ),
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
