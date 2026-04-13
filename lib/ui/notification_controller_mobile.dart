import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:desktop_notifications/desktop_notifications.dart' as dn;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/bottom_nav_cubit.dart';
import '../g1/g1_helper.dart';
import '../main.dart';
import '../shared_prefs_helper.dart';
import 'logger.dart';
import 'notif_utils.dart';

// ignore: avoid_classes_with_only_static_members
///  *********************************************
///     NOTIFICATION CONTROLLER (Mobile + Linux)
///  *********************************************
///
/// This controller handles Android, iOS **and** Linux.
///
/// Linux lands here because Dart conditional exports cannot distinguish it
/// from Android/iOS at compile time — both share `dart.library.ffi` and
/// `dart.library.io`. A separate `notification_controller_linux.dart` exists
/// but is only kept as a dead-code stub. Instead, runtime `Platform.isLinux`
/// guards route Linux to native desktop notifications via DBus
/// (`desktop_notifications` package) with a `notify-send` fallback.
class NotificationController {
  static ReceivedAction? initialAction;
  static Locale locale = const Locale('en', 'UK');

  ///  *********************************************
  ///     INITIALIZATIONS
  ///  *********************************************
  ///
  static Future<void> initializeLocalNotifications() async {
    if (!kIsWeb && Platform.isLinux) {
      return;
    }
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

  static ReceivePort? receivePort;

  static Future<void> initializeIsolateReceivePort() async {
    if (!kIsWeb && Platform.isLinux) {
      return;
    }
    receivePort = ReceivePort('Notification action port in main isolate')
      ..listen((dynamic silentData) =>
          onActionReceivedImplementationMethod(silentData));

    // This initialization only happens on main isolate
    IsolateNameServer.registerPortWithName(
        receivePort!.sendPort, 'notification_action_port');
  }

  ///  *********************************************
  ///     NOTIFICATION EVENTS LISTENER
  ///  *********************************************
  ///  Notifications events are only delivered after call this method
  static Future<void> startListeningNotificationEvents() async {
    if (!kIsWeb && Platform.isLinux) {
      return;
    }
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
      // this process is only necessary when you need to redirect the user
      // to a new page or use a valid context, since parallel isolates do not
      // have valid context, so you need redirect the execution to main isolate
      if (receivePort == null) {
        logger(
            'onActionReceivedMethod was called inside a parallel dart isolate.');
        final SendPort? sendPort =
            IsolateNameServer.lookupPortByName('notification_action_port');

        if (sendPort != null) {
          logger('Redirecting the execution to main isolate process.');
          sendPort.send(receivedAction);
          return;
        }
      }

      return onActionReceivedImplementationMethod(receivedAction);
    }
  }

  static Future<void> onActionReceivedImplementationMethod(
      dynamic receivedAction) async {
    // Extract wallet pubKey from notification payload
    String? walletPubKey;
    try {
      final Map<String, dynamic> actionMap =
          receivedAction as Map<String, dynamic>;
      final Map<String, dynamic>? payload =
          actionMap['payload'] as Map<String, dynamic>?;
      walletPubKey = payload?['walletPubKey'] as String?;
    } catch (e) {
      logger('Error extracting payload from notification: $e');
      walletPubKey = null;
    }

    // If we have a wallet pubKey, switch to it
    if (walletPubKey != null && walletPubKey.isNotEmpty) {
      try {
        final String currentPubKey = SharedPreferencesHelper().getPubKey();
        if (extractPublicKey(walletPubKey) != extractPublicKey(currentPubKey)) {
          // Switch to the correct wallet
          await SharedPreferencesHelper().selectCurrentWallet(walletPubKey);
          logger('Switched to wallet $walletPubKey from notification');
        }
      } catch (e) {
        logger('Error switching wallet from notification: $e');
      }
    }

    // Navigate to notifications page (this should actually go to transactions tab)
    // FIXME (vjrj): Consider navigating directly to transactions tab instead
    ZelkovaApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
        '/notification-page',
        (Route<dynamic> route) =>
            (route.settings.name != '/notification-page') || route.isFirst,
        arguments: receivedAction);

