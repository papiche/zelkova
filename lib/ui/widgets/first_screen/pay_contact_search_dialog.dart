import 'dart:convert';
import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import '../../../data/models/payment_cubit.dart';
import '../../../g1/api.dart';
import '../../ui_helpers.dart';
import '../loading_box.dart';

class SearchDialog extends StatefulWidget {
  const SearchDialog({super.key});

  @override
  State<SearchDialog> createState() => _SearchDialogState();
}

class _SearchDialogState extends State<SearchDialog> {
  final TextEditingController _searchController = TextEditingController();
  String _searchTerm = '';

  List<dynamic> _results = <dynamic>[];
  bool _isLoading = false;

  Future<void> _search() async {
    setState(() {
      _isLoading = true;
    });

    final Response response = await searchUser(_searchTerm);
    setState(() {
      _results = (const JsonDecoder().convert(response.body)
          as Map<String, dynamic>)['results'] as List<dynamic>;
      // debugPrint(_results.toString());
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isFavorite = false;
    return BlocProvider<PaymentCubit>(
        create: (_) => PaymentCubit(),
        child: Scaffold(
          appBar: AppBar(
            title: Text(tr('search_user_title')),
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Colors.white,
            actions: <Widget>[
              IconButton(
                  icon: const Icon(Icons.qr_code_scanner),
                  onPressed: () async {
                    final String? publicKey = await Navigator.push(
                        context,
                        MaterialPageRoute<String>(
                          builder: (BuildContext context) =>
                              const SimpleBarcodeScannerPage(),
                        ));
                    setState(() {
                      if (publicKey is String) {
                        /* context
                        .read<PaymentCubit>()
                        .selectUser(publicKey, nick, avatar); */
                        // result = res;
                      }
                    });
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
                else
                  Expanded(
                    child: ListView.builder(
                        itemCount: _results.length,
                        itemBuilder: (BuildContext context, int index) {
                          final String uid = (((_results[index]
                                      as Map<String, dynamic>)['uids']
                                  as List<dynamic>)[0]
                              as Map<String, dynamic>)['uid'] as String;
                          final String pubkey = (_results[index]
                              as Map<String, dynamic>)['pubkey'] as String;
                          return FutureBuilder<Uint8List>(
                              future: getAvatar((_results[index]
                                  as Map<String, dynamic>)['pubkey'] as String),
                              builder: (BuildContext context,
                                  AsyncSnapshot<Uint8List> snapshot) {
                                return ListTile(
                                  title: Text(uid),
                                  tileColor: index.isEven
                                      ? Colors.grey[200]
                                      : Colors.white,
                                  onTap: () {
                                    context.read<PaymentCubit>().selectUser(
                                        pubkey, uid, snapshot.data!);
                                    Navigator.pop(context, _results[index]);
                                  },
                                  leading: avatar(
                                    snapshot.hasData,
                                    snapshot.data,
                                    bgColor: index.isEven
                                        ? defAvatarColor
                                        : defAvatarBgColor,
                                    color: index.isEven
                                        ? defAvatarBgColor
                                        : defAvatarColor,
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(
                                      isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: isFavorite
                                          ? Colors.red.shade400
                                          : null,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isFavorite = !isFavorite;
                                      });
                                    },
                                  ),
                                );
                              });
                        }),
                  )
              ],
            ),
          ),
        ));
  }
}
