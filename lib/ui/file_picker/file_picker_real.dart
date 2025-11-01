import 'dart:async';
import 'dart:convert';

import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages
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
      type: FileType.custom,
      allowedExtensions: <String>[allowedExtension],
      withData: true,
    );

    if (result == null) {
      // User cancelled the picker
      loggerDev('File selection cancelled by user');
      return '';
    }

    if (result.files.isEmpty) {
      loggerDev('No file selected');
      return '';
    }

    final PlatformFile file = result.files.first;

    // Try to read bytes first (works on all platforms)
    final Uint8List? bytes = file.bytes;
    if (bytes != null && bytes.isNotEmpty) {
      try {
        return utf8.decode(bytes);
      } catch (e) {
        loggerDev('Error decoding file bytes', error: e);
        throw Exception('File does not contain valid UTF-8 text');
      }
    }

    // Fallback to path for native platforms
    if (file.path != null && file.path!.isNotEmpty) {
      loggerDev('Error reading file from path');
      throw Exception('Could not read file from path: ${file.path}');
    }

    loggerDev('File does not contain data or path');
    return '';
  } catch (e, s) {
    loggerDev('Error importing wallet with file picker',
        error: e, stackTrace: s);
    return '';
  }
}
