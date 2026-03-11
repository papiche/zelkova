import 'dart:js_interop';
import 'dart:typed_data';

import 'package:web/web.dart' as web;

void webFileDownload(List<int> bytes, String fileName) {
  final Uint8List uint8List =
      bytes is Uint8List ? bytes : Uint8List.fromList(bytes);
  final web.Blob blob = web.Blob(<JSUint8Array>[uint8List.toJS].toJS);
  final String url = web.URL.createObjectURL(blob);

  final web.HTMLAnchorElement anchor = web.HTMLAnchorElement();
  anchor.href = url;
  anchor.download = fileName;
  anchor.click();
}

String getWebLocationHref() {
  return web.window.location.href;
}
