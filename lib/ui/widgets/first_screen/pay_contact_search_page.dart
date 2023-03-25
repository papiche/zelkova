import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:simple_barcode_scanner/enum.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import '../../../data/models/contact.dart';
import '../../../data/models/contact_cubit.dart';
import '../../../data/models/contact_state.dart';
import '../../../data/models/payment_cubit.dart';
import '../../../data/models/payment_state.dart';
import '../../../g1/api.dart';
import '../../../g1/g1_helper.dart';
import '../../logger.dart';
import '../../ui_helpers.dart';
import '../custom_error_widget.dart';
import '../loading_box.dart';
import '../third_screen/contacts_page.dart';

class PayContactSearchPage extends StatefulWidget {
  const PayContactSearchPage({super.key});

  @override
  State<PayContactSearchPage> createState() => _PayContactSearchPageState();
}

class _PayContactSearchPageState extends State<PayContactSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchTerm = '';

  List<Contact> _results = <Contact>[];
  bool _isLoading = false;

  Future<void> _search() async {
    setState(() {
      _isLoading = true;
    });

    final Response cPlusResponse = await searchCPlusUser(_searchTerm);
    if (cPlusResponse.statusCode == 404) {
      setState(() {
        _results = <Contact>[];
      });
    } else {
      _results = await searchWot(_searchTerm);
      // FIXME(vjrj) ... no avatars in wot!
      setState(() {
        // Add cplus users
        final List<dynamic> hits = ((const JsonDecoder()
                .convert(cPlusResponse.body) as Map<String, dynamic>)['hits']
            as Map<String, dynamic>)['hits'] as List<dynamic>;
        for (final dynamic hit in hits) {
          final Contact c =
              contactFromResultSearch(hit as Map<String, dynamic>);
          logger('Contact retrieved in search $c');
          _results.add(c);
        }
        logger('Found: ${_results.length}');
        _isLoading = false;
      });
    }
    if (_results.isEmpty && validateKey(_searchTerm)) {
      logger('$_searchTerm looks like a plain pub key');
      setState(() {
        _isLoading = true;
        final Contact contact = Contact(pubkey: _searchTerm);
        _results.add(contact);
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final PaymentCubit paymentCubit = context.read<PaymentCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('search_user_title')),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.qr_code_scanner),
              onPressed: () async {
                final String? scannedKey = await Navigator.push(
                    context,
                    MaterialPageRoute<String>(
                      builder: (BuildContext context) =>
                          SimpleBarcodeScannerPage(
                              scanType: ScanType.qr,
                              appBarTitle: tr('qr-scanner-title'),
                              cancelButtonText: tr('close')),
                    ));
                if (scannedKey is String &&
                    scannedKey != null &&
                    scannedKey != '-1') {
                  final PaymentState? pay = parseScannedUri(scannedKey);
                  if (pay != null) {
                    logger('Scanned $pay');
                    _searchTerm = pay.publicKey;
                    await _search();
                  }
                  logger('QR result length ${_results.length}');
                  if (_results.length == 1 && pay != null) {
                    final Contact contact = _results[0];
                    paymentCubit.selectUser(
                        contact.pubkey,
                        contact.nick ?? contact.name,
                        contact.avatar,
                        pay.amount);
                  } else if (pay!.amount != null) {
                    paymentCubit.selectKeyAmount(pay.publicKey, pay.amount!);
                  } else {
                    paymentCubit.selectKey(pay.publicKey);
                  }
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
                fillColor: Colors.white,
                labelText: tr('search_user'),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    _search();
                  },
                ),
              ),
              onChanged: (String value) {
                setState(() {
                  _searchTerm = value;
                });
              },
              onSubmitted: (_) {
                _search();
              },
            ),
            if (_isLoading)
              const LoadingBox()
            else if (_searchTerm.isNotEmpty && _results.isEmpty && _isLoading)
              const NoElements(text: 'nothing_found')
            else
              Expanded(
                child: ListView.builder(
                    itemCount: _results.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Contact contact = _results[index];
                      return FutureBuilder<Contact>(
                          future: getWot(contact),
                          builder: (BuildContext context,
                              AsyncSnapshot<Contact> snapshot) {
                            Widget widget;
                            if (snapshot.hasData) {
                              widget =
                                  _buildItem(snapshot.data!, index, context);
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
      ),
    );
  }

  Widget _buildItem(Contact contact, int index, BuildContext context) {
    logger('Contact retrieved $contact');
    final String pubKey = contact.pubkey;
    final String title = contact.nick ?? contact.name ?? humanizePubKey(pubKey);
    final Widget? subtitle = (contact.nick != null || contact.name != null)
        ? Text(humanizePubKey(pubKey))
        : null;
    final bool hasAvatar = contact.avatar != null;
    return ListTile(
      title: Text(title),
      subtitle: subtitle,
      tileColor: tileColor(index, context),
      onTap: () {
        context.read<PaymentCubit>().selectUser(pubKey,
            contact.nick ?? contact.name, hasAvatar ? contact.avatar : null);
        Navigator.pop(context);
      },
      leading: avatar(
        contact.avatar,
        bgColor: tileColor(index, context),
        color: tileColor(index, context, true),
      ),
      trailing: BlocBuilder<ContactsCubit, ContactsState>(
          builder: (BuildContext context, ContactsState state) {
        final ContactsCubit contactsCubit = context.read<ContactsCubit>();
        final bool isFavorite = contactsCubit.isContact(pubKey);
        return IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red.shade400 : null,
            ),
            onPressed: () {
              setState(() {
                if (!isFavorite) {
                  contactsCubit.addContact(contact);
                } else {
                  contactsCubit.removeContact(Contact(
                    pubkey: pubKey,
                  ));
                }
              });
            });
      }),
    );
  }
}
