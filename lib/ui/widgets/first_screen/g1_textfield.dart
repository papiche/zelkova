import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../data/models/app_cubit.dart';
import '../../../data/models/payment_cubit.dart';
import '../../../data/models/payment_state.dart';
import '../../../g1/currency.dart';
import '../../currency_helper.dart';
import '../../locale_helper.dart';
import '../../ui_helpers.dart';

class _ShadowToggleSwitch extends StatelessWidget {
  const _ShadowToggleSwitch({
    required this.minWidth,
    required this.radiusStyle,
    required this.initialLabelIndex,
    required this.cornerRadius,
    required this.activeFgColor,
    required this.inactiveBgColor,
    required this.inactiveFgColor,
    required this.totalSwitches,
    required this.labels,
    required this.iconSize,
    required this.borderWidth,
    required this.borderColor,
    required this.activeBgColors,
    required this.onToggle,
    required this.toggleKey,
  });

  final double minWidth;
  final bool radiusStyle;
  final int initialLabelIndex;
  final double cornerRadius;
  final Color activeFgColor;
  final Color? inactiveBgColor;
  final Color inactiveFgColor;
  final int totalSwitches;
  final List<String> labels;
  final double iconSize;
  final double borderWidth;
  final List<Color> borderColor;
  final List<List<Color>> activeBgColors;
  final Function(int?) onToggle;
  final String toggleKey;

  @override
  Widget build(BuildContext context) {
    return ToggleSwitch(
      key: ValueKey<String>(toggleKey),
      minWidth: minWidth,
      radiusStyle: radiusStyle,
      initialLabelIndex: initialLabelIndex,
      cornerRadius: cornerRadius,
      activeFgColor: activeFgColor,
      inactiveBgColor: inactiveBgColor,
      inactiveFgColor: inactiveFgColor,
      totalSwitches: totalSwitches,
      labels: labels,
      iconSize: iconSize,
      fontSize: 12.0,
      borderWidth: borderWidth,
      borderColor: borderColor,
      activeBgColors: activeBgColors,
      customTextStyles: <TextStyle>[
        TextStyle(
          color: activeFgColor,
          fontSize: 14.0,
          shadows: const <Shadow>[
            Shadow(
              offset: Offset(0.5, 0.5),
              blurRadius: 1.0,
              color: Color.fromARGB(150, 255, 255, 255),
            ),
          ],
        ),
        TextStyle(
          color: inactiveFgColor,
          fontSize: 14.0,
          shadows: const <Shadow>[
            Shadow(
              offset: Offset(0.5, 0.5),
              blurRadius: 1.0,
              color: Color.fromARGB(150, 255, 255, 255),
            ),
          ],
        ),
      ],
      onToggle: onToggle,
    );
  }
}

class G1PayAmountField extends StatefulWidget {
  const G1PayAmountField({super.key});

  @override
  State<G1PayAmountField> createState() => _G1PayAmountFieldState();
}

class _G1PayAmountFieldState extends State<G1PayAmountField> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(
    debugLabel: 'g1PayAmountField',
  );
  late String sep;
  late String locale;
  late Currency _paymentCurrency;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onAmountChanged);
    // Initialize payment currency from PaymentCubit (independent from display currency)
    _paymentCurrency = context.read<PaymentCubit>().state.currency;
  }

  void _switchPaymentCurrency() {
    setState(() {
      _paymentCurrency =
          _paymentCurrency == Currency.G1 ? Currency.DU : Currency.G1;

      // Update the payment state with the new currency if there's an amount
      final PaymentCubit paymentCubit = context.read<PaymentCubit>();
      if (paymentCubit.state.amount != null) {
        paymentCubit.selectAmountWithCurrency(
          paymentCubit.state.amount,
          _paymentCurrency,
        );
      }
    });
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
        locale: context.locale.toLanguageTag(),
        number: newValue,
      );
      if (newAmount != context.read<PaymentCubit>().state.amount) {
        context
            .read<PaymentCubit>()
            .selectAmountWithCurrency(newAmount, _paymentCurrency);
      }
    } else {
      final double? newAmount = double.tryParse(newValue);
      if (newAmount != context.read<PaymentCubit>().state.amount) {
        context
            .read<PaymentCubit>()
            .selectAmountWithCurrency(newAmount, _paymentCurrency);
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
              TextPosition(offset: _controller.text.length),
            );
          }
        } else {
          if (state.status == PaymentStatus.isSent) {
            _controller.text = '';
            // This set status to not sent
            context.read<PaymentCubit>().selectAmount(null);
          }
        }

        final bool expertMode = context.read<AppCubit>().isExpertMode;
        final bool enableCurrencies = expertMode;
        final Currency currentCurrency = _paymentCurrency;

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
                context.read<PaymentCubit>().selectAmountWithCurrency(
                      parseToDoubleLocalized(
                        locale: context.locale.toLanguageTag(),
                        number: value,
                      ),
                      _paymentCurrency,
                    );
              }
            },
            decoration: InputDecoration(
              labelText: tr('g1_amount'),
              hintText: 'g1_amount_hint'.tr(
                namedArgs: <String, String>{'currency': currentCurrency.name()},
              ),
              contentPadding: const EdgeInsets.fromLTRB(16, 0, 10, 10),
              border: const OutlineInputBorder(),
              suffix: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: _ShadowToggleSwitch(
                  toggleKey: 'toggle_${currentCurrency.name()}',
                  minWidth: 40.0,
                  radiusStyle: true,
                  initialLabelIndex: enableCurrencies
                      ? currentCurrency == Currency.G1
                          ? 0
                          : 1
                      : 0,
                  cornerRadius: 20.0,
                  activeFgColor: Colors.black,
                  inactiveBgColor: Colors.grey[400],
                  inactiveFgColor: Colors.black,
                  totalSwitches: enableCurrencies ? 2 : 1,
                  labels: enableCurrencies
                      ? const <String>['Ğ1', 'DU']
                      : const <String>['Ğ1'],
                  iconSize: 30.0,
                  borderWidth: 1.0,
                  borderColor: const <Color>[Colors.grey],
                  activeBgColors: const <List<Color>>[
                    <Color>[Color(0xFFFFD949)],
                    <Color>[Color(0xFFFFD949)],
                  ],
                  onToggle: (int? index) {
                    _switchPaymentCurrency();
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
        TextPosition(offset: _controller.text.length),
      );
      value = _controller.text;
    }
    return validateDecimal(
      sep: sep,
      locale: locale,
      amount: value,
      tr: (String s) => tr(s),
    );
  }
}
