import 'dart:async';
import 'dart:convert';

import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import '../logger.dart';

class FilePickerWrapper {
  Future<String?> pickFile() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles();
    return result?.files.single.path;
  }
}

Future<String> importWalletWithFilePicker(
    [String allowedExtension = 'json']) async {
  try {
    if (kIsWeb) {
      FilePickerWeb.registerWith(Registrar());
    }
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
//      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: <String>[allowedExtension],
      withData: true,
    );

    if (result != null && result.files.isNotEmpty) {
      final PlatformFile file = result.files.first;

      final Uint8List? bytes = file.bytes;
      if (bytes != null) {
        return utf8.decode(bytes);
      } else {
        throw Exception('File does not contain valid data');
      }
    } else {
      return '';
    }
  } catch (e, s) {
    loggerDev('Error importing wallet with file picker',
        error: e, stackTrace: s);
    return '';
  }
}
