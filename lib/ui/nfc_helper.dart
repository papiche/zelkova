import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:ndef/ndef.dart' as ndef;
import 'package:ndef/record.dart';
import 'package:ndef/record/uri.dart';

import 'logger.dart';

bool hasNft(AsyncSnapshot<NFCAvailability> snapshot) =>
    !kIsWeb && snapshot.hasData && snapshot.data == NFCAvailability.available;

Future<void> writeNfcUrl(String url) async {
  // timeout only works on Android, whereas the following two messages are only for iOS
  final NFCTag tag = await FlutterNfcKit.poll(
    timeout: const Duration(seconds: 10),
    iosMultipleTagMessage: 'Multiple tags found!',
    iosAlertMessage: 'Scan your tag',
  );
  final bool? ndefAvailable = tag.ndefAvailable;
  final bool? ndefWritable = tag.ndefWritable;

  if ((ndefAvailable == null || ndefWritable == null) &&
          (ndefAvailable != null && !ndefAvailable) ||
      (ndefWritable != null && !ndefWritable)) {
    logger('Tag does not have NDEF capability or is not writable');
    return;
  }

  try {
    // Write a NDEF record with the URL to the tag
    await FlutterNfcKit.writeNDEFRecords(
        <NDEFRecord>[ndef.UriRecord.fromString(url)]);

    // iOS only: show an alert message
    await FlutterNfcKit.finish(iosAlertMessage: 'Success');
  } catch (e) {
    logger('Error while writing to tag: $e');
    await FlutterNfcKit.finish(iosErrorMessage: 'Failed');
  }
}

Future<String?> readNfcUrl() async {
  final NFCTag tag =
      await FlutterNfcKit.poll(timeout: const Duration(seconds: 10));
  final bool? ndefAvailable = tag.ndefAvailable;
  if (ndefAvailable != null && ndefAvailable) {
    final List<NDEFRecord> records = await FlutterNfcKit.readNDEFRecords();
    for (final NDEFRecord record in records) {
      if (record is UriRecord) {
        return record.uri.toString();
      }
    }
  }
  return null;
}
