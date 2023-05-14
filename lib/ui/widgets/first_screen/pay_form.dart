import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/app_cubit.dart';
import '../../../data/models/payment_cubit.dart';
import '../../../data/models/payment_state.dart';
import '../../../data/models/transaction_cubit.dart';
import '../../../g1/currency.dart';
import '../../logger.dart';
import '../../pay_helper.dart';
import '../../tutorial_keys.dart';
import '../../ui_helpers.dart';
import 'g1_textfield.dart';

class PayForm extends StatefulWidget {
  const PayForm({super.key});

  @override
  State<PayForm> createState() => _PayFormState();
}

class _PayFormState extends State<PayForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _formCommentKey =
  GlobalKey<FormFieldState<String>>();
  final TextEditingController _commentController = TextEditingController();
  final ValueNotifier<String> _feedbackNotifier = ValueNotifier<String>('');

  @override
  void dispose() {
    _commentController.dispose();
    _feedbackNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentCubit, PaymentState>(
        builder: (BuildContext context, PaymentState state) {
          final AppCubit appCubit = context.watch<AppCubit>();
          final double currentUd = appCubit.currentUd;
          final Currency currency = appCubit.currency;
          if (state.comment != null &&
              _commentController.text != state.comment) {
            _commentController.text = state.comment;
          }
          if (state.amount == null || state.amount == 0) {
            _feedbackNotifier.value = '';
          }

          final bool sentDisabled =
              _onPressed(state, context, currency, currentUd) == null;
          final Color sentColor =
          sentDisabled ? Colors.grey : Theme
              .of(context)
              .primaryColor;
          return Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 10.0),
                G1PayAmountField(key: payAmountKey),
                const SizedBox(height: 10.0),
                Row(children: <Widget>[
                  Expanded(
                      child: TextFormField(
                        key: _formCommentKey,
                        inputFormatters: <TextInputFormatter>[
                          NoNewLineTextInputFormatter()
                        ],
                        controller: _commentController,
                        onChanged: (String? value) {
                          context.read<PaymentCubit>().setComment(value ?? '');
                        },
                        decoration: InputDecoration(
                          labelText: tr('g1_form_pay_desc'),
                          hintText: tr('g1_form_pay_hint'),
                          border: const OutlineInputBorder(),
                        ),
                        validator: (String? value) {
                          if (value != null &&
                              !basicEnglishCharsRegExp.hasMatch(value)) {
                            return tr('valid_comment');
                          }
                          return null;
                        },
                        // Disallow autocomplete
                        autofillHints: const <String>[],
                      )),
                  const SizedBox(width: 5.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Material(
                        color: Colors.transparent,
                        child: IgnorePointer(
                          ignoring: sentDisabled,
                          child: IconTheme(
                            data: const IconThemeData(size: 40.0),
                            child: IconButton(
                              key: paySentKey,
                              tooltip: tr('g1_form_pay_send'),
                              icon: Icon(
                                Icons.send,
                                color: sentColor,
                              ),
                              onPressed:
                              _onPressed(state, context, currency, currentUd),
                              splashRadius: 20,
                              splashColor: Colors.white.withOpacity(0.5),
                              highlightColor: Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        tr('g1_form_pay_send'),
                        style: TextStyle(fontSize: 12, color: sentColor),
                      ),
                    ],
                  ),
                ]),
                const SizedBox(height: 10.0),
                ValueListenableBuilder<String>(
                  valueListenable: _feedbackNotifier,
                  builder: (BuildContext context, String value, Widget? child) {
                    if (value.isNotEmpty) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Icon(Icons.error_outline, color: Colors.red),
                          const SizedBox(width: 4),
                          Text(
                            capitalize(value),
                            style: const TextStyle(color: Colors.red),
                          ),
                        ],
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ],
            ),
          );
        });
  }

  Future<void> Function()? _onPressed(PaymentState state, BuildContext context,
      Currency currency, double currentUd) {
    final bool isG1 = currency == Currency.G1;
    return (!state.canBeSent() ||
        state.amount == null ||
        !_commentValidate() ||
        !_weHaveBalance(context, state.amount!, currency, currentUd))
        ? null
        : () async {
      try {
        await payWithRetry(
            context: context,
            to: state.contact!,
            amount: state.amount!,
            isG1: isG1,
            currentUd: currentUd,
            comment: state.comment);
      } on RetryException {
        // Here the transactions can be lost, so we must implement some manual retry use

        await payWithRetry(
            context: context,
            to: state.contact!,
            amount: state.amount!,
            isG1: isG1,
            currentUd: currentUd,
            comment: state.comment,
            useMempool: true);
      }
    };
  }

  bool _commentValidate() {
    final String currentComment = _commentController.value.text;
    final bool val = (currentComment != null &&
        basicEnglishCharsRegExp.hasMatch(currentComment)) ||
        currentComment.isEmpty;
    logger('Validating comment: $val');
    if (_formKey.currentState != null) {
      _formKey.currentState!.validate();
    }
    return val;
  }

  bool _weHaveBalance(BuildContext context, double amount, Currency currency,
      double currentUd) {
    final double balance =
    convertAmount(currency == Currency.G1, getBalance(context), currentUd);
    logger('We have $balance G1, need $amount');
    final bool weHave = balance >= amount;

    if (!weHave) {
      _feedbackNotifier.value = tr('insufficient balance');
    } else {
      _feedbackNotifier.value = '';
    }
    return weHave;
  }

  double getBalance(BuildContext context) =>
      context
          .watch<TransactionCubit>()
          .balance;
}

class RetryException implements Exception {
  RetryException();
}

class NoNewLineTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue,
      TextEditingValue newValue) {
    final int cursorPosition = newValue.selection.baseOffset;
    final String newText = newValue.text.replaceAll('\n', '');
    final TextSelection newSelection =
    TextSelection.collapsed(offset: cursorPosition);
    return TextEditingValue(
      text: newText,
      selection: newSelection,
    );
  }
}
