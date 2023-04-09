// Import only for Android
import 'package:barcode_scan2/barcode_scan2.dart';
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
      options: const ScanOptions(
        strings: <String, String>{
          'cancel': 'CANCEL',
          'flash_on': 'FLASH ON',
          'flash_off': 'FLASH OFF',
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
