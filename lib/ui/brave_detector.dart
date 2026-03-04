import 'dart:async';
import 'dart:js_interop';

import 'package:flutter/foundation.dart';
import 'package:web/web.dart' as web;

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
Future<bool> isBraveBrowser() async {
  if (!kIsWeb) {
    logger
        .debug('[Brave Detector] Not a web platform, skipping Brave detection');
    return false;
  }

  // Test mode override
  if (_forceBraveDetectionForTesting) {
    logger.warning(
        '[Brave Detector] ⚠️ TEST MODE ACTIVE - Returning true for Brave detection');
    return true;
  }

  try {
    logger.debug('[Brave Detector] Starting Brave browser detection...');

    // Log full user agent for debugging
    try {
      final String userAgent = web.window.navigator.userAgent;
      logger.debug('[Brave Detector] Full user agent: $userAgent');
    } catch (e) {
      logger.debug('[Brave Detector] Could not read user agent: $e');
    }

    // Try method 1: Direct navigator.brave check with JS interop
    try {
      if (await _checkNavigatorBraveAPI()) {
        logger.info('[Brave Detector] ✓ Detected via navigator.brave API');
        return true;
      }
    } catch (e) {
      logger.debug('[Brave Detector] Method 1 (navigator.brave) error: $e');
    }

    logger.debug(
        '[Brave Detector] ✗ Not detected as Brave browser (no detection methods succeeded)');
    return false;
  } catch (e, stack) {
    logger.error('[Brave Detector] Unexpected error during detection: $e');
    logger.debug('[Brave Detector] Stack trace: $stack');
    return false;
  }
}

/// Check navigator.brave API using JS interop
Future<bool> _checkNavigatorBraveAPI() async {
  try {
    logger.debug('[Brave Detector] [Method 1] Checking navigator.brave API...');

    // Check if navigator.brave exists
    final bool hasBrave = _hasNavigatorBrave();
    if (!hasBrave) {
      logger.debug('[Brave Detector] [Method 1] navigator.brave not found');
      return false;
    }

    logger.info('[Brave Detector] [Method 1] ✓ navigator.brave property found');

    // Try to call isBrave() method
    try {
      final bool result = await _callBraveIsBraveAsync();
      logger.info(
          '[Brave Detector] [Method 1] navigator.brave.isBrave() returned: $result');
      return result;
    } catch (e) {
      logger.debug('[Brave Detector] [Method 1] isBrave() call error: $e');
      // If brave property exists, still likely Brave even if isBrave() fails
      logger.info(
          '[Brave Detector] [Method 1] ✓ Brave detected (brave property exists despite isBrave() error)');
      return true;
    }
  } catch (e) {
    logger.debug('[Brave Detector] [Method 1] Unexpected error: $e');
    return false;
  }
}

/// Check if navigator.brave exists
bool _hasNavigatorBrave() {
  try {
    final JSObject navigator = web.window.navigator as JSObject;
    return _navigatorHasBrave(navigator);
  } catch (e) {
    logger.debug('[Brave Detector] Error in _hasNavigatorBrave: $e');
    return false;
  }
}

/// Call navigator.brave.isBrave() and convert promise to future
Future<bool> _callBraveIsBraveAsync() async {
  try {
    final JSPromise<JSBoolean> promise = _callBraveIsBraveJS();
    final JSBoolean result = await promise.toDart;
    return result.toDart;
  } catch (e) {
    logger.debug('[Brave Detector] Error calling isBrave: $e');
    rethrow;
  }
}

/// JS interop: Check if navigator.brave property exists
@JS(r'function(nav) { return typeof nav.brave !== "undefined"; }')
external bool _navigatorHasBrave(JSObject navigator);

/// JS interop: Call navigator.brave.isBrave() and return as JSPromise<JSBoolean>
@JS(r'function() { if (typeof navigator !== "undefined" && typeof navigator.brave !== "undefined" && typeof navigator.brave.isBrave === "function") { return navigator.brave.isBrave(); } return Promise.resolve(false); }')
external JSPromise<JSBoolean> _callBraveIsBraveJS();
