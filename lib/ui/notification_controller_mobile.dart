import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'logger.dart';
import 'ui_helpers.dart';

// ignore: avoid_classes_with_only_static_members
///  *********************************************
///     NOTIFICATION CONTROLLER
///  *********************************************
///
class NotificationController {
  static ReceivedAction? initialAction;
  static Locale locale = const Locale('en', 'UK');

  ///  *********************************************
  ///     INITIALIZATIONS
  ///  *********************************************
  ///
  static Future<void> initializeLocalNotifications() async {
    await AwesomeNotifications().initialize(
        null, //'resource://drawable/res_app_icon',//
        <NotificationChannel>[
          NotificationChannel(
              channelKey: 'alerts',
              channelName: 'Alerts',
              channelDescription: 'Notification tests as alerts',
              playSound: true,
              onlyAlertOnce: true,
              groupAlertBehavior: GroupAlertBehavior.Children,
              importance: NotificationImportance.High,
              defaultPrivacy: NotificationPrivacy.Private,
              defaultColor: const Color(0xff526600),
              ledColor: Colors.white)
        ],
        debug: true);

    // Get initial notification action is optional
    initialAction = await AwesomeNotifications().getInitialNotificationAction();
  }

  ///  *********************************************
  ///     NOTIFICATION EVENTS LISTENER
  ///  *********************************************
  ///  Notifications events are only delivered after call this method
  static Future<void> startListeningNotificationEvents() async {
    AwesomeNotifications()
        .setListeners(onActionReceivedMethod: onActionReceivedMethod);
  }

  ///  *********************************************
  ///     NOTIFICATION EVENTS
  ///  *********************************************
  ///
  @pragma('vm:entry-point')
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    if (receivedAction.actionType == ActionType.SilentAction ||
        receivedAction.actionType == ActionType.SilentBackgroundAction) {
      // For background actions, you must hold the execution until the end
      logger(
          'Message sent via notification input: "${receivedAction.buttonKeyInput}"');
      // await executeLongTaskInBackground();
    } else {
      // FIXME (vjrj): go to transactions tab
      GinkgoApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
          '/notification-page',
          (Route<dynamic> route) =>
              (route.settings.name != '/notification-page') || route.isFirst,
          arguments: receivedAction);
    }
  }

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
                        ?.copyWith(color: Theme.of(context).primaryColor)),
              ),
            ],
          );
        });
    return userAuthorized &&
        await AwesomeNotifications().requestPermissionToSendNotifications();
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
      required bool isG1,
      required double currentUd}) async {
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
    await notify(title: title, desc: desc, id: id);
  }

  static Future<void> notify(
      {required String title, required String desc, required String id}) async {
    if (kIsWeb) {
      // dart:html cannot be used in Android
    } else {
      bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
      if (!isAllowed) {
        isAllowed = await displayNotificationRationale();
      }
      if (!isAllowed) {
        return;
      }

      await AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: -1,
              // -1 is replaced by a random number
              channelKey: 'alerts',
              title: title,
              body: desc,
              largeIcon:
                  'https://git.duniter.org/vjrj/ginkgo/-/raw/master/assets/img/coin.png',
              bigPicture: 'https://git.duniter.org/vjrj/ginkgo/-/raw/master/assets/img/gbrevedot_color.svg',
              //'asset://assets/images/balloons-in-sky.jpg',
              notificationLayout: NotificationLayout.BigPicture,
              payload: <String, String>{'notificationId': id}),
          actionButtons: <NotificationActionButton>[
            NotificationActionButton(
                key: 'notification_open', label: tr('notification_open')),
          ]);
    }
    return;
  }

  static Future<void> scheduleNewNotification() async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      isAllowed = await displayNotificationRationale();
    }
    if (!isAllowed) {
      return;
    }

    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: -1,
            // -1 is replaced by a random number
            channelKey: 'alerts',
            title: 'Huston! The eagle has landed!',
            body:
                "A small step for a man, but a giant leap to Flutter's community!",
            bigPicture: 'https://storage.googleapis.com/cms-storage-bucket/d406c736e7c4c57f5f61.png',
            largeIcon: 'https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png',
            //'asset://assets/images/balloons-in-sky.jpg',
            notificationLayout: NotificationLayout.BigPicture,
            payload: <String, String>{
              'notificationId': '1234567890'
            }),
        actionButtons: <NotificationActionButton>[
          NotificationActionButton(key: 'REDIRECT', label: 'Redirect'),
          NotificationActionButton(
              key: 'DISMISS',
              label: 'Dismiss',
              actionType: ActionType.DismissAction,
              isDangerousOption: true)
        ],
        schedule: NotificationCalendar.fromDate(
            date: DateTime.now().add(const Duration(seconds: 10))));
  }

  static Future<void> resetBadgeCounter() async {
    await AwesomeNotifications().resetGlobalBadge();
  }

  static Future<void> cancelNotifications() async {
    await AwesomeNotifications().cancelAll();
  }
}
