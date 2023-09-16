import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../data/models/app_cubit.dart';
import '../../../data/models/payment_cubit.dart';
import '../../../data/models/payment_state.dart';
import '../../../g1/currency.dart';
import '../../ui_helpers.dart';

class G1PayAmountField extends StatefulWidget {
  const G1PayAmountField({super.key});

  @override
  State<G1PayAmountField> createState() => _G1PayAmountFieldState();
}

class _G1PayAmountFieldState extends State<G1PayAmountField> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String sep;
  late String locale;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onAmountChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onAmountChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onAmountChanged() {
    final String newValue = _controller.text;
    final bool? validate = _formKey.currentState?.validate();
    if (validate != null &&
        newValue != null &&
        newValue.isNotEmpty &&
        validate) {
      final double newAmount = parseToDoubleLocalized(
          locale: context.locale.toLanguageTag(), number: newValue);
      if (newAmount != context.read<PaymentCubit>().state.amount) {
        context.read<PaymentCubit>().selectAmount(newAmount);
      }
    } else {
      final double? newAmount =
          newValue == null ? null : double.tryParse(newValue);
      if (newAmount != context.read<PaymentCubit>().state.amount) {
        context.read<PaymentCubit>().selectAmount(newAmount);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    sep = decimalSep(context);
    locale = currentLocale(context);

    return BlocBuilder<PaymentCubit, PaymentState>(
      builder: (BuildContext context, PaymentState state) {
        if (state.amount != null) {
          final String amountFormatted = localizeNumber(context, state.amount!);
          if (_controller.text != amountFormatted) {
            _controller.text = amountFormatted;
            _controller.selection = TextSelection.fromPosition(
                TextPosition(offset: _controller.text.length));
          }
        } else {
          if (state.status == PaymentStatus.isSent) {
            _controller.text = '';
            // This set status to not sent
            context.read<PaymentCubit>().selectAmount(null);
          }
        }
        final Currency currentCurrency = context.watch<AppCubit>().currency;

        return Form(
          key: _formKey,
          child: TextFormField(
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            controller: _controller,
            validator: validateDecimalAndFixInitialSep,
            autofillHints: const <String>[],
            onEditingComplete: () {},
            onChanged: (String? value) {
              final bool? validate = _formKey.currentState?.validate();
              if (validate != null &&
                  value != null &&
                  value.isNotEmpty &&
                  validate) {
                context.read<PaymentCubit>().selectAmount(
                    parseToDoubleLocalized(
                        locale: context.locale.toLanguageTag(), number: value));
              } else {
                context.read<PaymentCubit>().selectAmount(
                    value == null ? null : double.tryParse(value));
              }
            },
            decoration: InputDecoration(
              labelText: tr('g1_amount'),
              hintText: 'g1_amount_hint'.tr(namedArgs: <String, String>{
                'currency': currentCurrency.name()
              }),
              contentPadding: const EdgeInsets.fromLTRB(16, 0, 10, 10),
              border: const OutlineInputBorder(),
              suffix: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: ToggleSwitch(
                  minWidth: 40.0,
                  radiusStyle: true,
                  // initialLabelIndex: 0,
                  cornerRadius: 20.0,
                  activeFgColor: Colors.black,
                  inactiveBgColor: Colors.grey[400],
                  inactiveFgColor: Colors.white,
                  totalSwitches: 1,
                  labels: <String>[
                    if (currentCurrency == Currency.G1) 'Ğ1' else 'DU'
                  ],
                  iconSize: 30.0,
                  borderWidth: 1.0,
                  borderColor: const <Color>[Colors.grey],
                  activeBgColors: const <List<Color>>[
                    <Color>[Color(0xFFFFD949)],
                    <Color>[Color(0xFFFFD949)],
                  ],
                  onToggle: (int? index) {
                    // context.read<AppCubit>().switchCurrency();
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String? validateDecimalAndFixInitialSep(String? value) {
    if (_controller.text.startsWith(sep)) {
      _controller.text = '0${_controller.text}';
      _controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length));
      value = _controller.text;
    }
    return validateDecimal(
        sep: sep, locale: locale, amount: value, tr: (String s) => tr(s));
  }
}
