import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/payment_cubit.dart';
import '../../../data/models/payment_state.dart';
import '../../../data/models/transaction_cubit.dart';
import '../../logger.dart';
import '../../pay_helper.dart';
import '../../tutorial_keys.dart';
import '../../ui_helpers.dart';
import '../connectivity_widget_wrapper_wrapper.dart';
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
      if (state.comment != null && _commentController.text != state.comment) {
        _commentController.text = state.comment;
      }

      if (state.amount == null || state.amount == 0) {
        _feedbackNotifier.value = '';
      }
      final ButtonStyle payBtnStyle = ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        foregroundColor: Colors.white,
        backgroundColor: Theme.of(context).colorScheme.primary,
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      );
      final Widget payBtnText = Text(tr(
          'g1_form_pay_send')); // + (!kReleaseMode ? ' ${state.status}' : ''));
      return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            G1PayAmountField(key: payAmountKey),
            const SizedBox(height: 10.0),
            TextFormField(
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
                if (value != null && !basicEnglishCharsRegExp.hasMatch(value)) {
                  return tr('valid_comment');
                }
                return null;
              },
              // Disallow autocomplete
              autofillHints: const <String>[],
            ),
            const SizedBox(height: 10.0),
            ConnectivityWidgetWrapperWrapper(
                stacked: false,
                offlineWidget: ElevatedButton(
                  onPressed: null,
                  style: payBtnStyle,
                  child: _buildBtn(Text(tr('offline'))),
                ),
                child: ElevatedButton(
                  key: paySentKey,
                  onPressed: (!state.canBeSent() ||
                          state.amount == null ||
                          !_commentValidate() ||
                          !_weHaveBalance(context, state.amount!))
                      ? null
                      : () async {
                          try {
                            await payWithRetry(context, state.contact!,
                                state.amount!, state.comment, false, true);
                          } on RetryException {
                            // Here the transactions can be lost, so we must implement some manual retry use
                            await payWithRetry(context, state.contact!,
                                state.amount!, state.comment, true, true);
                          }
                        },
                  style: payBtnStyle,
                  child: _buildBtn(payBtnText),
                )),
            const SizedBox(height: 8),
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

  Row _buildBtn(Widget payBtnText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Icon(Icons.send),
        const SizedBox(width: 10),
        payBtnText,
      ],
    );
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

  bool _weHaveBalance(BuildContext context, double amount) {
    final double balance = getBalance(context);
    logger('We have $balance, need $amount');
    final bool weHave = balance >= amount * 100;

    if (!weHave) {
      _feedbackNotifier.value = tr('insufficient balance');
    } else {
      _feedbackNotifier.value = '';
    }
    return weHave;
  }

  double getBalance(BuildContext context) =>
      context.read<TransactionCubit>().balance;
}

class RetryException implements Exception {
  RetryException();
}

class NoNewLineTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
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
