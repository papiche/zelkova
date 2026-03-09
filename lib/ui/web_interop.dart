// Conditional imports for web interop
// This file automatically imports the correct implementation based on platform

// Conditional import
import 'web_interop_web.dart' if (dart.library.io) 'web_interop_stub.dart'
    as web_interop;

/// Get the current window URL href
/// Returns empty string on non-web platforms
String getWindowLocationHref() => web_interop.getWindowLocationHref();
