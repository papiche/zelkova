import 'dart:async';
import 'dart:js_interop';
import 'dart:typed_data';
import 'dart:ui_web' as ui_web;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;
import 'package:zxing2/qrcode.dart';

mixin QrManager {
  static Future<String?> qrScan(BuildContext context) async {
    final web.HTMLVideoElement video = web.HTMLVideoElement();
    final String viewId = 'qr-video-${DateTime.now().millisecondsSinceEpoch}';

    ui_web.platformViewRegistry.registerViewFactory(viewId, (int _) => video);

    final web.MediaStreamConstraints constraints = web.MediaStreamConstraints(
      video: <String, dynamic>{'facingMode': 'environment'}.jsify()!,
    );

    final web.MediaStream stream = await web.window.navigator.mediaDevices
        .getUserMedia(constraints)
        .toDart;

    video
      ..srcObject = stream
      ..autoplay = true
      ..muted = true
      ..setAttribute('playsinline', 'true')
      ..style.width = '100%'
      ..style.height = '100%';

    final web.HTMLCanvasElement canvas = web.HTMLCanvasElement();
    final QRCodeReader reader = QRCodeReader();
    final Completer<String?> completer = Completer<String?>();

    Timer? timer;
    timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      if (video.videoWidth == 0 || video.videoHeight == 0) {
        return;
      }

      canvas.width = video.videoWidth;
      canvas.height = video.videoHeight;

      final web.CanvasRenderingContext2D ctx = canvas.context2D;
      ctx.drawImage(video, 0, 0);

      final web.ImageData imageData =
          ctx.getImageData(0, 0, canvas.width, canvas.height);

      final LuminanceSource source =
          luminanceSourceFromImageData(imageData, canvas.width, canvas.height);

      final BinaryBitmap bitmap = BinaryBitmap(HybridBinarizer(source));

      try {
        final Result result = reader.decode(bitmap);
        if (!completer.isCompleted) {
          completer.complete(result.text);
          Navigator.of(context, rootNavigator: true).pop(result.text);
        }
      } catch (_) {
        // loggerDev('QR scan error', error: e, stackTrace: s);
      }
    });

    if (!context.mounted) {
      return null;
    }

    final double height = MediaQuery.of(context).size.height - 20;
    final double width = MediaQuery.of(context).size.width - 20;

    final String? result = await showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        content: SizedBox(
          width: width,
          height: height,
          child: HtmlElementView(viewType: viewId),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(tr('cancel')),
          )
        ],
      ),
    );

    timer.cancel();
    final web.MediaStream? srcStream = video.srcObject as web.MediaStream?;
    if (srcStream != null) {
      srcStream.getTracks().toDart.forEach((web.MediaStreamTrack track) {
        track.stop();
      });
    }

    return result ?? await completer.future;
  }

  static LuminanceSource luminanceSourceFromImageData(
      web.ImageData imageData, int width, int height) {
    final JSUint8ClampedArray data = imageData.data;
    final int length = data.toDart.length;
    final Int32List pixels = Int32List(length ~/ 4);

    for (int i = 0, j = 0; i < length; i += 4, j++) {
      final int r = data.toDart[i];
      final int g = data.toDart[i + 1];
      final int b = data.toDart[i + 2];
      final int a = data.toDart[i + 3];
      pixels[j] = (a << 24) | (r << 16) | (g << 8) | b; // AARRGGBB
    }

    return RGBLuminanceSource(width, height, pixels);
  }
}
