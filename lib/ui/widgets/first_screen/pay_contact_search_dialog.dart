import 'dart:convert';
import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:simple_barcode_scanner/enum.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import '../../../cubit/bottom_nav_cubit.dart';
import '../../../data/models/contact.dart';
import '../../../data/models/contact_cubit.dart';
import '../../../data/models/contact_state.dart';
import '../../../data/models/node_list_cubit.dart';
import '../../../data/models/payment_cubit.dart';
import '../../../data/models/payment_state.dart';
import '../../../g1/api.dart';
import '../../../g1/g1_helper.dart';
import '../../../main.dart';
import '../../ui_helpers.dart';
import '../loading_box.dart';
import '../third_screen/contacts_page.dart';

class SearchDialog extends StatefulWidget {
  const SearchDialog({super.key});

  @override
  State<SearchDialog> createState() => _SearchDialogState();
}

class _SearchDialogState extends State<SearchDialog> {
  final TextEditingController _searchController = TextEditingController();
  String _searchTerm = '';

  List<Contact> _results = <Contact>[];
  bool _isLoading = false;

  Future<void> _search(NodeListCubit cubit) async {
    setState(() {
      _isLoading = true;
    });

    final Response response = await searchUser(_searchTerm);
    if (response.statusCode == 404) {
      _results = <Contact>[];
      if (validateKey(_searchTerm)) {
        // looks like a plain pub key
        final Contact contact = Contact(pubkey: _searchTerm);
        _results.add(contact);
      }
      setState(() {
        _isLoading = false;
      });
    } else {
      _results = (((const JsonDecoder().convert(response.body)
                  as Map<String, dynamic>)['hits']
              as Map<String, dynamic>)['hits'] as List<dynamic>)
          .map((dynamic e) {
        final Contact c = _contactFromResult(e as Map<String, dynamic>);
        logger('Contact retrieved in search $c');
        return c;
      }).toList();
      logger('Found: ${_results.length}');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final NodeListCubit nodeListCubit = context.read<NodeListCubit>();
    final PaymentCubit paymentCubit = context.read<PaymentCubit>();
    final BottomNavCubit nav = context.read<BottomNavCubit>();
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
                  PaymentState? pay = parseScannedUri(scannedKey);
                  await _search(nodeListCubit);
                  if (_results.length == 1 && pay != null) {
                    final Contact contact = _results[0];
                    pay = pay.copyWith(
                        nick: contact.name, avatar: contact.avatar);
                  }
                  if (pay!.amount != null) {
                    paymentCubit.selectKeyAmount(pay.publicKey, pay.amount!);
                  } else {
                    paymentCubit.selectKey(pay.publicKey);
                  }
                  nav.updateIndex(0);
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
                    _search(nodeListCubit);
                  },
                ),
              ),
              onChanged: (String value) {
                setState(() {
                  _searchTerm = value;
                });
              },
              onSubmitted: (_) {
                _search(nodeListCubit);
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
                      // FIMXE final String nick = _getNick(currentIndex);
                      final String nick = contact.name ?? contact.pubkey;
                      final String pubKey = contact.pubkey;
                      return FutureBuilder<Contact>(
                          future: getWot(contact),
                          builder: (BuildContext context,
                              AsyncSnapshot<Contact> snapshot) {
                            Widget widget;
                            if (snapshot.hasData) {
                              widget = _buildItem(
                                  snapshot.data!, nick, index, context, pubKey);
                            } else if (snapshot.hasError) {
                              widget = Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Text('Error: ${snapshot.error}'),
                              );
                            } else {
                              // Contact without wot
                              widget = _buildItem(
                                  contact, nick, index, context, pubKey);
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

  Widget _buildItem(Contact contact, String nick, int index,
      BuildContext context, String pubKey) {
    logger('Contact retrieved ${contact}');
    final bool hasAvatar = contact.avatar != null;
    return ListTile(
      title: Text(nick),
      tileColor: tileColor(index),
      onTap: () {
        context
            .read<PaymentCubit>()
            .selectUser(pubKey, nick, hasAvatar ? contact.avatar : null);
        Navigator.pop(context);
      },
      leading: avatar(
        hasAvatar,
        hasAvatar ? contact.avatar : null,
        bgColor: tileColor(index, true),
        color: tileColor(index),
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

    return widget;
  }

  Contact _contactFromResult(Map<String, dynamic> record) {
    final Map<String, dynamic> source =
        record['_source'] as Map<String, dynamic>;
    final Map<String, dynamic> avatar =
        source['avatar'] as Map<String, dynamic>;
    final Uint8List avatarBase64 = imageFromBase64String(
        'data:${avatar['_content_type']};base64,${avatar['_content']}');
    return Contact(
        pubkey: record['_id'] as String,
        name: source['title'] as String,
        avatar: avatarBase64);
  }
}
