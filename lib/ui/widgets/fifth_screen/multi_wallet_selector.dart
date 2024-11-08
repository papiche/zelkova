import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../data/models/cesium_card.dart';
import '../../../shared_prefs_helper.dart';
import '../../ui_helpers.dart';
import '../first_screen/credit_card_selector_item.dart';

class MultiWalletSelectorDialog extends StatefulWidget {
  const MultiWalletSelectorDialog(
      {super.key, required this.onSelectionChanged});

  final Function(List<CesiumCard>, bool) onSelectionChanged;

  @override
  State<MultiWalletSelectorDialog> createState() =>
      _MultiWalletSelectorDialogState();
}

class _MultiWalletSelectorDialogState extends State<MultiWalletSelectorDialog> {
  final List<CesiumCard> _selectedCards = <CesiumCard>[];
  bool _exportContacts = true;

  final List<CesiumCard> _cards = SharedPreferencesHelper()
      .cesiumCards
      .where((CesiumCard card) => card.seed.isNotEmpty)
      .toList();

  /* To test many
    ..addAll(kDebugMode
        ? SharedPreferencesHelper()
            .cesiumCards
            .where((CesiumCard card) => card.seed.isNotEmpty)
            .toList()
        : []); */

  void _onCardTapped(CesiumCard card) {
    setState(() {
      if (_selectedCards.contains(card)) {
        _selectedCards.remove(card);
      } else {
        _selectedCards.add(card);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height - 252;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              tr('select_wallets_export'),
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          SizedBox(
            height: screenHeight > 400 ? 400 : screenHeight,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.58,
              ),
              itemCount: _cards.length,
              itemBuilder: (BuildContext context, int index) {
                final CesiumCard card = _cards[index];
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
                        child: CreditCardSelectorItem(
                            name: card.name.isEmpty
                                ? humanizePubKey(card.pubKey)
                                : truncateName(card.name),
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
            padding: const EdgeInsets.all(16.0),
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedCards.clear();
                        _selectedCards.addAll(_cards);
                      });
                    },
                    child: SizedBox(
                        width: 100,
                        child: Center(
                          child: Text(
                            tr('select_all_wallets'),
                            textAlign: TextAlign.center,
                            maxLines: 3,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ))),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    widget.onSelectionChanged(_selectedCards, _exportContacts);
                  },
                  child: Text(tr('done')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
