import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_html/html.dart' as html;

/*
This is a work in progress to export/import keys with some password
 */
class ExportImportPage extends StatefulWidget {
  const ExportImportPage({super.key});

  @override
  State<ExportImportPage> createState() => _ExportImportPageState();
}

class _ExportImportPageState extends State<ExportImportPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  String _statusMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exportar/Importar Preferencias Compartidas'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Contraseña de patrón',
                    ),
                    obscureText: true,
                    validator: (String? value) {
                      if (value != null && value.isEmpty) {
                        return 'Por favor, introduce una contraseña de patrón';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _exportarPreferenciasCompartidas,
                    child: const Text('Exportar Preferencias Compartidas'),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _importarPreferenciasCompartidas,
                    child: const Text('Importar Preferencias Compartidas'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Text(_statusMessage),
          ],
        ),
      ),
    );
  }

  Future<void> _exportarPreferenciasCompartidas() async {
    if (_formKey.currentState != null && !_formKey.currentState!.validate()) {
      return;
    }

    final String password = _passwordController.text;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String jsonString = jsonEncode(prefs
        .getKeys()
        .fold<Map<String, dynamic>>(
            <String, dynamic>{},
            (Map<String, dynamic> map, String key) =>
                <String, dynamic>{...map, key: prefs.get(key)}));
    final Uint8List plainText = Uint8List.fromList(utf8.encode(jsonString));

    final encrypt.Key key = encrypt.Key.fromUtf8(password.padRight(32));
    final encrypt.IV iv = encrypt.IV.fromLength(16);
    final encrypt.Encrypter encrypter = encrypt.Encrypter(encrypt.AES(key));

    final encrypt.Encrypted encrypted =
        encrypter.encryptBytes(plainText, iv: iv);

    Directory? appDir = await getDownloadsDirectory();
    appDir = appDir ?? await getApplicationDocumentsDirectory();
    final File file = File('${appDir.path}/shared_preferences.bin.txt');
    await file.writeAsBytes(encrypted.bytes);

    setState(() {
      _statusMessage = 'Preferencias Compartidas exportadas con éxito';
    });
  }

  Future<void> _importarPreferenciasCompartidas() async {
    final Completer<void> completer = Completer<void>();

    // Crear un elemento <input type="file"> para seleccionar archivos
    final html.InputElement input = html.InputElement()..type = 'file';

    input.multiple = false;
    input.accept = '.txt'; // Opcional: limitar a tipos de archivo específicos
    input.click();

    // Esperar hasta que se seleccionen los archivos
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

      // Restablecer las preferencias compartidas desde el archivo cargado
      try {
        final String jsonString = reader.result as String;
        final jsonMap = jsonDecode(jsonString);
        final SharedPreferences prefs = await SharedPreferences.getInstance();

        // TODO(vjrj): jsonMap.forEach((key, value) => prefs.set(key, value));
        setState(() {
          _statusMessage = 'Preferencias Compartidas importadas con éxito';
        });
      } catch (e) {
        setState(() {
          _statusMessage = 'Error al importar las Preferencias Compartidas';
        });
      }

      completer.complete();
    });
    return completer.future;
  }
}
