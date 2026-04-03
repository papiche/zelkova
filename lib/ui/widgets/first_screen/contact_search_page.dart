import 'dart:async';

import 'package:collection/collection.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/app_cubit.dart';
import '../../../data/models/bottom_nav_cubit.dart';
import '../../../data/models/contact.dart';
import '../../../data/models/contact_cubit.dart';
import '../../../data/models/contact_state.dart';
import '../../../data/models/payment_cubit.dart';
import '../../../data/models/payment_state.dart';
import '../../../g1/api.dart';
import '../../../g1/g1_helper.dart';
import '../../../g1/g1_v2_helper.dart';
import '../../../g1/nostr/nostr_keys.dart';
import '../../../g1/nostr/nostr_profile.dart';
import '../../../g1/nostr/nostr_relay_service.dart';
import '../../contact_list_item.dart';
import '../../contacts_cache.dart';
import '../../in_dev_helper.dart';
import '../../logger.dart';
import '../../qr_manager.dart';
import '../../ui_helpers.dart';
import '../connectivity_widget_wrapper_wrapper.dart';
import '../contact_menu.dart';
import '../contacts_actions.dart';
import '../custom_error_widget.dart';
import '../loading_box.dart';
import '../third_screen/contacts_page.dart';
import 'contact_fav_icon.dart';

class ContactSearchPage extends StatefulWidget {
  const ContactSearchPage(
      {super.key,
      this.uri,
      required this.searchUse,
      this.startInMultiSelect = false,
      this.isEdit = false,
      this.initialSearch});

  final String? uri;
  final SearchUse searchUse;
  final bool startInMultiSelect;
  final bool isEdit;
  final String? initialSearch;

  @override
  State<ContactSearchPage> createState() => _ContactSearchPageState();
}

