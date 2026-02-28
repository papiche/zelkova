import 'dart:js_interop';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;

import '../main.dart';
import 'notif_utils.dart';
import 'ui_helpers.dart';

// ignore: avoid_classes_with_only_static_members
///  *********************************************
///     NOTIFICATION CONTROLLER
///  *********************************************
///
class NotificationController {
  static Locale locale = const Locale('en', 'UK');
  // Deduplication: track recent notification keys to avoid duplicates
  // from concurrent fetchTransactions calls
  static final Set<String> _recentNotificationIds = <String>{};

  ///  *********************************************
  ///     INITIALIZATIONS
  ///  *********************************************
  ///
  static Future<void> initializeLocalNotifications() async {}

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

  /// Check if notifications are allowed (Web: checks Notification.permission)
  static Future<bool> isNotificationAllowed() async {
    try {
      return web.Notification.permission == 'granted';
    } catch (e) {
      return false;
    }
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
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Image.asset(
                        'assets/img/animated-bell.gif',
                        height: MediaQuery.of(context).size.height * 0.3,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ],
                ),
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
    if (!userAuthorized) {
      return false;
    }

    try {
      final String permission =
          (await web.Notification.requestPermission().toDart)
              .toDart
              .toLowerCase();
      return permission == 'granted';
    } catch (e) {
      return false;
    }
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
    final String title = buildTxNotifTitle(from);
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
    try {
      final String dedupeKey = '$title|$desc';
      if (_recentNotificationIds.contains(dedupeKey)) {
        return;
      }
      _recentNotificationIds.add(dedupeKey);
      Future<void>.delayed(const Duration(seconds: 30), () {
        _recentNotificationIds.remove(dedupeKey);
      });

      if (web.Notification.permission != 'granted') {
        await web.Notification.requestPermission().toDart;
      }

      if (web.Notification.permission == 'granted') {
        final web.NotificationOptions options = web.NotificationOptions(
          body: desc,
          icon: ginkgoNetIcon,
        );
        final web.Notification notification = web.Notification(title, options);

        // Add click listener
        notification.addEventListener(
            'click',
            (JSAny event) {
              // context.read<BottomNavCubit>().updateIndex(0);
            }
                .toJS);
      }
    } catch (e) {
      // Try this way
      // After: Error: Failed to construct 'Notification': Illegal constructor. Use ServiceWorkerRegistration.showNotification() instead.
      try {
        final web.ServiceWorkerContainer swContainer =
            web.window.navigator.serviceWorker;
        if (swContainer != null) {
          final web.ServiceWorkerRegistration swReg =
              await swContainer.ready.toDart;
          final web.NotificationOptions options = web.NotificationOptions(
            body: desc,
            icon: ginkgoNetIcon,
          );
          await swReg.showNotification(title, options).toDart;
        }
      } catch (e2) {
        // Silently fail if notifications are not supported
      }
    }
  }
}
