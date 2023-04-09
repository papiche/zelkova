import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/node_list_cubit.dart';
import '../../../data/models/node_type.dart';
import '../../../data/models/payment_cubit.dart';
import '../../../data/models/payment_state.dart';
import '../../../data/models/transaction_cubit.dart';
import '../../../g1/api.dart';
import '../../logger.dart';
import '../../ui_helpers.dart';
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
      final Widget payBtnText = Text(tr('g1_form_pay_send') +
          (!kReleaseMode ? ' ${state.amount} ${state.comment}' : ''));
      return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const G1PayAmountField(),
            const SizedBox(height: 10.0),
            TextFormField(
              inputFormatters: <TextInputFormatter>[
                NoNewLineTextInputFormatter()
              ],
              controller: _commentController,
              onChanged: (String? value) {
                /* final bool validate = _commentValidate();
                if (validate != null &&
                    value != null &&
                    value.isNotEmpty &&
                    validate) {

                } */
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
            ),
            const SizedBox(height: 10.0),
            ConnectivityWidgetWrapper(
                stacked: false,
                offlineWidget: ElevatedButton(
                  onPressed: null,
                  style: payBtnStyle,
                  child: _buildBtn(Text(tr('offline'))),
                ),
                child: ElevatedButton(
                  onPressed: (!state.canBeSent() ||
                          state.amount == null ||
                          !_commentValidate() ||
                          !_weHaveBalance(context, state.amount!))
                      ? null
                      : () async {
                          try {
                            await payWithRetry(context, state, false);
                          } on RetryException {
                            // Here the transactions can be lost, so we must implement some manual retry use
                            await payWithRetry(context, state, true);
                          }
                        },
                  style: payBtnStyle,
                  child: _buildBtn(payBtnText),
                ))
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
    return val;
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

  Future<void> payWithRetry(
      BuildContext context, PaymentState state, bool useMempool) async {
    logger('Trying to pay state with useMempool: $useMempool');
    // We disable the number, anyway
    context.read<PaymentCubit>().sending();
    final String contactPubKey = state.contact!.pubKey;
    final bool? confirmed = await _confirmSend(
        context, state.amount.toString(), humanizePubKey(contactPubKey));
    if (!mounted) {
      return;
    }
    if (confirmed == null || !confirmed) {
      context.read<PaymentCubit>().sentFailed();
    } else {
      final String response = await pay(
          to: contactPubKey, comment: state.comment, amount: state.amount!);
      if (!mounted) {
        // Cannot show a tooltip if the widget is not now visible
        return;
      }
      if (response == 'success') {
        context.read<PaymentCubit>().sent();
        showTooltip(
            context, tr('payment_successful'), tr('payment_successful_desc'));
      } else {
        /* this retry didn't work
        if (!useMempool) {
          throw RetryException();
        } */
        final bool failedWithBalance = response == 'insufficient balance' &&
            _weHaveBalance(context, state.amount!);
        showPayError(
            context,
            failedWithBalance
                ? tr('payment_error_retry')
                : tr('payment_error_desc', namedArgs: <String, String>{
                    // We try to translate the error, like "insufficient balance"
                    'error': tr(response)
                  }));
      }
    }
  }

  void showPayError(BuildContext context, String desc) {
    showTooltip(context, tr('payment_error'), desc);
    context.read<PaymentCubit>().sentFailed();
    // Shuffle the nodes so we can retry with other
    context.read<NodeListCubit>().shuffle(NodeType.gva, true);
  }
}

class RetryException implements Exception {
  RetryException();
}

class NoNewLineTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final String newText = newValue.text.replaceAll('\n', '');
    return TextEditingValue(
      text: newText,
      selection: newValue.selection.copyWith(
        baseOffset: newText.length,
        extentOffset: newText.length,
      ),
    );
  }
}
