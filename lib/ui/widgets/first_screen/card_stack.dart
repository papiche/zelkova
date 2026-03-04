import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/models/stored_account.dart';
import '../../../shared_prefs_helper.dart';
import '../add_wallet_assistant.dart';
import 'drawer_credit_card.dart';

class CardStack extends StatefulWidget {
  const CardStack({super.key});

  @override
  State<CardStack> createState() => _CardStackState();
}

class _CardStackState extends State<CardStack> {
  int visibleCardIndex = 0;

  @override
  Widget build(BuildContext context) {
    assert(() {
      debugPrint('🎴 CardStack rebuilding');
      return true;
    }());
    return Consumer<SharedPreferencesHelper>(builder: (BuildContext context,
        SharedPreferencesHelper prefsHelper, Widget? child) {
      final List<StoredAccount> accounts = SharedPreferencesHelper().accounts;
      final List<StoredAccount> cards = List<StoredAccount>.from(accounts);
      final StoredAccount currentAccount =
          SharedPreferencesHelper().getCurrentAccount();

      assert(() {
        debugPrint('   Total accounts: ${accounts.length}');
        debugPrint('   Current account: ${currentAccount.pubKey}');
        return true;
      }());

      // Sort cards: least recently used at the top, most recently used at the bottom.
      // The current wallet (matching _currentPubKey) MUST be last (visible on top).
      cards.sort((StoredAccount a, StoredAccount b) {
        final bool aIsCurrent = a.pubKey == currentAccount.pubKey;
        final bool bIsCurrent = b.pubKey == currentAccount.pubKey;

        // CRITICAL: Current wallet always goes last (on top visually)
        if (aIsCurrent && !bIsCurrent) {
          return 1; // a goes after b
        }
        if (!aIsCurrent && bIsCurrent) {
          return -1; // b goes after a
        }

        // For non-current wallets, sort by lastUsed
        final int aUsed = a.lastUsed ?? 0;
        final int bUsed = b.lastUsed ?? 0;
        if (aUsed != bUsed) {
          return aUsed.compareTo(bUsed);
        }
        // Fallback to import order (original list order)
        return accounts.indexOf(a).compareTo(accounts.indexOf(b));
      });

      final int walletsSize = cards.length;
      return SizedBox(
          height: 200 + ((cards.length - 1) * 45),
          child: Center(
              child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              ...List<Widget>.generate(
                walletsSize,
                (int index) {
                  final StoredAccount card = cards[index];
                  final bool isCurrentWallet =
                      card.pubKey == currentAccount.pubKey;
                  return AnimatedPositioned(
                    key: ValueKey<String>(card.pubKey),
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    top: 45.0 * index,
                    child: SizedBox(
                        height: 200,
                        child: DrawerWalletCard(
                            card: card,
                            cardIndex: index,
                            settingsVisible:
                                index == walletsSize - 1 && isCurrentWallet)),
                  );
                },
              ),
              Positioned(
                  right: 25,
                  top: -15,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.black45,
                          spreadRadius: 10,
                          blurRadius: 10,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: FloatingActionButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const WalletOptionsDialog();
                            });
                      },
                      child: const Icon(Icons.add),
                    ),
                  ))
            ],
          )));
    });
  }
}
