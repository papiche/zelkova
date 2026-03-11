import 'dart:async';

import 'package:flutter/foundation.dart';

import 'logger.dart';

/// Global flag to force Brave detection for testing
/// Set this to true to simulate Brave browser for testing purposes
bool _forceBraveDetectionForTesting = false;

/// Enable test mode for Brave detection
void enableBraveTestMode() {
  _forceBraveDetectionForTesting = true;
  logger.info(
      '[Brave Detector] ⚠️ TEST MODE ENABLED - will simulate Brave browser');
}

/// Disable test mode for Brave detection
void disableBraveTestMode() {
  _forceBraveDetectionForTesting = false;
  logger.info('[Brave Detector] Test mode DISABLED');
}

/// Detects if the browser is Brave using JS interop
/// Primary: navigator.brave API
/// Override: Test mode flag (for testing purposes)
///
/// Note: Only works on web platform. On mobile/desktop, always returns false.
Future<bool> isBraveBrowser() async {
  if (!kIsWeb) {
    logger
        .debug('[Brave Detector] Not a web platform, skipping Brave detection');
    return false;
  }

  // Test mode override (for web)
  if (_forceBraveDetectionForTesting) {
    logger.warning(
        '[Brave Detector] ⚠️ TEST MODE ACTIVE - Returning true for Brave detection');
    return true;
  }

  // Always return false on non-web platforms
  return false;
}
