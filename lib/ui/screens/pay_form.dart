import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'g1_textfield.dart';

class PayForm extends StatefulWidget {
  const PayForm({super.key});

  @override
  State<PayForm> createState() => _PayFormState();
}

class _PayFormState extends State<PayForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          G1PayAmountField(controller: _controller),
          const SizedBox(height: 10.0),
          TextField(
            controller: _controller,
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
  }
}
