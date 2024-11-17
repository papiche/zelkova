import 'dart:io';

import 'package:flutter/material.dart';

import 'qr_manager_linux.dart' as linux;
import 'qr_manager_mobile.dart' as mobile;

// ignore: avoid_classes_with_only_static_members
class QrManager {
  static Future<String?> qrScan(BuildContext context) async {
    if (Platform.isAndroid || Platform.isIOS) {
      return mobile.QrManager.qrScan(context);
    } else if (Platform.isLinux) {
      //  || Platform.isWindows || Platform.isMacOS) {
      return linux.QrManager.qrScan(context);
    } else {
      throw UnimplementedError('QR scanning not supported');
    }
  }
}
