import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../data/models/stored_account.dart';
import '../../../g1/g1_helper.dart';
import '../../../shared_prefs_helper.dart';
import '../../pattern_util.dart';
import '../../ui_helpers.dart';
import '../first_screen/account_card_selector_item.dart';

class MultiWalletSelectorPage extends StatefulWidget {
  const MultiWalletSelectorPage({
    super.key,
    required this.onSelectionChanged,
    this.filterFunction,
    this.title,
    this.allowMultiSelect = true,
    this.showExportContactsToggle = true,
    this.errorMessage,
  });

  final Function(List<StoredAccount>, bool) onSelectionChanged;
  final bool Function(StoredAccount)? filterFunction;
  final String? title;
  final bool allowMultiSelect;
  final bool showExportContactsToggle;
  final String? errorMessage;

  @override
  State<MultiWalletSelectorPage> createState() =>
      _MultiWalletSelectorPageState();
}

class _MultiWalletSelectorPageState extends State<MultiWalletSelectorPage> {
  final List<StoredAccount> _selectedAccounts = <StoredAccount>[];
  bool _exportContacts = true;
  bool _selectAll = false;

  @override
  void initState() {
    super.initState();
    if (widget.allowMultiSelect) {
      _selectedAccounts.addAll(_accounts);
      _selectAll = true;
    }
  }

  late final List<StoredAccount> _accounts = SharedPreferencesHelper()
      .accounts
      .where((StoredAccount card) => widget.filterFunction != null
          ? widget.filterFunction!(card)
          : card.type != AccountType.v1PasswordProtected)
      .toList();

  void _onCardTapped(StoredAccount account) {
    setState(() {
      if (_selectedAccounts.contains(account)) {
        _selectedAccounts.remove(account);
      } else {
        _selectedAccounts.add(account);
      }

      // Sync select all state
      _selectAll = _selectedAccounts.length == _accounts.length;
    });
  }

  void _toggleSelectAll(bool value) {
    setState(() {
      _selectAll = value;
      if (_selectAll) {
        _selectedAccounts.clear();
        _selectedAccounts.addAll(_accounts);
      } else {
        _selectedAccounts.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? tr('select_wallets_export')),
        actions: <Widget>[
          TextButton.icon(
            icon: const Icon(Icons.check),
            label: Text(tr('ok')),
            onPressed: _selectedAccounts.isEmpty
                ? () {
                    context.replaceSnackbar(
                      content: Text(
                        widget.errorMessage ?? tr('please_select_wallets'),
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }
                : () {
                    Navigator.of(context).pop();
                    widget.onSelectionChanged(
                        _selectedAccounts, _exportContacts);
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
              itemCount: _accounts.length,
              itemBuilder: (BuildContext context, int index) {
                final StoredAccount account = _accounts[index];
                final bool isSelected = _selectedAccounts.contains(account);
                return GestureDetector(
                  onTap: () {
                    if (widget.allowMultiSelect) {
                      _onCardTapped(account);
                    } else {
                      // Single select mode
                      setState(() {
                        _selectedAccounts.clear();
                        _selectedAccounts.add(account);
                      });
                    }
                  },
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
                          name: account.contact.name == null ||
                                  (account.contact.name != null &&
                                      account.contact.name!.isEmpty)
                              ? account.type.isV2
                                  ? humanizeAddress(account.contact.address)
                                  : humanizePubKey(account.contact.pubKey)
                              : truncateName(account.contact.name!),
                          hasName: account.contact.name != null &&
                              account.contact.name!.isNotEmpty,
                          suffix: '',
                          theme: account.theme,
                          isDerived: account.derivationParentId != null,
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Checkbox(
                          value: isSelected,
                          onChanged: (bool? value) {
                            if (widget.allowMultiSelect) {
                              _onCardTapped(account);
                            } else {
                              setState(() {
                                _selectedAccounts.clear();
                                _selectedAccounts.add(account);
                              });
                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          checkColor: Colors.white,
                          fillColor: WidgetStateProperty.resolveWith<Color>(
                              (Set<WidgetState> states) {
                            if (states.contains(WidgetState.selected)) {
                              return Theme.of(context).colorScheme.primary;
                            }
                            return Colors.white.withAlpha(60);
                          }),
                          activeColor: Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          if (widget.allowMultiSelect)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SwitchListTile(
                title: Text(tr('select_all_wallets')),
                value: _selectAll,
                onChanged: _toggleSelectAll,
              ),
            ),
          if (widget.showExportContactsToggle)
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

void showMultiWalletSelector(
  BuildContext context,
  Function(List<StoredAccount>, bool) onSelectionChanged,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.95,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (BuildContext context, ScrollController scrollController) {
          return Material(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child:
                MultiWalletSelectorPage(onSelectionChanged: onSelectionChanged),
          );
        },
      );
    },
  );
}

void showSingleWalletSelector(
  BuildContext context,
  Function(StoredAccount) onSelectionChanged, {
  String? title,
  bool Function(StoredAccount)? filterFunction,
  String? errorMessage,
}) {
  // Check if there are available accounts after filtering
  final List<StoredAccount> availableAccounts = SharedPreferencesHelper()
      .accounts
      .where((StoredAccount card) => filterFunction != null
          ? filterFunction(card)
          : card.type != AccountType.v1PasswordProtected)
      .toList();

  if (availableAccounts.isEmpty) {
    // Show error message if no accounts available
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          errorMessage ?? tr('please_select_wallets'),
          style: const TextStyle(color: Colors.red),
        ),
        backgroundColor: Colors.grey.shade800,
      ),
    );
    return;
  }

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.95,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (BuildContext context, ScrollController scrollController) {
          return Material(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: MultiWalletSelectorPage(
              onSelectionChanged: (List<StoredAccount> selected, bool _) {
                if (selected.isNotEmpty) {
                  onSelectionChanged(selected.first);
                }
              },
              allowMultiSelect: false,
              showExportContactsToggle: false,
              title: title,
              filterFunction: filterFunction,
              errorMessage: errorMessage,
            ),
          );
        },
      );
    },
  );
}
