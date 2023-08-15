import 'dart:convert';

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
  String _searchTerm = '';

  List<Contact> _results = <Contact>[];
  bool _isLoading = false;

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
          final Contact c =
              await contactFromResultSearch(hit as Map<String, dynamic>);
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
      final List<Contact> wotResults = await searchWot(_searchTerm);
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
            final Contact cPlusProfile =
                await getProfile(cachedWotProfile.pubKey, true);
            ContactsCache().addContact(cPlusProfile);
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
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.forPayment
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
                        await _onKeyScanned(nfcUrl, paymentCubit);
                        if (!mounted) {
                          return;
                        }
                        Navigator.pop(context);
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
                        await _onKeyScanned(scannedKey, paymentCubit);
                        if (!mounted) {
                          return;
                        }
                        Navigator.pop(context);
                      }
                    }),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      filled: true,
                      //fillColor: Colors.white,
                      labelText: tr('search_user'),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () =>
                            _searchTerm.length < 3 ? null : _search(),
                      ),
                    ),
                    onChanged: (String value) {
                      _searchTerm = value;
                    },
                    onSubmitted: (_) {
                      _search();
                    },
                  ),
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
                                future:
                                    ContactsCache().getContact(contact.pubKey),
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
                                    widget =
                                        _buildItem(contact, index, context);
                                  }
                                  return widget;
                                });
                          }),
                    )
                ],
              ),
            ),
          );
        });
  }

  Future<void> _onKeyScanned(
      String scannedKey, PaymentCubit paymentCubit) async {
    if (!widget.forPayment) {
      return;
    }
    final PaymentState? pay = parseScannedUri(scannedKey);
    if (pay != null) {
      logger('Scanned $pay');
      _searchTerm = extractPublicKey(pay.contact!.pubKey);
      await _search();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(tr('qr_invalid_payment'))));
    }
    logger('QR result length ${_results.length}');
    if (_results.length == 1 && pay != null) {
      final Contact contact = _results[0];
      final double? currentAmount = paymentCubit.state.amount;
      paymentCubit.selectUser(contact);
      if (pay.amount != null) {
        paymentCubit.selectKeyAmount(contact, pay.amount);
      } else {
        paymentCubit.selectKeyAmount(contact, currentAmount);
      }
      if (pay.comment != null) {
        paymentCubit.setComment(pay.comment);
      }
    } else if (_results.isEmpty) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(tr('cant_find_qr_contact'))));
    }
  }

  @override
  void initState() {
    super.initState();
    _handleUri(widget.uri);
  }

  Future<void> _handleUri(String? uri) async {
    if (uri != null) {
      final PaymentCubit paymentCubit = context.read<PaymentCubit>();
      await _onKeyScanned(uri, paymentCubit);
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  Widget _buildItem(Contact contact, int index, BuildContext context) {
    return contactToListItem(
      contact,
      index,
      context,
      onTap: () {
        context.read<PaymentCubit>().selectUser(contact);
        Navigator.pop(context);
      },
      trailing: BlocBuilder<ContactsCubit, ContactsState>(
          builder: (BuildContext context, ContactsState state) {
        return ContactFavIcon(
            contact: contact, contactsCubit: context.read<ContactsCubit>());
      }),
    );
  }
}
