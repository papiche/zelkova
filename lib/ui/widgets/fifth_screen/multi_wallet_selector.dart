import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../data/models/legacy_wallet.dart';
import '../../../g1/g1_helper.dart';
import '../../../shared_prefs_helper.dart';
import '../../pattern_util.dart';
import '../../ui_helpers.dart';
import '../first_screen/account_card_selector_item.dart';

class MultiWalletSelectorPage extends StatefulWidget {
  const MultiWalletSelectorPage({super.key, required this.onSelectionChanged});

  final Function(List<LegacyWallet>, bool) onSelectionChanged;

  @override
  State<MultiWalletSelectorPage> createState() =>
      _MultiWalletSelectorPageState();
}

class _MultiWalletSelectorPageState extends State<MultiWalletSelectorPage> {
  final List<LegacyWallet> _selectedCards = <LegacyWallet>[];
  bool _exportContacts = true;
  bool _selectAll = false;

  final List<LegacyWallet> _cards = SharedPreferencesHelper()
      .legacyWallets
      .where((LegacyWallet card) => card.seed.isNotEmpty)
      .toList();

  void _onCardTapped(LegacyWallet card) {
    setState(() {
      if (_selectedCards.contains(card)) {
        _selectedCards.remove(card);
      } else {
        _selectedCards.add(card);
      }

      // Sync select all state
      _selectAll = _selectedCards.length == _cards.length;
    });
  }

  void _toggleSelectAll(bool value) {
    setState(() {
      _selectAll = value;
      if (_selectAll) {
        _selectedCards.clear();
        _selectedCards.addAll(_cards);
      } else {
        _selectedCards.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('select_wallets_export')),
        actions: <Widget>[
          TextButton.icon(
            icon: const Icon(Icons.check),
            label: Text(tr('ok')),
            onPressed: _selectedCards.isEmpty
                ? () {
                    context.replaceSnackbar(
                      content: Text(
                        tr('please_select_wallets'),
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }
                : () {
                    Navigator.of(context).pop();
                    widget.onSelectionChanged(_selectedCards, _exportContacts);
                  },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    ResponsiveBreakpoints.of(context).largerThan(MOBILE)
                        ? 4
                        : 2,
                childAspectRatio: 1.58,
              ),
              itemCount: _cards.length,
              itemBuilder: (BuildContext context, int index) {
                final LegacyWallet card = _cards[index];
                final bool isSelected = _selectedCards.contains(card);
                return GestureDetector(
                  onTap: () => _onCardTapped(card),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.green : Colors.transparent,
                          border: isSelected
                              ? Border.all(color: Colors.green, width: 4)
                              : Border.all(color: Colors.transparent, width: 4),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Center(
                        child: AccountCardSelectorItem(
                            name: card.name.isEmpty
                                ? humanizePubKey(card.pubKey)
                                : truncateName(card.name),
                            hasName: card.name.isNotEmpty,
                            suffix: SharedPreferencesHelper()
                                    .isPasswordLessWallet(card)
                                ? g1nkgoUserNameSuffix
                                : protectedUserNameSuffix,
                            theme: card.theme),
                      ),
                      if (isSelected)
                        const Positioned(
                          top: 8,
                          right: 8,
                          child: Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 24,
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SwitchListTile(
              title: Text(tr('select_all_wallets')),
              value: _selectAll,
              onChanged: _toggleSelectAll,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SwitchListTile(
              title: Text(tr('export_contacts')),
              value: _exportContacts,
              onChanged: (bool value) {
                setState(() {
                  _exportContacts = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

void showMultiWalletSelector(BuildContext context,
    Function(List<LegacyWallet>, bool) onSelectionChanged) {
  Navigator.push(
    context,
    MaterialPageRoute<Widget>(
      builder: (BuildContext context) =>
          MultiWalletSelectorPage(onSelectionChanged: onSelectionChanged),
    ),
  );
}
