import 'package:easy_localization/easy_localization.dart';
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
    const Scanner sc = Scanner();
    final double height = MediaQuery.of(context).size.height - 20;
    final double width = MediaQuery.of(context).size.width - 20;
    Scanner.vidDiv.style.cssText =
        'max-width: ${width}px; max-height: ${height}px; overflow: hidden;';

    final String? result = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(tr('cancel')),
              ),
            ],
            insetPadding: const EdgeInsets.all(5),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            title: Text(tr('qr_scanner_title')),
            content: SizedBox(height: height, width: width, child: sc),
          );
        });
    return result;
  }
}
