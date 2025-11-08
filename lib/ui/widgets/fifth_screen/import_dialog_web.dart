import 'dart:async';
import 'dart:js_interop';

import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:web/web.dart' as web;

import '../../file_picker/file_picker_wrapper.dart';
import '../../logger.dart';

Future<String> importWalletWebHtml([String allowedExtension = '.json']) async {
  final Completer<String> completer = Completer<String>();
  final web.HTMLInputElement input = web.HTMLInputElement();
  input.type = 'file';
  input.multiple = false;
  input.accept = allowedExtension; // limit file types

  input.addEventListener(
      'change',
      (web.Event event) {
        // Prevent default behavior to avoid page refresh in Firefox Android
        event.preventDefault();
        event.stopPropagation();

        if (input.files == null || input.files!.length == 0) {
          if (!completer.isCompleted) {
            logger('No file selected');
            completer.complete('');
          }
          return;
        }

        final web.File? file = input.files?.item(0);
        if (file == null) {
          if (!completer.isCompleted) {
            completer.complete('');
          }
          return;
        }

        final web.FileReader reader = web.FileReader();

        reader.addEventListener(
            'error',
            (web.Event e) {
              if (!completer.isCompleted) {
                logger('Error reading file');
                completer.complete('');
              }
            }.toJS);

        // Read as text
        reader.readAsText(file);

        reader.addEventListener(
            'loadend',
            (web.Event e) {
              try {
                final String? jsonString = (reader.result as JSString?)?.toDart;
                if (jsonString != null && !kReleaseMode) {
                  // logger(jsonString);
                }
                if (!completer.isCompleted) {
                  completer.complete(jsonString ?? '');
                }
              } catch (e, stacktrace) {
                logger('Error importing wallet $e');
                Sentry.captureException(e, stackTrace: stacktrace);
                if (!completer.isCompleted) {
                  completer.complete('');
                }
              }
            }.toJS);
      }.toJS);

  input.click();

  // Add timeout to handle cases where onChange never fires
  Future<void>.delayed(const Duration(minutes: 5), () {
    if (!completer.isCompleted) {
      logger('File selection timeout');
      completer.complete('');
    }
  });

  return completer.future;
}

bool isAppleWeb() {
  final String ua = web.window.navigator.userAgent.toLowerCase();
  return kIsWeb &&
      (ua.contains('iphone') ||
          ua.contains('ipad') ||
          ua.contains('macintosh'));
}

Future<String> importWalletWeb(String extension) async {
  if (isAppleWeb()) {
    return importWalletWithFilePicker(extension);
  } else {
    // add dot to the extension if not present
    if (!extension.startsWith('.')) {
      extension = '.$extension';
    }
    return importWalletWebHtml(extension);
  }
}
