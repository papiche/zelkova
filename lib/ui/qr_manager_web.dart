import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jsqr/scanner.dart';

// ignore: avoid_classes_with_only_static_members
class QrManager {
  static Future<String?> qrScan(BuildContext context) async {
    String? result;
    if (kIsWeb) {
      result = await _webQrScan(context);
    } else {
      return null;
    }
    return result;
  }

  static Future<String?> _webQrScan(BuildContext context) async {
    final String? result = await showDialog(
        context: context,
        builder: (BuildContext context) {
          // final double height = MediaQuery.of(context).size.height;
          final double width = MediaQuery.of(context).size.width;
          return AlertDialog(
            insetPadding: const EdgeInsets.all(5),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            title: const Text('Scan QR Code'),
            content: SizedBox(
                // height: height - 20,
                width: width - 6,
                child: const Scanner()),
          );
        });
    return result;
  }
}
