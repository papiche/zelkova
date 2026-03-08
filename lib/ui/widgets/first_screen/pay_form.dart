import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/app_cubit.dart';
import '../../../data/models/multi_wallet_transaction_cubit.dart';
import '../../../data/models/payment_cubit.dart';
import '../../../data/models/payment_state.dart';
import '../../../g1/currency.dart';
import '../../currency_helper.dart';
import '../../logger.dart';
import '../../pay_helper.dart';
import '../../tutorial_keys.dart';
import '../../ui_helpers.dart';
import '../form_error_widget.dart';
import 'g1_textfield.dart';

class PayForm extends StatefulWidget {
  const PayForm({super.key});

  @override
  State<PayForm> createState() => _PayFormState();
}

class _PayFormState extends State<PayForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(
    debugLabel: 'PayForm',
  );
  final GlobalKey<FormFieldState<String>> _formCommentKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey _emojiPickerKey = GlobalKey();
  final TextEditingController _commentController = TextEditingController();
  final ValueNotifier<String> _feedbackNotifier = ValueNotifier<String>('');
  bool _showEmojiPicker = false;
  late final FocusNode _commentFocusNode;

  @override
  void initState() {
    super.initState();
    _commentFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _commentController.dispose();
    _commentFocusNode.dispose();
    _feedbackNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext cp) {
    return BlocBuilder<PaymentCubit, PaymentState>(
      builder: (BuildContext context, PaymentState state) {
        final AppCubit appCubit = context.watch<AppCubit>();
        final MultiWalletTransactionCubit txCubit =
            context.watch<MultiWalletTransactionCubit>();
        final double balance = txCubit.balance();
        final double currentUd = appCubit.currentUd;
        final bool isV2 = appCubit.isV2;
        final Currency currency = state.currency;
        // Removed the sync that was resetting cursor position
        if (state.amount == null || state.amount == 0) {
          _feedbackNotifier.value = '';
        }

        final bool sentDisabled =
            _onPressed(state, context, currency, currentUd, balance, isV2) ==
                null;
        final Color sentColor = sentDisabled
            ? Theme.of(context).disabledColor
            : isDark(context)
                ? const Color(0xFFB8D166)
                : Theme.of(context).primaryColor;
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 10.0),
              G1PayAmountField(key: payAmountKey),
              const SizedBox(height: 10.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      key: _formCommentKey,
                      controller: _commentController,
                      focusNode: _commentFocusNode,
                      // In V2, allow multiline comments
                      minLines: isV2 ? 2 : 1,
                      maxLines: isV2 ? 5 : 1,
                      keyboardType:
                          isV2 ? TextInputType.multiline : TextInputType.text,
                      onChanged: (String? value) {
                        // In V2, allow newlines; in V1, remove them
                        String newText = isV2
                            ? (value ?? '')
                            : (value ?? '').replaceAll('\n', '');
                        // https://forum.duniter.org/t/implementation-des-commentaires-de-transaction/12289/12
                        if (isV2 && newText.length > 256) {
                          newText = newText.substring(0, 256);
                          // Only update controller if we actually truncated
                          final int currentOffset =
                              _commentController.selection.baseOffset;
                          _commentController.value = TextEditingValue(
                            text: newText,
                            selection: TextSelection.collapsed(
                              offset: currentOffset > 256 ? 256 : currentOffset,
                            ),
                          );
                        }
                        context.read<PaymentCubit>().setComment(newText);
                      },
                      decoration: InputDecoration(
                        labelText: tr('g1_form_pay_desc'),
                        hintText: tr('g1_form_pay_hint'),
                        border: const OutlineInputBorder(),
                        // Add character counter for V2
                        counterText: isV2
                            ? '${_commentController.text.length}/256'
                            : null,
                        suffixIcon: isV2
                            ? IconButton(
                                icon: Icon(
                                  _showEmojiPicker
                                      ? Icons.keyboard
                                      : Icons.emoji_emotions_outlined,
                                ),
                                onPressed: () {
                                  if (_showEmojiPicker) {
                                    // Closing emoji picker, restore keyboard focus
                                    _commentFocusNode.requestFocus();
                                  } else {
                                    // Opening emoji picker, hide keyboard
                                    _commentFocusNode.unfocus();
                                  }

                                  setState(() {
                                    _showEmojiPicker = !_showEmojiPicker;
                                  });

                                  // Scroll to emoji picker after opening it
                                  if (_showEmojiPicker) {
                                    Future<void>.delayed(
                                      const Duration(milliseconds: 300),
                                      () {
                                        if (_emojiPickerKey.currentContext !=
                                            null) {
                                          Scrollable.ensureVisible(
                                            _emojiPickerKey.currentContext!,
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.easeInOut,
                                            alignment: 0.5,
                                          );
                                        }
                                      },
                                    );
                                  }
                                },
                                tooltip: _showEmojiPicker
                                    ? tr('hide_emoji_keyboard')
                                    : tr('add_emoji'),
                              )
                            : null,
                      ),
                      validator: (String? value) {
                        if (value != null &&
                            (!isV2 &&
                                !basicEnglishCharsRegExp.hasMatch(value))) {
                          return tr('valid_comment');
                        }
                        return null;
                      },
                      // Disallow autocomplete
                      autofillHints: const <String>[],
                    ),
                  ),
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
                              icon: Icon(Icons.send, color: sentColor),
                              onPressed: () async {
                                if (mounted) {
                                  final Future<void> Function()? func =
                                      _onPressed(
                                    state,
                                    context,
                                    currency,
                                    currentUd,
                                    balance,
                                    isV2,
                                  );
                                  if (func != null) {
                                    func();
                                  }
                                }
                              },
                              splashRadius: 20,
                              splashColor: Colors.white.withValues(alpha: 0.5),
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
                ],
              ),
              FormErrorWidget(feedbackNotifier: _feedbackNotifier),
              _buildEmojiPicker(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmojiPicker() {
    if (!_showEmojiPicker) {
      return const SizedBox.shrink();
    }
    return LayoutBuilder(
      key: _emojiPickerKey,
      builder: (BuildContext context, BoxConstraints constraints) {
        // Use 30% of available screen height, with a minimum of 200 and maximum of 300
        final double screenHeight = MediaQuery.of(context).size.height;
        final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
        final double availableHeight = screenHeight - keyboardHeight;
        final double pickerHeight = (availableHeight * 0.3).clamp(200.0, 300.0);
        final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

        return SizedBox(
          height: pickerHeight,
          child: EmojiPicker(
            onEmojiSelected: (Category? category, Emoji emoji) {
              final String newComment = _commentController.text + emoji.emoji;
              _commentController.text = newComment;
              context.read<PaymentCubit>().setComment(newComment);
            },
            config: Config(
              height: pickerHeight,
              // Use app's current locale for emoji picker
              // Supported: en, de, es, fr, hi, it, ja, pt, ru, zh
              locale: _getEmojiPickerLocale(context.locale),
              // checkPlatformCompatibility: true,
              emojiViewConfig: EmojiViewConfig(
                columns: MediaQuery.of(context).size.width > 600 ? 9 : 7,
                emojiSizeMax:
                    MediaQuery.of(context).size.width > 600 ? 28.0 : 22.0,
                backgroundColor: isDarkMode
                    ? Theme.of(context).scaffoldBackgroundColor
                    : Colors.white,
              ),
              categoryViewConfig: CategoryViewConfig(
                iconColorSelected: Theme.of(context).primaryColor,
                iconColor: isDarkMode ? Colors.grey : Colors.grey.shade600,
                indicatorColor: Theme.of(context).primaryColor,
                backgroundColor: isDarkMode
                    ? Theme.of(context).scaffoldBackgroundColor
                    : Colors.white,
              ),
              bottomActionBarConfig: BottomActionBarConfig(
                backgroundColor: isDarkMode
                    ? Theme.of(context).scaffoldBackgroundColor
                    : Colors.white,
                buttonColor:
                    isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
                buttonIconColor: isDarkMode ? Colors.white70 : Colors.black87,
              ),
              searchViewConfig: SearchViewConfig(
                backgroundColor: isDarkMode
                    ? Theme.of(context).scaffoldBackgroundColor
                    : Colors.white,
                buttonIconColor: isDarkMode ? Colors.white70 : Colors.black87,
                hintText: tr('emoji_search'),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> Function()? _onPressed(
    PaymentState state,
    BuildContext context,
    Currency currency,
    double currentUd,
    double balance,
    bool isV2,
  ) {
    final bool isG1 = currency == Currency.G1;
    final bool notCanBeSent = !state.canBeSent();
    final bool notValidComment =
        isV2 ? !_commentValidateV2() : !_commentValidate();
    final bool nullAmount = state.amount == null;
    loggerDev(
      'notCanBeSent: $notCanBeSent, notValidComment: $notValidComment, nullAmount: $nullAmount',
    );
    if (notCanBeSent ||
        nullAmount ||
        notValidComment ||
        notBalance(
          context,
          state,
          currency,
          currentUd,
          state.contacts.length,
          balance,
        )) {
      return null;
    } else
      return () async {
        await payWithRetry(
          context: context,
          recipients: state.contacts,
          amount: state.amount!,
          isG1: isG1,
          currentUd: currentUd,
          comment: state.comment,
        );
      };
  }

  bool notBalance(
    BuildContext context,
    PaymentState state,
    Currency currency,
    double currentUd,
    int recipients,
    double balance,
  ) =>
      !_weHaveBalance(
        context,
        state.amount!,
        currency,
        currentUd,
        recipients,
        balance,
      );

  bool _commentValidate() {
    final String currentComment = _commentController.value.text;
    final bool valid = (currentComment != null &&
            basicEnglishCharsRegExp.hasMatch(currentComment)) ||
        currentComment.isEmpty;
    logger('Validating comment: $valid');
    if (_formKey.currentState != null) {
      _formKey.currentState!.validate();
    }
    return valid;
  }

  bool _commentValidateV2() {
    final String currentComment = _commentController.value.text;
    final bool valid = currentComment != null;
    logger('Validating comment: $valid');
    if (_formKey.currentState != null) {
      _formKey.currentState!.validate();
    }
    return valid;
  }

  bool _weHaveBalance(
    BuildContext context,
    double amount,
    Currency currency,
    double currentUd,
    int recipients,
    double g1Balance,
  ) {
    final double balance = convertAmount(
      currency == Currency.G1,
      g1Balance,
      currentUd,
    );
    logger('We have $balance G1, need ${amount * recipients}');
    final bool weHave = balance >= amount * recipients;

    if (!weHave) {
      _feedbackNotifier.value = tr('insufficient balance');
    } else {
      _feedbackNotifier.value = '';
    }
    return weHave;
  }

  /// Maps app locale to emoji picker supported locales
  /// Supported by emoji_picker_flutter: en, de, es, fr, hi, it, ja, pt, ru, zh
  Locale _getEmojiPickerLocale(Locale appLocale) {
    switch (appLocale.languageCode) {
      case 'de': // German
      case 'en': // English
      case 'es': // Spanish (includes Asturian es-AST)
      case 'fr': // French
      case 'it': // Italian
        return Locale(appLocale.languageCode);
      case 'ca': // Catalan -> Spanish
      case 'gl': // Galician -> Spanish
        return const Locale('es');
      case 'eu': // Basque -> Spanish
        return const Locale('es');
      case 'eo': // Esperanto -> English
      case 'nl': // Dutch -> English
      case 'da': // Danish -> English
      default:
        return const Locale('en');
    }
  }
}

class RetryException implements Exception {
  RetryException();
}
