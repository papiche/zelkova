import 'package:flutter/material.dart';

class MenuAction {
  MenuAction({required this.name, required this.icon, required this.action});

  final String name;
  final IconData icon;
  final Future<String> Function() action;
}