class _ContactSearchPageState extends State<ContactSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  String _searchTerm = '';
  String _previousSearchTerm = '';

  List<Contact> _localResults = <Contact>[];
  List<Contact> _networkResults = <Contact>[];
  bool _isLoadingNetwork = false;
  final Set<Contact> _selectedContacts = <Contact>{};
  late bool _isMultiSelect;
  final int minSearchLength = 3;
  late bool _isV2;

  // ── MULTIPASS NOSTR (payment mode only) ────────────────────────────────────
  // When SearchUse.payment, display MULTIPASS profiles from the local NOSTR
  // relay instead of Cesium+ profiles (the two sources are incompatible).
  List<NostrProfile> _allMultipass = <NostrProfile>[];
  List<NostrProfile> _filteredMultipass = <NostrProfile>[];
  bool _multipassLoading = false;

  // Getter for compatibility with existing code
  List<Contact> get _results => <Contact>[..._localResults, ..._networkResults];

  Future<void> _search() async {
    // Trim and remove tabs
    _searchTerm = _searchTerm.replaceAll('\t', ' ');
    _searchTerm = _searchTerm.trim();
    final ContactsCubit contactsCubit = context.read<ContactsCubit>();

    if (_searchTerm.length < minSearchLength) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tr('search_limitation'))),
      );
      return;
    }

    final bool isConnected = await ConnectivityWidgetWrapperWrapper.isConnected;

    // Handle multi-key parsing first
    logger(
        '[MULTI-KEY PARSE] Attempting to parse $_searchTerm (length: ${_searchTerm.length})');
    final Set<Contact> multiContacts = parseMultipleKeys(_searchTerm);
    logger(
        '[MULTI-KEY PARSE] Found ${multiContacts.length} contacts via regex');
    for (final Contact c in multiContacts) {
      logger('[MULTI-KEY PARSE]   - ${c.pubKey}');
    }
    if (multiContacts.isNotEmpty) {
      logger('[MULTI-KEY PARSE] Using multi-key results and returning early');
      setState(() {
        _isMultiSelect = multiContacts.length > 1;
        _localResults = multiContacts.toList();
        _networkResults = <Contact>[];
        _isLoadingNetwork = false;
      });
      return;
    }

    // ⚡ Show local contacts immediately (no waiting for network)
    setState(() {
      _localResults = contactsCubit.search(_searchTerm).toList();
      _networkResults = <Contact>[];
      _isLoadingNetwork = false; // Stop showing loading indicator
      if (inDevelopment) {
        logger('Found: ${_localResults.length} in local contacts');
      }
    });

    // If no connection, stop here with local results
    if (!isConnected) {
      logger(
          '[NO CONNECTION] Validating $_searchTerm (length: ${_searchTerm.length})');
      final bool isV1 = validateKey(_searchTerm);
      final bool isV2 = isValidV2Address(_searchTerm);
      logger('[NO CONNECTION] validateKey($_searchTerm): $isV1');
      logger('[NO CONNECTION] isValidV2Address($_searchTerm): $isV2');

      if (_localResults.isEmpty && isV1) {
        logger(
            '$_searchTerm looks like a plain pub key - Creating Contact(pubKey: ...)');
        setState(() {
          _localResults.add(Contact(pubKey: _searchTerm));
        });
      } else if (_localResults.isEmpty && isV2) {
        logger(
            '$_searchTerm looks like a plain address key - Creating Contact.withAddress(...)');
        setState(() {
          _localResults.add(Contact.withAddress(
            address: _searchTerm,
            createdOn: DateTime.now().millisecondsSinceEpoch,
          ));
        });
      } else if (_localResults.isEmpty) {
        logger(
            '[NO CONNECTION] $_searchTerm is neither valid v1 nor v2 - NO CONTACT CREATED');
      }
      return;
    }

    // ⚡ Perform network searches in PARALLEL using Future.wait()
    setState(() {
      _isLoadingNetwork = true;
    });

    try {
      final List<List<Contact>> results =
          await Future.wait<List<Contact>>(<Future<List<Contact>>>[
        searchProfiles(_searchTerm, quickMode: true),
        searchWot(_searchTerm),
      ]);

      final List<Contact> profileResults = results[0];
      final List<Contact> wotResults = results[1];

      // Build network results with deduplication
      final List<Contact> networkResults = <Contact>[];

      // Add CesiumPlus results
      // ignore: prefer_foreach
      for (final Contact c in profileResults) {
        if (inDevelopment) {
          logger(
              'Adding CesiumPlus result: ${c.pubKey} - ${c.name ?? c.nick ?? "no name"}');
        }
        networkResults.add(c);
      }

      if (inDevelopment) {
        logger('Found: ${networkResults.length} after CesiumPlus search');
      }

      // Add WoT results with deduplication
      // ignore: prefer_foreach
      for (final Contact wotC in wotResults) {
        // Skip if already in network results
        if (!networkResults.any((Contact r) => r.pubKey == wotC.pubKey)) {
          if (inDevelopment) {
            logger(
                'Adding WoT result: ${wotC.pubKey} - ${wotC.name ?? wotC.nick ?? "no name"}');
          }
          networkResults.add(wotC);
        } else if (inDevelopment) {
          logger('Skipping duplicate WoT result: ${wotC.pubKey}');
        }
      }

      // Filter out contacts that are already in local results
      final List<Contact> filteredNetworkResults = networkResults
          .where((Contact nc) =>
              !_localResults.any((Contact lc) => lc.pubKey == nc.pubKey))
          .toList();

      if (inDevelopment) {
        logger(
            'Found: ${filteredNetworkResults.length} total after deduplication');
      }

      // Cache the network results
      if (_isV2) {
        ContactsCache().addAllContacts(filteredNetworkResults);
      } else {
        // ignore: prefer_foreach
        for (final Contact c in filteredNetworkResults) {
          ContactsCache().addContact(c);
        }
      }

      // ⚡ SINGLE UI update with all network results
      setState(() {
        _networkResults = filteredNetworkResults;
        _isLoadingNetwork = false;
      });
    } catch (e) {
      logger('Error in network search: $e');
      // UI maintains local results, graceful degradation
      setState(() {
        _networkResults = <Contact>[];
        _isLoadingNetwork = false;
      });
    }

    // Validate as plain public key or V2 address if no results found anywhere
    logger(
        '[AFTER NETWORK SEARCH] Checking $_searchTerm (length: ${_searchTerm.length})');
    logger(
        '[AFTER NETWORK SEARCH] localResults: ${_localResults.length}, networkResults: ${_networkResults.length}');

    final bool isV1 = validateKey(_searchTerm);
    final bool isV2 = isValidV2Address(_searchTerm);
    logger('[AFTER NETWORK SEARCH] validateKey($_searchTerm): $isV1');
    logger('[AFTER NETWORK SEARCH] isValidV2Address($_searchTerm): $isV2');

    if (_localResults.isEmpty && _networkResults.isEmpty && isV1) {
      logger(
          '$_searchTerm looks like a plain pub key - Creating Contact(pubKey: ...)');
      setState(() {
        _localResults.add(Contact(pubKey: _searchTerm));
      });
    } else if (_localResults.isEmpty && _networkResults.isEmpty && isV2) {
      logger(
          '$_searchTerm looks like a plain address key - Creating Contact.withAddress(...)');
      setState(() {
        _localResults.add(Contact.withAddress(
          address: _searchTerm,
          createdOn: DateTime.now().millisecondsSinceEpoch,
        ));
      });
    } else if (_localResults.isEmpty && _networkResults.isEmpty) {
      logger(
          '[AFTER NETWORK SEARCH] $_searchTerm is neither valid v1 nor v2 - NO CONTACT CREATED');
    }
  }

  /// Build results list with visual separation between local and network results
  Widget _buildResultsList() {
    final bool hasLocalResults = _localResults.isNotEmpty;
    final bool hasNetworkResults = _networkResults.isNotEmpty;
    final bool showNetworkSection = hasNetworkResults;

    // Calculate item count properly
    int itemCount = _localResults.length;

    if (_isLoadingNetwork && _networkResults.isEmpty) {
      // Add separator + loading indicator
      itemCount += 1;
    } else if (showNetworkSection) {
      // Add separator
      itemCount += 1;
      if (hasNetworkResults) {
        // Add network contacts
        itemCount += _networkResults.length;
      } else if (hasLocalResults) {
        // Add "no more results" message only if there are local contacts
        itemCount += 1;
      }
    }

    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (BuildContext context, int index) {
        // Local contacts
        if (index < _localResults.length) {
          return _buildContactTile(context, _localResults[index], index, false);
        }

        final int relativeIndex = index - _localResults.length;

        // Network section separator + content
        if (_isLoadingNetwork && _networkResults.isEmpty) {
          // Show separator and loading indicator
          return Column(
            children: <Widget>[
              ListTile(
                tileColor: Theme.of(context).colorScheme.primaryContainer,
                title: Text(
                  tr('network_results'),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              ),
              const SizedBox(height: 16),
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
            ],
          );
        } else if (showNetworkSection) {
          // First item after local contacts is the separator
          if (relativeIndex == 0) {
            return ListTile(
              tileColor: Theme.of(context).colorScheme.primaryContainer,
              title: Text(
                tr('network_results'),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            );
          }

          // Items after separator
          if (hasNetworkResults) {
            // Network contacts (relativeIndex - 1 because separator is at 0)
            final int networkIndex = relativeIndex - 1;
            if (networkIndex >= 0 && networkIndex < _networkResults.length) {
              return _buildContactTile(
                  context, _networkResults[networkIndex], networkIndex, true);
            }
          } else if (hasLocalResults) {
            // No more results message (only when there are local contacts)
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  tr('no_more_network_results'),
                  style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withAlpha((255.0 * 0.6).round()),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            );
          }
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildContactTile(
      BuildContext context, Contact contact, int index, bool isNetworkResult) {
    return FutureBuilder<Contact>(
        future: _getAndReplaceContact(contact, isNetworkResult),
        builder: (BuildContext context, AsyncSnapshot<Contact> snapshot) {
          Widget widget;
          if (snapshot.hasData) {
            widget = _buildItem(snapshot.data!, index, context);
          } else if (snapshot.hasError) {
            widget = CustomErrorWidget(snapshot.error);
          } else {
            // Contact without wot
            widget = _buildItem(contact, index, context);
          }
          return widget;
        });
  }

  @override
  Widget build(BuildContext context) {
    _isV2 = context.watch<AppCubit>().isV2;

    final bool notForContactPage = widget.searchUse != SearchUse.contactSearch;
    final PaymentCubit paymentCubit = context.read<PaymentCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(widget.searchUse.title())),
        // backgroundColor: Theme.of(context).colorScheme.primary,
        // foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.qr_code_scanner),
              onPressed: () async {
                final String? scannedKey = await QrManager.qrScan(context);
                if (scannedKey is String &&
                    scannedKey != null &&
                    scannedKey != '-1') {
                  final bool back =
                      await _onKeyScanned(scannedKey, paymentCubit);
                  if (!context.mounted) {
                    return;
                  }
                  if (back) {
                    Navigator.pop(context);
                  }
                }
              }),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                focusNode: _searchFocusNode,
                decoration: InputDecoration(
                  // filled: true,
                  border: const OutlineInputBorder(),
                  labelText: tr('search_user'),
                  helperText: _searchTerm.isEmpty
                      ? notForContactPage
                          ? tr('search_user_hint')
                          : tr('search_user_hint_basic')
                      : !_isMultiSelect &&
                              !_isLoadingNetwork &&
                              notForContactPage
                          ? tr('search_multiuser_hint')
                          : null,
                  suffixIcon: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _searchTerm = '';
                          _previousSearchTerm = '';
                          setState(() {
                            _isLoadingNetwork = false;
                            _localResults.clear();
                            _networkResults.clear();
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () => _searchTerm.length < minSearchLength
                            ? null
                            : _search(),
                      ),
                    ],
                  ),
                ),
                onSubmitted: (_) {
                  _search();
                },
                onChanged: (String value) {
                  if (value.length < _previousSearchTerm.length &&
                      value.length < minSearchLength) {
                    _previousSearchTerm = value;
                    setState(() {
                      _isLoadingNetwork = false;
                    });
                    return;
                  }
                  _searchTerm = value;
                  _previousSearchTerm = value;
                  // In payment mode: filter MULTIPASS locally, skip Cesium search
                  if (widget.searchUse == SearchUse.payment) {
                    setState(() {
                      _filteredMultipass = _filterMultipassByQuery(value);
                    });
                    return;
                  }
                  if (_searchTerm.length >= minSearchLength) {
                    // Don't set _isLoadingNetwork = true here; let _search() control it
                    EasyDebounce.debounce('profile_search_debouncer',
                        const Duration(milliseconds: 500), () => _search());
                  }
                },
              )),
          // ── Payment mode: show MULTIPASS from NOSTR relay ──────────────
          if (widget.searchUse == SearchUse.payment)
            Expanded(
              child: _buildMultipassPaymentList(
                  context.read<PaymentCubit>()),
            )
          // ── Other modes: Cesium+ / WoT search ─────────────────────────
          else if (_isLoadingNetwork &&
              _localResults.isEmpty &&
              _networkResults.isEmpty)
            const LoadingBox(simple: false)
          else if (_searchTerm.isNotEmpty &&
              _localResults.isEmpty &&
              _networkResults.isEmpty &&
              !_isLoadingNetwork)
            const NoElements(text: 'nothing_found')
          else if (_results.isNotEmpty)
            Expanded(
              child: _buildResultsList(),
            )
          else
            const Expanded(
              child: NoElements(text: 'nothing_found'),
            )
        ],
      ),
      floatingActionButton:
          _isMultiSelect ? _buildFloatingActionButtons() : null,
    );
  }

  Widget _buildFloatingActionButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FloatingActionButton(
          mini: true,
          onPressed: _selectAll,
          child: const Icon(Icons.checklist_rtl),
        ),
        const SizedBox(height: 10),
        FloatingActionButton(
          mini: true,
          onPressed: _clearSelection,
          child: const Icon(Icons.delete),
        ),
        const SizedBox(height: 10),
        if (_selectedContacts.isNotEmpty)
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              FloatingActionButton(
                mini: true,
                onPressed: _finishSelection,
                child: const Icon(Icons.done),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Text(
                    '${_selectedContacts.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }

  void _selectAll() {
    setState(() {
      _selectedContacts.addAll(_results);
    });
  }

  void _clearSelection() {
    setState(() {
      _selectedContacts.clear();
      _isMultiSelect = false;
    });
  }

  void _finishSelection() {
    context.read<PaymentCubit>().selectUsers(_selectedContacts.toList());
    Navigator.pop(context);
  }

  Future<bool> _onKeyScanned(
      String scannedKey, PaymentCubit paymentCubit) async {
    if (widget.searchUse == SearchUse.contactSearch) {
      return false;
    }
    final PaymentState? pay = parseScannedUri(scannedKey);
    if (pay != null) {
      logger('Scanned $pay');
      _searchTerm = extractPublicKey(pay.contacts[0].pubKey);
      await _search();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(tr('qr_invalid_payment'))));
    }
    logger('QR result length ${_results.length}');
    bool back = false;
    if (_results.length == 1 && pay != null) {
      final Contact contact = _results.first;
      final double? currentAmount = paymentCubit.state.amount;
      // Allow multiselect, so I comment this
      // paymentCubit.selectUser(contact);

      if (pay.amount != null) {
        paymentCubit.selectKeyAmount(contact, pay.amount);
        if (pay.amount! > 0) {
          back = true;
        }
      } else {
        paymentCubit.selectKeyAmount(contact, currentAmount);
        back = false;
      }
      if (pay.comment != null) {
        paymentCubit.setComment(pay.comment);
        if (pay.comment.isNotEmpty) {
          back = true;
        }
      }
    } else if (_results.isEmpty) {
      if (!mounted) {
        return false;
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(tr('cant_find_qr_contact'))));
    }
    if (!_isMultiSelect) {
      return back;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchFocusNode.requestFocus();
    });
    _handleUri(widget.uri);
    _isMultiSelect = widget.startInMultiSelect;
    final PaymentCubit paymentCubit = context.read<PaymentCubit>();
    if (widget.isEdit) {
      _selectedContacts.addAll(paymentCubit.contacts);
      _results.addAll(paymentCubit.contacts);
    }
    if (widget.initialSearch?.isNotEmpty ?? false) {
      _searchTerm = widget.initialSearch!;
      _searchController.text = widget.initialSearch!;
      _search();
    }
    // In payment mode: pre-load MULTIPASS profiles from the local NOSTR relay
    // instead of relying on Cesium+ (incompatible with V2 MULTIPASS keys).
    if (widget.searchUse == SearchUse.payment) {
      _loadMultipassProfiles();
    }
  }

  Future<void> _loadMultipassProfiles() async {
    if (_multipassLoading) return;
    setState(() => _multipassLoading = true);
    try {
      final NostrRelayService relay = NostrRelayService();
      if (!relay.isConnected) {
        if (mounted) setState(() => _multipassLoading = false);
        return;
      }
      final List<NostrProfile> profiles =
          await relay.fetchAllMultipassProfiles();
      if (mounted) {
        setState(() {
          _allMultipass = profiles;
          _filteredMultipass =
              _filterMultipassByQuery(_searchController.text);
          _multipassLoading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _multipassLoading = false);
    }
  }

  List<NostrProfile> _filterMultipassByQuery(String q) {
    if (q.isEmpty) return List<NostrProfile>.from(_allMultipass);
    final String lower = q.toLowerCase();
    return _allMultipass.where((NostrProfile p) {
      return p.name.toLowerCase().contains(lower) ||
          (p.city?.toLowerCase().contains(lower) ?? false) ||
          (p.email?.toLowerCase().contains(lower) ?? false) ||
          (p.g1pub?.toLowerCase().contains(lower) ?? false);
    }).toList();
  }

  Widget _buildMultipassPaymentList(PaymentCubit paymentCubit) {
    if (_multipassLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    final List<NostrProfile> visible = _filteredMultipass;
    if (visible.isEmpty) {
      return Center(child: Text(tr('contacts_nostr_empty')));
    }
    return ListView.builder(
      itemCount: visible.length,
      itemBuilder: (BuildContext ctx, int i) {
        final NostrProfile p = visible[i];
        final String g1pub = p.g1pub ?? '';
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: p.picture != null && p.picture!.isNotEmpty
                ? NetworkImage(p.picture!)
                : null,
            onBackgroundImageError: (_, __) {},
            child: p.picture == null || p.picture!.isEmpty
                ? Text(
                    p.name.isNotEmpty ? p.name[0].toUpperCase() : '?',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )
                : null,
          ),
          title: Text(p.name, overflow: TextOverflow.ellipsis),
          subtitle: Text(
            <String>[
              if (p.city?.isNotEmpty ?? false) p.city!,
              if (p.email?.isNotEmpty ?? false) p.email!,
            ].join(' · '),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12),
          ),
          onTap: (g1pub.isNotEmpty || (p.g1v2?.isNotEmpty ?? false))
              ? () {
                  // Attach nostrHex pour le fallback kind-7 au paiement.
                  String? nostrHex;
                  if (p.npub.isNotEmpty) {
                    try {
                      nostrHex = NostrKeys.npubToHex(p.npub);
                    } catch (_) {}
                  }
                  // Priorité: g1v2 (SS58) > g1pub validé SS58 > g1pub v1 base58.
                  final String? g1v2 = p.g1v2;
                  Contact contact;
                  if (g1v2 != null && g1v2.isNotEmpty) {
                    contact = Contact.withAddress(
                      address: g1v2,
                      createdOn: DateTime.now().millisecondsSinceEpoch,
                    );
                  } else if (isValidV2Address(g1pub)) {
                    contact = Contact.withAddress(
                      address: g1pub,
                      createdOn: DateTime.now().millisecondsSinceEpoch,
                    );
                  } else {
                    // g1pub est une pubkey v1 base58 (anciens profils MULTIPASS)
                    contact = Contact(
                      pubKey: g1pub,
                      createdOn: DateTime.now().millisecondsSinceEpoch,
                    );
                  }
                  if (nostrHex != null) {
                    contact = contact.copyWith(nostrHex: nostrHex);
                  }
                  paymentCubit.selectUser(contact);
                  Navigator.pop(context);
                }
              : null,
        );
      },
    );
  }

  Future<void> _handleUri(String? uri) async {
    if (uri != null) {
      final PaymentCubit paymentCubit = context.read<PaymentCubit>();
      final bool back = await _onKeyScanned(uri, paymentCubit);
      if (mounted) {
        if (back) {
          Navigator.pop(context);
        }
      }
    }
  }

  Widget _buildItem(Contact contact, int index, BuildContext context) {
    final Widget? subtitle =
        contact.subtitle != null ? Text(contact.subtitle!) : null;
    final List<String> ids =
        _selectedContacts.map((Contact c) => c.pubKey).toList();
    return _isMultiSelect
        ? CheckboxListTile(
            title: Text(contact.title),
            subtitle: subtitle ?? Container(),
            tileColor: tileColor(index, context),
            value: ids.contains(contact.pubKey),
            onChanged: (bool? checked) {
              setState(() {
                if (checked != null && checked) {
                  _selectedContacts.add(contact);
                } else {
                  _selectedContacts.remove(contact);
                }
              });
            },
            secondary: avatar(
              contact,
              bgColor: tileColor(index, context),
              color: tileColor(index, context, true),
            ),
          )
        : ContactListItem(
            contact: contact,
            index: index,
            isV2: _isV2,
            onLongPress: () {
              if (widget.searchUse == SearchUse.contactSearch) {
                return;
              }
              setState(() {
                _isMultiSelect = true;
                _selectedContacts.add(contact);
              });
            },
            onTap: () {
              if (widget.searchUse == SearchUse.payment) {
                context.read<PaymentCubit>().selectUser(contact);
                context.read<BottomNavCubit>().updateIndex(0);
                Navigator.pop(context);
              } else if (widget.searchUse == SearchUse.contactSearch) {
                showContactPage(context, contact);
              }
            },
            trailing: BlocBuilder<ContactsCubit, ContactsState>(
                builder: (BuildContext context, ContactsState state) {
              return widget.searchUse == SearchUse.payment
                  ? ContactFavIcon(
                      contact: contact,
                      contactsCubit: context.read<ContactsCubit>())
                  : widget.searchUse == SearchUse.contactSearch
                      ? ContactMenu(
                          contact: contact,
                          onEdit: () => onEditContact(context, contact),
                          onSent: () => onSentContact(context, contact),
                          onCopy: () => onShowContactQr(context, contact),
                          onDelete: () => onDeleteContact(context, contact))
                      : Container();
            }),
          );
  }

  Future<Contact> _getAndReplaceContact(Contact contact,
      [bool isNetworkResult = false]) async {
    Contact enrichedContact = await ContactsCache().getContact(contact.pubKey);

    // Preserve createdOn from original contact if enriched contact doesn't have it
    if (contact.createdOn != null && enrichedContact.createdOn == null) {
      enrichedContact = enrichedContact.copyWith(createdOn: contact.createdOn);
    }

    // Find and replace the contact by pubKey in the appropriate list
    final List<Contact> targetList =
        isNetworkResult ? _networkResults : _localResults;
    final int index =
        targetList.indexWhere((Contact c) => c.pubKey == contact.pubKey);
    if (index >= 0) {
      targetList[index] = enrichedContact;
    }

    final Contact? selectedContact = _selectedContacts
        .toList()
        .firstWhereOrNull((Contact c) => c.pubKey == contact.pubKey);

    if (selectedContact != null) {
      _selectedContacts.remove(selectedContact);
      _selectedContacts.add(enrichedContact);
    }

    return enrichedContact;
  }
}

enum SearchUse {
  payment,
  contactSearch,
  marketAnalysis;

  String title() {
    switch (this) {
      case payment:
        return 'search_user_title';
      case contactSearch:
        return 'search_user_title_in_contacts';
      case marketAnalysis:
        return 'search_user_title_in_analysis';
    }
  }
}
