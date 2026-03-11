import 'package:flutter/material.dart';
import 'ui_helpers.dart';
import 'widgets/first_screen/circular_icon.dart';

class BasicAvatar extends StatelessWidget {
  const BasicAvatar(
      {super.key,
      this.color = defAvatarColor,
      this.bgColor = defAvatarBgColor});
  final Color color;
  final Color bgColor;
  @override
  Widget build(BuildContext context) {
    return CircularIcon(
        iconData: Icons.person, backgroundColor: color, iconColor: bgColor);
  }
}
