import 'package:flutter/material.dart';

import '../../g1/sing_and_send.dart';

class MenuAction {
  MenuAction({required this.name, required this.icon, required this.action});

  final String name;
  final IconData icon;
  final Future<SignAndSendResult> Function() action;
}
