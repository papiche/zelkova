import 'dart:io';

import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class ConnectivityWidgetWrapperWrapper extends ConnectivityWidgetWrapper {
  ConnectivityWidgetWrapperWrapper(
      {super.key,
      Widget? offlineWidget,
      required super.child,
      super.stacked,
      super.message,
      super.height})
      : super(offlineWidget: !kIsWeb && Platform.isIOS ? child : offlineWidget);
}
