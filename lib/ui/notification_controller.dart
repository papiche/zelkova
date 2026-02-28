// Platform-specific notification controller exports
// Mobile (Android/iOS): Uses AwesomeNotifications
// Web: Uses Web Notifications API
// Linux: Uses logging (system notifications would require dbus)
// Fallback: Mobile implementation
export 'notification_controller_mobile.dart'
    if (dart.library.html) 'notification_controller_web.dart'
    if (dart.library.ffi) 'notification_controller_linux.dart';
