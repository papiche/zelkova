import 'package:flutter/material.dart';

import '../ui_helpers.dart';

class FormErrorWidget extends StatelessWidget {
  const FormErrorWidget({
    super.key,
    required ValueNotifier<String> feedbackNotifier,
  }) : _feedbackNotifier = feedbackNotifier;

  final ValueNotifier<String> _feedbackNotifier;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      const SizedBox(height: 10.0),
      ValueListenableBuilder<String>(
        valueListenable: _feedbackNotifier,
        builder: (BuildContext context, String value, Widget? child) {
          if (value.isNotEmpty) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(Icons.error_outline, color: Colors.red),
                const SizedBox(width: 4),
                Text(
                  capitalize(value),
                  style: const TextStyle(color: Colors.red),
                ),
              ],
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      )
    ]);
  }
}
