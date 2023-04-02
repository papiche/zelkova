import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../data/models/payment_cubit.dart';
import '../../data/models/payment_state.dart';
import '../ui_helpers.dart';

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
        if (state.amount != null) {
          final String amountFormatted = localizeNumber(context, state.amount!);
          if (_controller.text != amountFormatted) {
            _controller.text = amountFormatted;
            _controller.selection = TextSelection.fromPosition(
                TextPosition(offset: _controller.text.length));
          }
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
                    value != null &&
                    value.isNotEmpty &&
                    validate) {
                  context.read<PaymentCubit>().selectAmount(
                      parseToDoubleLocalized(
                          context.locale.toLanguageTag(), value));
                } else {
                  context.read<PaymentCubit>().selectAmount(
                      value == null ? null : double.tryParse(value));
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
    final NumberFormat format =
        NumberFormat.decimalPattern(context.locale.toString());
    if (value == null || value.isEmpty) {
      return null;
    }
    try {
      final num n = format.parse(value);
      if (n <= 0) {
        return tr('enter_a_positive_number');
      }
    } catch (e) {
      return tr('enter_a_valid_number');
    }
    return null;
  }
}
