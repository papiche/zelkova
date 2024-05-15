// Import only for Android
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ignore: avoid_classes_with_only_static_members
class QrManager {
  static Future<String?> qrScan(BuildContext context) async {
    String? result;
    if (kIsWeb) {
      return null;
    } else {
      result = await _mobileQrScan();
    }
    return result;
  }

  static Future<String?> _mobileQrScan() async {
    final ScanResult result = await BarcodeScanner.scan(
      options: ScanOptions(
        strings: <String, String>{
          'cancel': tr('qr_scanner_cancel'),
          'flash_on': tr('qr_scanner_flash_on'),
          'flash_off': tr('qr_scanner_flash_off'),
        },
        restrictFormat: <BarcodeFormat>[BarcodeFormat.qr],
        // useCamera: -1,
        // BarcodeScanner.numberOfCameras ,
        // autoEnableFlash: false,
        /* android: AndroidOptions(
          aspectTolerance: 0.00,
          useAutoFocus: true,
         ), */
      ),
    );
    return result.rawContent;
  }
}
// lib/ui/ui_helpers.dart

Future<String?> showTextInputDialog({
  required BuildContext context,
  required String title,
  required String hint,
}) async {
  String? input;
  await showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: TextField(
          onChanged: (String value) {
            input = value;
          },
          decoration: InputDecoration(hintText: hint),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(input);
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
  return input;
}