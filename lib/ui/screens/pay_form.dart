import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/payment_cubit.dart';
import '../../data/models/payment_state.dart';
import 'g1_textfield.dart';

class PayForm extends StatefulWidget {
  const PayForm({super.key});

  @override
  State<PayForm> createState() => _PayFormState();
}

class _PayFormState extends State<PayForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentCubit, PaymentState>(
        builder: (BuildContext context, PaymentState state) {
      _amountController.text = state.amount != null ? '${state.amount}' : '';
      return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            G1PayAmountField(controller: _amountController),
            const SizedBox(height: 10.0),
            TextField(
              controller: _descController,
              decoration: InputDecoration(
                labelText: tr('g1_form_pay_desc'),
                hintText: tr('g1_form_pay_hint'),
                border: const OutlineInputBorder(),
              ),
              maxLines: null,
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed:
                  null /* () {
              if (_formKey.currentState != null &&
                  _formKey.currentState!.validate()) {
                // Enviar formulario
              }
            }, */
              ,
              child: Text(tr('g1_form_pay_send')),
            ),
          ],
        ),
      );
    });
  }
}
