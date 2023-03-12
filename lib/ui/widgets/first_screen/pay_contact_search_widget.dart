import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/payment_cubit.dart';
import '../../../data/models/payment_state.dart';
import 'pay_contact_search_dialog.dart';
import 'recipient_widget.dart';

class PayContactSearchWidget extends StatefulWidget {
  const PayContactSearchWidget({super.key});

  @override
  State<PayContactSearchWidget> createState() => _PayContactSearchWidgetState();
}

class _PayContactSearchWidgetState extends State<PayContactSearchWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentCubit, PaymentState>(
        builder: (BuildContext context, PaymentState state) {
      if (state.publicKey.isEmpty) {
        return ElevatedButton.icon(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const SearchDialog();
              },
            );
          },
          icon: Row(
            children: <Widget>[
              const Icon(Icons.search, color: Colors.white),
              const SizedBox(width: 8.0),
              Text(tr('search_user_btn')),
            ],
          ),
          label: const Icon(Icons.qr_code_scanner),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 60.0),
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
        return const RecipientWidget();
      }
    });
  }
}
