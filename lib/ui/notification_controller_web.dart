import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;

import '../config/theme.dart';
import '../main.dart';
import 'ui_helpers.dart';

// ignore: avoid_classes_with_only_static_members
///  *********************************************
///     NOTIFICATION CONTROLLER
///  *********************************************
///
class NotificationController {
  static Locale locale = const Locale('en', 'UK');

  ///  *********************************************
  ///     INITIALIZATIONS
  ///  *********************************************
  ///
  static Future<void> initializeLocalNotifications() async {}

  ///  *********************************************
  ///     NOTIFICATION EVENTS LISTENER
  ///  *********************************************
  ///  Notifications events are only delivered after call this method
  static Future<void> startListeningNotificationEvents() async {}

  ///  *********************************************
  ///     REQUESTING NOTIFICATION PERMISSIONS
  ///  *********************************************
  ///
  static Future<bool> displayNotificationRationale() async {
    bool userAuthorized = false;
    final BuildContext context = GinkgoApp.navigatorKey.currentContext!;
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
                child: Text(tr('allow_notifications_btn'),
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: lightColorScheme.primary)),
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
  static Future<void> createNewNotification(String id,
      {required double amount, String? to, String? from}) async {
    // FIXME: DUP CODE!!
    final String title = from != null
        ? tr('notification_new_payment_title')
        : tr('notification_new_sent_title');
    final String desc = from != null
        ? tr('notification_new_payment_desc', namedArgs: <String, String>{
            'amount': formatAmountWithLocale(locale.languageCode, amount),
            'from': from,
          })
        : tr('notification_new_sent_desc', namedArgs: <String, String>{
            'amount': formatAmountWithLocale(locale.languageCode, amount),
            'to': to!,
          });
    try {
      if (html.Notification.permission != 'granted') {
        await html.Notification.requestPermission();
      }

      if (html.Notification.permission == 'granted') {
        final html.Notification notification =
            html.Notification(title, body: desc, icon: ginkgoNetIcon);
        notification.onClick.listen((html.Event event) {
          // context.read<BottomNavCubit>().updateIndex(0);
        });
      }
    } catch (e ) {
      // Try this way
      // After: Error: Failed to construct 'Notification': Illegal constructor. Use ServiceWorkerRegistration.showNotification() instead.
      if (html.ServiceWorkerRegistration != null) {
        final html.ServiceWorkerRegistration swReg = await html.window.navigator.serviceWorker!.ready;
        await swReg
            .showNotification(title, <String, String>{'body': desc, 'icon': ginkgoNetIcon});
      }
    }
  }


}
