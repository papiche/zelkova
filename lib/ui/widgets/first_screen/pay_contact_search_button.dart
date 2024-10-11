import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/payment_cubit.dart';
import '../../../data/models/payment_state.dart';
import 'contact_search_page.dart';
import 'pay_recipient_widget.dart';

class PayContactSearchButton extends StatefulWidget {
  const PayContactSearchButton(
      {super.key, required this.btnText, required this.searchUse});

  final String btnText;
  final SearchUse searchUse;

  @override
  State<PayContactSearchButton> createState() => _PayContactSearchButtonState();
}

class _PayContactSearchButtonState extends State<PayContactSearchButton> {
  @override
  Widget build(BuildContext context) {
    final bool notForPayment = widget.searchUse == SearchUse.marketAnalysis;
    return BlocBuilder<PaymentCubit, PaymentState>(
        builder: (BuildContext context, PaymentState state) {
      if (state.contacts.isEmpty || state.contacts[0].pubKey.isEmpty) {
        return ElevatedButton.icon(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return ContactSearchPage(
                    startInMultiSelect:
                        widget.searchUse == SearchUse.marketAnalysis,
                    searchUse: widget.searchUse);
              },
            );
          },
          icon: Icon(notForPayment ? Icons.travel_explore : Icons.search,
              color: notForPayment ? null : Colors.white),
          label: Text(widget.btnText),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 60.0),
            foregroundColor: notForPayment ? null : Colors.white,
            backgroundColor:
                notForPayment ? null : Theme.of(context).colorScheme.primary,
            padding: notForPayment
                ? null
                : const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            shape: notForPayment
                ? null
                : RoundedRectangleBorder(
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
