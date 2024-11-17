import 'dart:async';

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zxing/flutter_zxing.dart';

// ignore: avoid_classes_with_only_static_members
class QrManager {
  static Future<String?> qrScan(BuildContext context) async {
    if (kIsWeb) {
      return null;
    }

    final int sdkVersion = await _getSdkVersion();
    if (sdkVersion >= 21) {
      return _barcodeScan();
      // WIP:
      // return _zxingQrScan(context);
    } else {
      return _barcodeScan();
    }
  }

  static Future<int> _getSdkVersion() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo.version.sdkInt;
  }

  // ignore: unused_element
  static Future<String?> _zxingQrScan(BuildContext context) async {
    final Completer<String?> completer = Completer<String?>();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: ReaderWidget(
            onScan: (Code? code) {
              if (code != null && code.isValid) {
                completer.complete(code.text);
                Navigator.of(context).pop();
              }
            },
            onScanFailure: (Code? code) {
              completer.complete(null);
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
    return completer.future;
  }

  static Future<String?> _barcodeScan() async {
    try {
      final ScanResult result = await BarcodeScanner.scan(
        options: ScanOptions(
          strings: <String, String>{
            'cancel': tr('cancel'),
            'flash_on': tr('qr_scanner_flash_on'),
            'flash_off': tr('qr_scanner_flash_off'),
          },
          restrictFormat: <BarcodeFormat>[BarcodeFormat.qr],
        ),
      );
      return result.rawContent;
    } catch (e) {
      return null;
    }
  }
}
