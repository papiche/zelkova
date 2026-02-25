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

  List<Contact> _results = <Contact>[];
  bool _isLoading = false;
  final Set<Contact> _selectedContacts = <Contact>{};
  late bool _isMultiSelect;
  final int minSearchLength = 3;
  late bool _isV2;

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
    final Set<Contact> multiContacts = parseMultipleKeys(_searchTerm);
    if (multiContacts.isNotEmpty) {
      setState(() {
        _isMultiSelect = multiContacts.length > 1;
        _results = multiContacts.toList();
        _isLoading = false;
      });
      return;
    }

    // ⚡ Show local contacts immediately (no waiting for network)
    setState(() {
      _results = contactsCubit.search(_searchTerm).toList();
      _isLoading = false; // Stop showing loading indicator
      if (inDevelopment) {
        logger('Found: ${_results.length} in local contacts');
      }
    });

    // If no connection, stop here with local results
    if (!isConnected) {
      if (_results.isEmpty && validateKey(_searchTerm)) {
        logger('$_searchTerm looks like a plain pub key');
        setState(() {
          _results.add(Contact(pubKey: _searchTerm));
        });
      } else if (_results.isEmpty && isValidV2Address(_searchTerm)) {
        logger('$_searchTerm looks like a plain address key');
        setState(() {
          _results.add(Contact.withAddress(
            address: _searchTerm,
            createdOn: DateTime.now().millisecondsSinceEpoch,
          ));
        });
      }
      return;
    }

    // ⚡ Perform network searches in PARALLEL using Future.wait()
    try {
      final List<List<Contact>> results = await Future.wait<List<Contact>>([
        searchProfiles(_searchTerm, quickMode: true),
        searchWot(_searchTerm),
      ]);

      final List<Contact> profileResults = results[0];
      final List<Contact> wotResults = results[1];

      // Add CesiumPlus results
      // ignore: prefer_foreach
      for (final Contact c in profileResults) {
        if (inDevelopment) {
          logger(
              'Adding CesiumPlus result: ${c.pubKey} - ${c.name ?? c.nick ?? "no name"}');
        }
        _addIfNotPresent(c);
      }

      if (inDevelopment) {
        logger('Found: ${_results.length} after CesiumPlus search');
      }

      // Process WoT results based on version
      if (_isV2) {
        // V2: optimized search
        ContactsCache().addAllContacts(wotResults);
        // ignore: prefer_foreach
        for (final Contact wotC in wotResults) {
          if (inDevelopment) {
            logger(
                'Adding WoT result: ${wotC.pubKey} - ${wotC.name ?? wotC.nick ?? "no name"}');
          }
          _addIfNotPresent(wotC);
        }

        // Enrich profiles in the BACKGROUND (non-blocking)
        // This happens AFTER results are displayed
        unawaited(_enrichProfilesInBackground(wotResults, isV2: true));
      } else {
        // V1: standard search
        // ignore: prefer_foreach
        for (final Contact c in wotResults) {
          ContactsCache().addContact(c);
          _addIfNotPresent(c);
        }

        // Enrich profiles in the BACKGROUND (non-blocking)
        unawaited(_enrichProfilesInBackground(wotResults));
      }

      // ⚡ SINGLE UI update with all network results
      setState(() {
        if (inDevelopment) {
          logger('Found: ${_results.length} total after network search');
        }
      });
    } catch (e) {
      logger('Error in network search: $e');
      // UI maintains local results, graceful degradation
    }

    // Validate as plain public key or V2 address if no results found
    if (_results.isEmpty && validateKey(_searchTerm)) {
      logger('$_searchTerm looks like a plain pub key');
      setState(() {
        _results.add(Contact(pubKey: _searchTerm));
      });
    } else if (_results.isEmpty && isValidV2Address(_searchTerm)) {
      logger('$_searchTerm looks like a plain address key');
      setState(() {
        _results.add(Contact.withAddress(
          address: _searchTerm,
          createdOn: DateTime.now().millisecondsSinceEpoch,
        ));
      });
    }
  }

  void _addIfNotPresent(Contact contact) {
    if (_results
        .where((Contact c) => c.pubKey == contact.pubKey)
        .toList()
        .isEmpty) {
      _results.add(contact);
    } else if (inDevelopment) {
      logger('Skipping duplicate: ${contact.pubKey}');
    }
  }

  /// Enrich WoT search results with C+ profiles in the background (non-blocking)
  /// This allows results to display immediately while profile enrichment happens async
  /// Does NOT call setState - enriched data is only cached for future searches
  Future<void> _enrichProfilesInBackground(List<Contact> wotResults,
      {bool isV2 = false}) async {
    try {
      if (widget.searchUse == SearchUse.payment) {
        // Skip enrichment for payment search - just use WoT results
        return;
      }

      if (isV2) {
        // V2: batch fetch profiles and cache them
        // This happens in background, UI won't re-render
        final List<Contact> contactsWithProfiles = await getProfiles(
          wotResults.map((Contact c) => c.pubKey).toList(),
        );
        ContactsCache().addAllContacts(contactsWithProfiles);
        // Data is cached but UI doesn't update - that's intentional
        // Results are already shown, enrichment is just for cache
      } else {
        // V1: fetch profiles individually and cache
        // This happens in background, UI won't re-render
        for (final Contact wotC in wotResults) {
          final Contact cachedWotProfile =
              await ContactsCache().getContact(wotC.pubKey);
          if (cachedWotProfile.name == null) {
            // Users without C+ profile
            try {
              final Contact cPlusProfile = await getProfile(
                cachedWotProfile.pubKey,
                onlyProfile: true,
                complete: false,
              );
              ContactsCache().addContact(cPlusProfile);
              // Data is cached but UI doesn't update - that's intentional
            } catch (e) {
              loggerDev(
                  'Error fetching C+ profile for ${cachedWotProfile.pubKey}: $e');
            }
          }
        }
      }
    } catch (e) {
      loggerDev('Error in background profile enrichment: $e');
    }
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
                      : !_isMultiSelect && !_isLoading && notForContactPage
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
                            _isLoading = false;
                            _results.clear();
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
                      _isLoading = false;
                    });
                    return;
                  }
                  _searchTerm = value;
                  _previousSearchTerm = value;
                  if (_searchTerm.length >= minSearchLength) {
                    // Don't set _isLoading = true here; let _search() control it
                    EasyDebounce.debounce('profile_search_debouncer',
                        const Duration(milliseconds: 500), () => _search());
                  }
                },
              )),
          if (_isLoading && _results.isEmpty)
            const LoadingBox(simple: false)
          else if (_searchTerm.isNotEmpty && _results.isEmpty && !_isLoading)
            const NoElements(text: 'nothing_found')
          else if (_results.isNotEmpty)
            Expanded(
              child: ListView.builder(
                  itemCount: _results.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Contact contact = _results.toList()[index];
                    return FutureBuilder<Contact>(
                        future: _getAndReplaceContact(contact),
                        builder: (BuildContext context,
                            AsyncSnapshot<Contact> snapshot) {
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
                  }),
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

  Future<Contact> _getAndReplaceContact(Contact contact) async {
    Contact enrichedContact = await ContactsCache().getContact(contact.pubKey);

    // Preserve createdOn from original contact if enriched contact doesn't have it
    if (contact.createdOn != null && enrichedContact.createdOn == null) {
      enrichedContact = enrichedContact.copyWith(createdOn: contact.createdOn);
    }

    // Find and replace the contact by pubKey (not by reference)
    final int index =
        _results.indexWhere((Contact c) => c.pubKey == contact.pubKey);
    if (index >= 0) {
      _results[index] = enrichedContact;
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