    // Switch to transactions tab (SecondScreen - index 1)
    try {
      final BottomNavCubit? navCubit =
          ZelkovaApp.navigatorKey.currentContext?.read<BottomNavCubit>();
      navCubit?.getSecondScreen();
    } catch (e) {
      logger('Error switching to transactions tab from notification: $e');
    }
  }

  ///  *********************************************
  ///     REQUESTING NOTIFICATION PERMISSIONS
  ///  *********************************************
  ///
  /// Display permission rationale dialog.
  ///
  /// **Parameters:**
  /// - `allowPermissionPrompt`: If false, skips the dialog and returns false immediately
  ///   (used for background isolates where UI context is invalid)
  ///
  /// **Returns:** true if user authorized, false otherwise
  static Future<bool> displayNotificationRationale(
      {bool allowPermissionPrompt = true}) async {
    bool userAuthorized = false;

    // If permission prompts are disabled (e.g., background isolate), return false
    if (!allowPermissionPrompt) {
      return false;
    }

    // Check if context is available (guards against background isolate usage)
    final BuildContext? context = ZelkovaApp.navigatorKey.currentContext;
    if (context == null) {
      return false;
    }

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
      required double currentUd,
      String? walletPubKey}) async {
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
    await notify(title: title, desc: desc, id: id, walletPubKey: walletPubKey);
  }

  static Future<void> notify(
      {required String title,
      required String desc,
      required String id,
      String? walletPubKey}) async {
    if (kIsWeb) {
      // dart:html cannot be used in Android
    } else if (!kIsWeb && Platform.isLinux) {
      await _notifyLinux(title: title, desc: desc);
      return;
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
                  'https://raw.githubusercontent.com/papiche/zelkova/main/assets/img/logo.png',
              bigPicture:
                  'https://raw.githubusercontent.com/papiche/zelkova/main/assets/img/gbrevedot_color.png',
              //'asset://assets/images/balloons-in-sky.jpg',
              notificationLayout: NotificationLayout.BigPicture,
              payload: <String, String>{
                'notificationId': id,
                if (walletPubKey != null) 'walletPubKey': walletPubKey,
              }),
          actionButtons: <NotificationActionButton>[
            NotificationActionButton(
                key: 'notification_open', label: tr('notification_open')),
          ]);
    }
    return;
  }

  /// Check if notifications are currently allowed (permission granted).
  ///
  /// Returns: true if notification permission is granted, false otherwise
  static Future<bool> isNotificationAllowed() async {
    if (!kIsWeb && Platform.isLinux) {
      return true;
    }
    try {
      return await AwesomeNotifications().isNotificationAllowed();
    } catch (e) {
      return false;
    }
  }

  static Future<void> resetBadgeCounter() async {
    if (!kIsWeb && Platform.isLinux) {
      return;
    }
    await AwesomeNotifications().resetGlobalBadge();
  }

  static Future<void> cancelNotifications() async {
    if (!kIsWeb && Platform.isLinux) {
      return;
    }
    await AwesomeNotifications().cancelAll();
  }

  /// Send a native Linux desktop notification via DBus (freedesktop spec).
  /// Falls back to `notify-send` command if DBus fails.
  static Future<void> _notifyLinux(
      {required String title, required String desc}) async {
    try {
      final dn.NotificationsClient client = dn.NotificationsClient();
      try {
        await client.notify(title, body: desc, appName: 'Ẑelkova');
      } finally {
        await client.close();
      }
    } catch (e) {
      // Fallback to notify-send if DBus is unavailable
      debugPrint(
          '[NOTIFICATION] DBus notification failed ($e), trying notify-send');
      try {
        await Process.run('notify-send', <String>[
          '--app-name=Ẑelkova',
          title,
          desc,
        ]);
      } catch (e2) {
        debugPrint(
            '[NOTIFICATION] notify-send also failed ($e2): $title: $desc');
      }
    }
  }
}
