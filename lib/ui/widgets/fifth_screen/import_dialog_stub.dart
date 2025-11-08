import 'dart:async';

import '../../file_picker/file_picker_wrapper.dart';

// Stub for non-web platforms
Future<String> importWalletWebHtml([String allowedExtension = '.json']) async {
  // On non-web platforms, use native file picker
  return importWalletWithFilePicker(allowedExtension.replaceAll('.', ''));
}

bool isAppleWeb() {
  // Always false on non-web platforms
  return false;
}

Future<String> importWalletWeb(String extension) async {
  return importWalletWithFilePicker(extension);
}
