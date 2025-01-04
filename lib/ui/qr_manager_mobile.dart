import 'dart:async';

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zxing/flutter_zxing.dart';

// ignore: avoid_classes_with_only_static_members
class QrManager {
  static Future<String?> qrScan(BuildContext context) async {
    final int sdkVersion = await _getSdkVersion();
    if (sdkVersion >= 21) {
      if (context.mounted) {
        final String? result = await Navigator.push(
          context,
          MaterialPageRoute<String>(
            builder: (BuildContext context) => const FullScreenQrScanner(),
          ),
        );
        return result;
      }
    } else {
      return _barcodeScan();
    }
    return null;
  }

  static Future<int> _getSdkVersion() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo.version.sdkInt;
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

class FullScreenQrScanner extends StatefulWidget {
  const FullScreenQrScanner({super.key});

  @override
  State<FullScreenQrScanner> createState() => _FullScreenQrScannerState();
}

class _FullScreenQrScannerState extends State<FullScreenQrScanner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('qr_scanner_title')),
      ),
      body: ReaderWidget(
        onScan: (Code? code) {
          if (code != null && code.isValid) {
            Navigator.of(context).pop(code.text);
          }
        },
        onScanFailure: (Code? code) {
          // Wait til the scan is done
          // Navigator.of(context).pop();
        },
        scanDelay: const Duration(milliseconds: 500),
        actionButtonsBackgroundColor: Colors.black.withValues(alpha: 0.5),
        actionButtonsBackgroundBorderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
