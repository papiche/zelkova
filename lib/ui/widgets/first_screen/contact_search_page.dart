import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:http/http.dart';

import '../../../data/models/contact.dart';
import '../../../data/models/contact_cubit.dart';
import '../../../data/models/contact_state.dart';
import '../../../data/models/payment_cubit.dart';
import '../../../data/models/payment_state.dart';
import '../../../g1/api.dart';
import '../../../g1/g1_helper.dart';
import '../../contacts_cache.dart';
import '../../logger.dart';
import '../../nfc_helper.dart';
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
  const ContactSearchPage({super.key, this.uri, this.forPayment = true});

  final String? uri;
  final bool forPayment;

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
  bool _isMultiSelect = false;

  Future<void> _search() async {
    final ContactsCubit contactsCubit = context.read<ContactsCubit>();
    if (_searchTerm.length < 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tr('search_limitation'))),
      );
      return;
    }

    final bool isConnected = await ConnectivityWidgetWrapperWrapper.isConnected;
    setState(() {
      _isLoading = true;
    });

    final List<Contact> multiContacts = parseMultipleKeys(_searchTerm);
    if (multiContacts.length > 1) {
      setState(() {
        _isMultiSelect = true;
        _results = multiContacts;
        _isLoading = false;
        // _searchController.clear();
        // _searchTerm = '';
      });
      return;
    }

    setState(() {
      _results = contactsCubit.search(_searchTerm);
      if (inDevelopment) {
        logger('Found: ${_results.length} in contacts');
      }
    });

    if (isConnected) {
      final Response cPlusResponse = await searchCPlusUser(_searchTerm);
      if (cPlusResponse.statusCode != 404) {
        // Add cplus users
        final List<dynamic> hits = ((const JsonDecoder()
                .convert(cPlusResponse.body) as Map<String, dynamic>)['hits']
            as Map<String, dynamic>)['hits'] as List<dynamic>;
        for (final dynamic hit in hits) {
          final Contact c = await contactFromResultSearch(
            hit as Map<String, dynamic>,
          );
          logger('Contact retrieved in c+ search $c');
          ContactsCache().addContact(c);
          setState(() {
            _addIfNotPresent(c);
          });
        }
        logger('Found: ${_results.length}');
      }
    }

    if (isConnected) {
      if (_searchTerm.length >= 8) {
        // Only search wot if it's a long key
        final List<Contact> wotResults = await searchWotV1(_searchTerm);
        // ignore: prefer_foreach
        for (final Contact c in wotResults) {
          ContactsCache().addContact(c);
          _addIfNotPresent(c);
          // retrieve extra results with c+ profile
          for (final Contact wotC in wotResults) {
            final Contact cachedWotProfile =
                await ContactsCache().getContact(wotC.pubKey);
            if (cachedWotProfile.name == null) {
              // Users without c+ profile
              final Contact cPlusProfile = await getProfile(
                  cachedWotProfile.pubKey,
                  onlyCPlusProfile: true);
              ContactsCache().addContact(cPlusProfile);
            }
          }
        }
      }
    }

    if (_results.isEmpty && validateKey(_searchTerm)) {
      logger('$_searchTerm looks like a plain pub key');
      setState(() {
        final Contact contact = Contact(pubKey: _searchTerm);
        _results.add(contact);
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _addIfNotPresent(Contact contact) {
    if (_results
        .where((Contact c) => c.pubKey == contact.pubKey)
        .toList()
        .isEmpty) {
      _results.add(contact);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<NFCAvailability>(
        future: FlutterNfcKit.nfcAvailability,
        builder:
            (BuildContext context, AsyncSnapshot<NFCAvailability> snapshot) {
          final bool nft = hasNft(snapshot);

          final PaymentCubit paymentCubit = context.read<PaymentCubit>();
          final bool forPayment = widget.forPayment;
          return Scaffold(
            appBar: AppBar(
              title: Text(forPayment
                  ? tr('search_user_title')
                  : tr('search_user_title_in_contacts')),
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.inversePrimary,
              actions: <Widget>[
                if (nft)
                  IconButton(
                    icon: const Icon(Icons.nfc),
                    onPressed: () async {
                      final String? nfcUrl = await readNfcUrl();
                      if (nfcUrl is String &&
                          nfcUrl != null &&
                          nfcUrl != '-1') {
                        final bool back =
                            await _onKeyScanned(nfcUrl, paymentCubit);
                        if (!context.mounted) {
                          return;
                        }
                        if (back) {
                          Navigator.pop(context);
                        }
                      }
                    },
                  ),
                IconButton(
                    icon: const Icon(Icons.qr_code_scanner),
                    onPressed: () async {
                      final String? scannedKey =
                          await QrManager.qrScan(context);
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
                        filled: true,
                        labelText: tr('search_user'),
                        helperText: _searchTerm.isEmpty
                            ? forPayment
                                ? tr('search_user_hint')
                                : tr('search_user_hint_basic')
                            : !_isMultiSelect && !_isLoading && forPayment
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
                              onPressed: () =>
                                  _searchTerm.length < 3 ? null : _search(),
                            ),
                          ],
                        ),
                      ),
                      onSubmitted: (_) {
                        _search();
                      },
                      onChanged: (String value) {
                        if (value.length < _previousSearchTerm.length &&
                            value.length < 3) {
                          _previousSearchTerm = value;
                          setState(() {
                            _isLoading = false;
                          });
                          return;
                        }
                        _searchTerm = value;
                        _previousSearchTerm = value;
                        if (_searchTerm.length >= 3) {
                          setState(() {
                            _isLoading = true;
                          });
                          EasyDebounce.debounce(
                              'profile_search_debouncer',
                              const Duration(milliseconds: 500),
                              () => _search());
                        }
                      },
                    )),
                if (_isLoading)
                  const LoadingBox(simple: false)
                else if (_searchTerm.isNotEmpty &&
                    _results.isEmpty &&
                    _isLoading)
                  const NoElements(text: 'nothing_found')
                else
                  Expanded(
                    child: ListView.builder(
                        itemCount: _results.length,
                        itemBuilder: (BuildContext context, int index) {
                          final Contact contact = _results[index];
                          return FutureBuilder<Contact>(
                              future: _getAndReplaceContact(contact),
                              builder: (BuildContext context,
                                  AsyncSnapshot<Contact> snapshot) {
                                Widget widget;
                                if (snapshot.hasData) {
                                  widget = _buildItem(
                                      snapshot.data!, index, context);
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
              ],
            ),
            floatingActionButton:
                _isMultiSelect ? _buildFloatingActionButtons() : null,
          );
        });
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
    if (!widget.forPayment) {
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
      final Contact contact = _results[0];
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
              contact.avatar,
              bgColor: tileColor(index, context),
              color: tileColor(index, context, true),
            ),
          )
        : contactToListItem(
            contact,
            index,
            context,
            onLongPress: () {
              setState(() {
                _isMultiSelect = true;
                _selectedContacts.add(contact);
              });
            },
            onTap: () {
              context.read<PaymentCubit>().selectUser(contact);
              Navigator.pop(context);
            },
            trailing: BlocBuilder<ContactsCubit, ContactsState>(
                builder: (BuildContext context, ContactsState state) {
              return widget.forPayment
                  ? ContactFavIcon(
                      contact: contact,
                      contactsCubit: context.read<ContactsCubit>())
                  : ContactMenu(
                      contact: contact,
                      onEdit: () => onEditContact(context, contact),
                      onSent: () => onSentContact(context, contact),
                      onCopy: () => onShowContactQr(context, contact),
                      onDelete: () => onDeleteContact(context, contact));
            }),
          );
  }

  Future<Contact> _getAndReplaceContact(Contact contact) async {
    final Contact enrichedContact =
        await ContactsCache().getContact(contact.pubKey);

    final int resultIndex =
        _results.indexWhere((Contact c) => c.pubKey == contact.pubKey);
    if (resultIndex != -1) {
      _results[resultIndex] = enrichedContact;
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
