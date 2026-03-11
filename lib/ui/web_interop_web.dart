// Web-only platform implementation for JavaScript interop
import 'package:web/web.dart' as web;

/// Get the current window URL href
/// Only works on web platform
String getWindowLocationHref() {
  try {
    return web.window.location.href;
  } catch (e) {
    return '';
  }
}
