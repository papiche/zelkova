import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/payment_cubit.dart';
import '../../data/models/payment_state.dart';
import '../../data/models/transaction_cubit.dart';
import '../../g1/api.dart';
import '../ui_helpers.dart';
import 'g1_textfield.dart';

class PayForm extends StatefulWidget {
  const PayForm({super.key});

  @override
  State<PayForm> createState() => _PayFormState();
}

class _PayFormState extends State<PayForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentCubit, PaymentState>(
        builder: (BuildContext context, PaymentState state) {
      if (state.comment != null && _commentController.text != state.comment) {
        _commentController.text = state.comment;
      }
      return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const G1PayAmountField(),
            const SizedBox(height: 10.0),
            TextField(
              controller: _commentController,
              onChanged: (String? value) {
                if (value != null) {
                  context.read<PaymentCubit>().setDescription(value);
                }
              },
              decoration: InputDecoration(
                labelText: tr('g1_form_pay_desc'),
                hintText: tr('g1_form_pay_hint'),
                border: const OutlineInputBorder(),
              ),
              maxLines: null,
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: !state.canBeSent() ||
                      state.amount == null ||
                      !_weHaveBalance(context, state.amount!)
                  ? null
                  : () async {
                      // We disable the number, anyway
                      context.read<PaymentCubit>().sending();
                      final bool? confirmed = await _confirmSend(
                          context,
                          state.amount!.toString(),
                          humanizePubKey(state.publicKey));
                      if (!mounted) {
                        return;
                      }
                      if (confirmed == null || !confirmed) {
                        context.read<PaymentCubit>().sentFailed();
                      } else {
                        final String response = await pay(
                            to: state.publicKey,
                            comment: state.comment,
                            amount: state.amount!);
                        if (!mounted) {
                          // Cannot show a tooltip if the widget is not now visible
                          return;
                        }
                        if (response == 'success') {
                          context.read<PaymentCubit>().sent();
                          showTooltip(context, '', tr('payment_successful'));
                        } else {
                          context.read<PaymentCubit>().sentFailed();
                          showTooltip(context, '', tr(response));
                        }
                      }
                    },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                foregroundColor: Colors.white,
                backgroundColor: Theme.of(context).colorScheme.primary,
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Icon(Icons.send),
                  const SizedBox(width: 10),
                  Text(tr('g1_form_pay_send')),
                ],
              ),
            )
          ],
        ),
      );
    });
  }

  bool _weHaveBalance(BuildContext context, double amount) =>
      context.read<TransactionsCubit>().balance >= amount * 100;

  Future<bool?> _confirmSend(
      BuildContext context, String amount, String to) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(tr('please_confirm_sent')),
          content: Text(tr('please_confirm_sent_desc',
              namedArgs: <String, String>{'amount': amount, 'to': to})),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(tr('cancel')),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(tr('yes_sent')),
            ),
          ],
        );
      },
    );
  }
}
