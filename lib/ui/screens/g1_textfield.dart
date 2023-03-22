import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../data/models/payment_cubit.dart';
import '../../data/models/payment_state.dart';

class G1PayAmountField extends StatefulWidget {
  const G1PayAmountField({super.key});

  @override
  State<G1PayAmountField> createState() => _G1PayAmountFieldState();
}

class _G1PayAmountFieldState extends State<G1PayAmountField> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) => BlocBuilder<PaymentCubit, PaymentState>(
          builder: (BuildContext context, PaymentState state) {
        if (state.amount != null &&
            _controller.text != state.amount.toString()) {
          _controller.text = '${state.amount}';
        }
        return Form(
            key: _formKey,
            child: TextFormField(
              controller: _controller,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              /* inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
          ], */
              validator: validateDecimal,
              onEditingComplete: () {},
              onChanged: (String? value) {
                final bool? validate = _formKey.currentState?.validate();
                if (validate != null &&
                    validate &&
                    value != null &&
                    double.tryParse(value) != null) {
                  context
                      .read<PaymentCubit>()
                      .selectAmount(value.isEmpty ? null : double.parse(value));
                }
              },
              decoration: InputDecoration(
                labelText: tr('g1_amount'),
                hintText: tr('g1_amount_hint'),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset(
                    colorFilter: ColorFilter.mode(
                        Colors.purple.shade600, BlendMode.srcIn),
                    'assets/img/gbrevedot.svg',
                    width: 20.0,
                    height: 20.0,
                  ),
                ),
                border: const OutlineInputBorder(),
              ),
            ));
      });

  String? validateDecimal(String? value) {
    if (value == null || value.isEmpty) {
      return tr('g1_amount_hint');
    }
    final num? n = num.tryParse(value);
    if (n == null) {
      return tr('enter_a_valid_number');
    }
    if (n <= 0) {
      return tr('enter_a_positive_number');
    }
    return null;
  }
}
