import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget(
    this.error, {
    super.key,
  });

  final Object? error;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Text('Error: ${error ?? '?'}'),
    );
  }
}
