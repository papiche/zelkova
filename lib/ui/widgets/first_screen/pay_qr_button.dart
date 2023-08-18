import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/payment_cubit.dart';
import '../../../data/models/payment_state.dart';
import '../../pay_helper.dart';
import '../../qr_manager.dart';

class PayQrButton extends StatefulWidget {
  const PayQrButton({super.key});

  @override
  State<PayQrButton> createState() => _PayQrButtonState();
}

class _PayQrButtonState extends State<PayQrButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentCubit, PaymentState>(
        builder: (BuildContext context, PaymentState state) {
      if (state.contact == null || state.contact!.pubKey.isEmpty) {
        return ElevatedButton.icon(
          onPressed: () async {
            final String? scannedKey = await QrManager.qrScan(context);
            if (scannedKey is String &&
                scannedKey != null &&
                scannedKey != '-1') {
              if (!mounted) {
                return;
              }
              await onKeyScanned(context, scannedKey);
              if (!mounted) {
                return;
              }
              //Navigator.pop(context);
            }
          },
          icon: const Row(children: <Widget>[
            SizedBox(width: 5),
            Icon(Icons.qr_code_scanner)
          ]),
          label: const Text(''),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(30.0, 60.0),
            foregroundColor: Colors.white,
            backgroundColor: Theme.of(context).colorScheme.primary,
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
          ),
        );
      } else {
        // TODO put here other thing
        return const Text('');
      }
    });
  }
}
