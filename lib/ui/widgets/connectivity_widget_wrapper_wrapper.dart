import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/widgets.dart';

import '../ui_helpers.dart';

class ConnectivityWidgetWrapperWrapper extends ConnectivityWidgetWrapper {
  ConnectivityWidgetWrapperWrapper(
      {super.key,
      Widget? offlineWidget,
      required super.child,
      super.stacked,
      super.disableInteraction,
      super.message,
      super.height})
      : super(offlineWidget: isIOS ? child : offlineWidget);

  // This package does not work in IOS so we just return true
  static Future<bool> get isConnected => isIOS
      ? Future<bool>.value(true)
      : ConnectivityWrapper.instance.isConnected;
}
