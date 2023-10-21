import 'package:flutter/material.dart';

import '../../pay_helper.dart';
import '../generic_qr_button.dart';

class PayQrButton extends StatelessWidget {
  const PayQrButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GenericQrButton(
        onKeyScanned: (String key) => onKeyScanned(context, key));
  }
}
