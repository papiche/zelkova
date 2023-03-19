import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pattern_lock/pattern_lock.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_html/html.dart' as html;

import '../../../main.dart';
import 'pattern_util.dart';

class ImportDialog extends StatelessWidget {
  ImportDialog({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: _importWallet(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final List<int>? pattern =
                ModalRoute.of(context)!.settings.arguments as List<int>?;
            return Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                title: const Text('Check Pattern'),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const Flexible(
                    child: Text(
                      'Draw Your pattern',
                      style: TextStyle(fontSize: 26),
                    ),
                  ),
                  Flexible(
                    child: PatternLock(
                      selectedColor: Colors.red,
                      pointRadius: 8,
                      showInput: true,
                      dimension: 3,
                      relativePadding: 0.7,
                      selectThreshold: 25,
                      fillPoints: true,
                      onInputComplete: (List<int> input) {
                        if (listEquals<int>(input, pattern)) {
                          Navigator.of(context).pop(true);
                        } else {
                          context.replaceSnackbar(
                            content: const Text(
                              'WRONG',
                              style: TextStyle(color: Colors.red),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            // Los datos todavía se están cargando, muestra un indicador de carga
            return Container();
          }
        });
  }

  Future<String> _importWallet() async {
    final Completer<String> completer = Completer<String>();
    final html.InputElement input = html.InputElement()..type = 'file';

    input.multiple = false;
    input.accept = '.json'; // limit file types
    input.click();

    input.onChange.listen((html.Event event) async {
      if (input.files != null && input.files!.isEmpty) {
        completer.complete();
        return;
      }

      final html.File file = input.files!.first;
      final html.FileReader reader = html.FileReader();

      // Leer el archivo seleccionado como texto
      reader.readAsText(file);
      await reader.onLoadEnd.first;

      try {
        final String jsonString = reader.result as String;
        if (!kReleaseMode) {
          logger(jsonString);
        }
        final dynamic jsonMap = jsonDecode(jsonString);
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        completer.complete(jsonString);
        // TODO(vjrj): jsonMap.forEach((key, value) => prefs.set(key, value));
      } catch (e) {
        logger('Error importing wallet $e');
      }
    });
    return completer.future;
  }
}
