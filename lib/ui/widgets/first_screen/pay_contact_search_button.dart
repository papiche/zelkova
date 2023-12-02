import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/payment_cubit.dart';
import '../../../data/models/payment_state.dart';
import 'contact_search_page.dart';
import 'pay_recipient_widget.dart';

class PayContactSearchButton extends StatefulWidget {
  const PayContactSearchButton({super.key});

  @override
  State<PayContactSearchButton> createState() => _PayContactSearchButtonState();
}

class _PayContactSearchButtonState extends State<PayContactSearchButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentCubit, PaymentState>(
        builder: (BuildContext context, PaymentState state) {
      if (state.contacts.isEmpty || state.contacts[0].pubKey.isEmpty) {
        return ElevatedButton.icon(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const ContactSearchPage();
              },
            );
          },
          icon: const Icon(Icons.search, color: Colors.white),
          label: Text(tr('search_user_btn')),
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
        return const PayRecipientWidget();
      }
    });
  }
}
