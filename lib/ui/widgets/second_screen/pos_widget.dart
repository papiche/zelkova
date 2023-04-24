import 'package:flutter/material.dart';

class POSWidget extends StatelessWidget {
  const POSWidget({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      //width: MediaQuery.of(context).size.width < smallScreenWidth ? 200 : 200,
      'assets/img/pos.png',
    );
  }
}
