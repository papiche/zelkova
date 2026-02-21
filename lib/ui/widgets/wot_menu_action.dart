import 'package:flutter/material.dart';

import '../../g1/sign_and_send.dart';

class WotMenuAction {
  WotMenuAction(
      {required this.name,
      required this.icon,
      required this.action,
      this.color});

  final String name;
  final IconData icon;
  final Color? color;
  final Future<SignAndSendResult> Function() action;
}
