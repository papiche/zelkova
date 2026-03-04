import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:web/web.dart' as web;

/// Detects if the browser is Brave
/// Uses navigator.brave API which is injected by Brave browser
/// Returns true if (navigator.brave && await navigator.brave.isBrave() || false)
Future<bool> isBraveBrowser() async {
  if (!kIsWeb) {
    return false;
  }

  try {
    // Access navigator object
    final web.Navigator navigator = web.window.navigator;
    final Object? navigatorObj = navigator as Object?;

    if (navigatorObj == null) {
      return false;
    }

    // Check if navigator.brave exists using dynamic cast
    // ignore: avoid_dynamic_calls
    final Object? brave = (navigatorObj as dynamic).brave;

    // Check if navigator.brave exists
    if (brave == null) {
      return false;
    }

    // If navigator.brave exists, it's likely Brave browser
    // Try to call isBrave() for confirmation
    try {
      // ignore: avoid_dynamic_calls
      final Object? isBraveFunc = (brave as dynamic).isBrave;
      if (isBraveFunc != null) {
        // ignore: avoid_dynamic_calls
        final Object? result = await (isBraveFunc as dynamic)();
        return result == true;
      }
    } catch (_) {
      // If the call fails, navigator.brave existing is enough
      return true;
    }

    return true;
  } catch (_) {
    // If any error occurs, assume it's not Brave
    return false;
  }
}
