import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zxing/flutter_zxing.dart';

// ignore: avoid_classes_with_only_static_members
class QrManager {
  static Future<String?> qrScan(BuildContext context) async {
    try {
      final Code? result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const QrScannerScreen(),
        ),
      );

      if (result != null && result.isValid) {
        return result.text;
      } else {
        if (!context.mounted) {
          return null;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(tr('qr_scanner_no_qr_detected')),
            backgroundColor: Colors.red,
          ),
        );
        return null;
      }
    } catch (e) {
      debugPrint('Error scanning QR: $e');
      if (!context.mounted) {
        return null;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(tr('qr_scanner_error')),
          backgroundColor: Colors.red,
        ),
      );
      return null;
    }
  }
}

class QrScannerScreen extends StatelessWidget {
  const QrScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('qr_scanner_title')),
      ),
      body: ReaderWidget(
        onScan: (Code result) {
          if (result.isValid) {
            Navigator.of(context).pop(result);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(tr('qr_scanner_no_qr_detected')),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        onScanFailure: (Code? result) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(tr('qr_scanner_error')),
              backgroundColor: Colors.red,
            ),
          );
        },
        scanDelay: const Duration(milliseconds: 500),
        actionButtonsBackgroundColor: Colors.black.withOpacity(0.5),
      ),
    );
  }
}
