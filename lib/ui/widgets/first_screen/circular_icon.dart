import 'package:flutter/material.dart';

class CircularIcon extends StatelessWidget {
  const CircularIcon({
    super.key,
    required this.iconData,
    this.size = 48,
    this.backgroundColor = Colors.grey,
    this.iconColor = Colors.white,
  });

  final IconData iconData;
  final double size;
  final Color backgroundColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
      ),
      child: Icon(
        iconData,
        color: iconColor,
        size: size * 0.6,
      ),
    );
  }
}
