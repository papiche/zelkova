import 'dart:convert';
import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import '../../../config/api.dart';
import 'circular_icon.dart';

class SearchDialog extends StatefulWidget {
  const SearchDialog({super.key});

  @override
  State<SearchDialog> createState() => _SearchDialogState();
}

class _SearchDialogState extends State<SearchDialog> {
  final TextEditingController _searchController = TextEditingController();
  String _searchTerm = '';

  final Color defAvatarBgColor = Colors.grey[200]!;
  final Color defAvatarColor = Colors.white;

  List<dynamic> _results = <dynamic>[];
  bool _isLoading = false;

  Future<void> _search() async {
    setState(() {
      _isLoading = true;
    });
    final String url = '$duniterLookupUrl$_searchTerm';
    debugPrint(url);
    final http.Response response = await http.get(Uri.parse(url));

    setState(() {
      _results = (const JsonDecoder().convert(response.body)
          as Map<String, dynamic>)['results'] as List<dynamic>;
      debugPrint(_results.toString());
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isFavorite = false;
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('search_user_title')),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.qr_code_scanner),
              onPressed: () async {
                final String? res = await Navigator.push(
                    context,
                    MaterialPageRoute<String>(
                      builder: (BuildContext context) =>
                          const SimpleBarcodeScannerPage(),
                    ));
                setState(() {
                  if (res is String) {
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
              const SizedBox(
                width: 100.0,
                height: 100.0,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: _results.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(
                          (((_results[index] as Map<String, dynamic>)['uids']
                                  as List<dynamic>)[0]
                              as Map<String, dynamic>)['uid'] as String),
                      tileColor: index.isEven ? Colors.grey[200] : Colors.white,
                      onTap: () {
                        Navigator.pop(context, _results[index]);
                      },
                      leading: FutureBuilder<String>(
                        future: getAvatar((_results[index]
                            as Map<String, dynamic>)['pubkey'] as String),
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          if (snapshot.hasData) {
                            final List<int> imageBytes =
                                base64.decode(snapshot.data!);
                            return Image.memory(
                              Uint8List.fromList(imageBytes),
                              width: 48,
                              height: 48,
                            );
                          } else {
                            return CircularIcon(
                              iconData: Icons.person,
                              backgroundColor: index.isEven
                                  ? defAvatarColor
                                  : defAvatarBgColor,
                              iconColor: index.isEven
                                  ? defAvatarBgColor
                                  : defAvatarColor,
                            );
                          }
                        },
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red.shade400 : null,
                        ),
                        onPressed: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
