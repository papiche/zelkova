import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/foundation.dart';
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
  // Also does not detect well in web production mode
  static Future<bool> get isConnected => kIsWeb || isIOS
      ? Future<bool>.value(true)
      : ConnectivityWrapper.instance.isConnected;
}
