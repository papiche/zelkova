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
      if (!context.mounted) {
        return null;
      }
      final String? result = await Navigator.push(
        context,
        MaterialPageRoute<String>(
          builder: (BuildContext context) => const FullScreenQrScanner(),
        ),
      );
      return result;
    } else {
      return _barcodeScan();
    }
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

class _FullScreenQrScannerState extends State<FullScreenQrScanner>
    with WidgetsBindingObserver {
  bool _isScanning = true;
  bool _hasScanned = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _isScanning = false;
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Pause scanning when app goes to background
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _isScanning = false;
    } else if (state == AppLifecycleState.resumed && !_hasScanned) {
      _isScanning = true;
    }
  }

  void _handleScan(Code? code) {
    if (!_isScanning || _hasScanned || !mounted) {
      return;
    }

    if (code != null &&
        code.isValid &&
        code.text != null &&
        code.text!.isNotEmpty) {
      _hasScanned = true;
      _isScanning = false;

      // Use a slight delay to ensure the scan completes before closing
      Future<void>.delayed(const Duration(milliseconds: 150), () {
        if (mounted) {
          Navigator.of(context).pop(code.text);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('qr_scanner_title')),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            _isScanning = false;
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ReaderWidget(
        onScan: _handleScan,
        onScanFailure: (Code? code) {
          // Ignore scan failures, keep trying
        },
        // Increased delay for better stability on problematic devices
        scanDelay: const Duration(milliseconds: 500),
        // Use medium resolution for better compatibility
        resolution: ResolutionPreset.medium,
        // Make UI elements semi-transparent
        actionButtonsBackgroundColor: Colors.black.withValues(alpha: 0.5),
        actionButtonsBackgroundBorderRadius: BorderRadius.circular(8),
        // Process only QR codes for better performance
        codeFormat: Format.qrCode,
        // tryRotate: true,
        // Enable try inverted for better QR detection
        tryInverted: true,
        // Enable tryHarder for better detection but may be slower
        tryHarder: true,
        // Show controls for user interaction
        // showGallery: true,
        // showToggleCamera: true,
        // showFlashlight: true,
        // Loading widget while camera initializes
        loading: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
