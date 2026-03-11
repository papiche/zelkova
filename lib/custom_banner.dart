import 'package:flutter/material.dart';

class CustomBanner extends StatelessWidget {
  const CustomBanner({
    super.key,
    required this.child,
    required this.message,
    this.color = Colors.red,
    this.location = BannerLocation.topEnd,
  });

  final Widget child;
  final String message;
  final Color color;
  final BannerLocation location;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        child,
        CustomPaint(
          painter: BannerPainter(
            textDirection: Directionality.of(context),
            layoutDirection: Directionality.of(context),
            location: BannerLocation.bottomEnd,
            color: color,
            textStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
            ),
            message: message,
          ),
          child: Container(),
        ),
      ],
    );
  }
}
