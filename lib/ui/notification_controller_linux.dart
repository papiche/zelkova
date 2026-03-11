import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'notif_utils.dart';

// ignore: avoid_classes_with_only_static_members
///  *********************************************
///     NOTIFICATION CONTROLLER (Linux) — DEAD-CODE STUB
///  *********************************************
///
/// This file is NOT used at runtime. Dart conditional exports cannot
/// distinguish Linux from Android/iOS at compile time (both share
/// `dart.library.ffi`), so Linux is handled inside
/// `notification_controller_mobile.dart` via `Platform.isLinux` guards
/// that use `desktop_notifications` (DBus) + `notify-send` fallback.
///
/// Kept only for reference / as a safety net if the export routing
/// changes in the future.
class NotificationController {
  static Locale locale = const Locale('en', 'UK');

  ///  *********************************************
  ///     INITIALIZATIONS
  ///  *********************************************
  ///
  static Future<void> initializeLocalNotifications() async {
    // Linux notifications are typically handled by the desktop environment
    // No explicit initialization needed
  }

  ///  *********************************************
  ///     NOTIFICATION EVENTS LISTENER
  ///  *********************************************
  ///  Notifications events are only delivered after call this method
  static Future<void> startListeningNotificationEvents() async {
    return;
  }

  ///  *********************************************
  ///     REQUESTING NOTIFICATION PERMISSIONS
  ///  *********************************************
  ///

  /// Check if notifications are allowed (Linux: always true, no permission model)
  static Future<bool> isNotificationAllowed() async {
    // Linux doesn't have a permission model like Android/iOS/Web
    // Notifications are always allowed at the application level
    return true;
  }

  static Future<bool> displayNotificationRationale(
      {bool allowPermissionPrompt = true}) async {
    // Guard against null context (e.g., headless/background execution)
    final BuildContext? context = GinkgoApp.navigatorKey.currentContext;
    if (context == null) {
      return false;
    }

    // If called from background or with allowPermissionPrompt=false, don't show dialog
    if (!allowPermissionPrompt) {
      return false;
    }

    bool userAuthorized = false;
    await showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text(tr('request_notifications_perms'),
                style: Theme.of(context).textTheme.titleLarge),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: 20),
                Text(tr('allow_notifications_desc')),
              ],
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text(
                    tr('deny_notifications_btn'),
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.red),
                  )),
              TextButton(
                onPressed: () async {
                  userAuthorized = true;
                  Navigator.of(ctx).pop();
                },
                child: Text(
                  tr('allow_notifications_btn'),
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: const Color(0xff526600)),
                ),
              ),
            ],
          );
        });
    return userAuthorized;
  }

  ///  *********************************************
  ///     NOTIFICATION CREATION METHODS
  ///  *********************************************
  ///
  static Future<void> notifyTransaction(String id,
      {required double amount,
      String? to,
      String? from,
      String? comment = '',
      required double currentUd,
      required bool isG1}) async {
    final String title =
        buildTxNotifTitle(from, languageCode: locale.languageCode);
    final String desc = buildTxNotifDescription(
      from: from,
      to: to,
      comment: comment,
      localeLanguageCode: locale.languageCode,
      amount: amount,
      isG1: isG1,
      currentUd: currentUd,
    );

    await notify(title: title, desc: desc, id: '');
  }

  static Future<void> notify(
      {required String title, required String desc, required String id}) async {
    // Linux desktop notifications: log the notification since there's no standard API
    // In a real implementation, you could use dbus to send notifications to the
    // desktop notification daemon, but that would require additional dependencies
    debugPrint('[NOTIFICATION] $title: $desc');
  }
}
