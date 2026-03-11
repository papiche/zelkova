// Platform-specific notification controller exports
// Mobile (Android/iOS/Linux): Uses AwesomeNotifications (with Linux runtime guard)
// Web: Uses Web Notifications API
//
// IMPORTANT: dart.library.ffi is true on Android/iOS/Linux, so it cannot be
// used to distinguish Linux from mobile. Instead, we use dart.library.js_interop
// (true only on Web) and handle Linux with a runtime Platform.isLinux check
// inside the mobile controller.
export 'notification_controller_mobile.dart'
    if (dart.library.js_interop) 'notification_controller_web.dart';
