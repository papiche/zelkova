import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../g1/api.dart';
import '../../../shared_prefs_helper.dart';
import '../../logger.dart';
import '../../ui_helpers.dart';
import '../connectivity_widget_wrapper_wrapper.dart';
import 'card_text_style.dart';

class CardNameEditable extends StatefulWidget {
  const CardNameEditable({super.key, required this.defValue});

  final String defValue;

  @override
  State<CardNameEditable> createState() => _CardNameEditableState();
}

class _CardNameEditableState extends State<CardNameEditable> {
  bool _isEditingText = false;
  final TextEditingController _controller = TextEditingController();
  late String currentText;

  String _previousValue = '';
  bool _isSubmitting = false;

  @override
  void initState() {
    final String localUsername = SharedPreferencesHelper().getName();
    currentText = localUsername.isEmpty ? widget.defValue : localUsername;
    super.initState();
  }

  Future<String> _initValue() async {
    final String localUsername = SharedPreferencesHelper().getName();
    final bool isConnected = await ConnectivityWidgetWrapperWrapper.isConnected;
    if (isConnected) {
      try {
        String? name =
            await getCesiumPlusUser(SharedPreferencesHelper().getPubKey());
        logger(
            'currentText: $currentText, localUsername: $localUsername, _previousValue: $_previousValue, retrieved_name: $name');
        if (localUsername != name) {
          if (name != null) {
            name = name.replaceAll(userNameSuffix, '');
            _controller.text = name;
            currentText = name;
            SharedPreferencesHelper().setName(name: name, notify: false);
          } else {
            _controller.text = '';
            currentText = widget.defValue;
            SharedPreferencesHelper().setName(name: '', notify: false);
          }
        }
      } catch (e) {
        logger(e);
        _controller.text = localUsername;
        currentText = localUsername;
      }
    } else {
      // not connected, same an on exception
      _controller.text = localUsername;
      currentText = localUsername;
    }
    _previousValue = _controller.text;
    _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length));

    logger(
        'currentText: $currentText, localUsername: $localUsername,  _previousValue: $_previousValue');
    return currentText;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SharedPreferencesHelper>(builder: (BuildContext context,
        SharedPreferencesHelper prefsHelper, Widget? child) {
      return FutureBuilder<String>(
          future: _initValue(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            const Color black = Colors.black87;
            return _isEditingText
                ? SizedBox(
                    width: 150.0,
                    child: SizedBox(
                        height: 40.0,
                        child: TextField(
                          // focusNode: myFocusNode,
                          style: const TextStyle(color: black),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 7.0),
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(width: 2.0),
                            ),
                            suffix: const Text('$userNameSuffix  '),
                            suffixIcon: _isSubmitting
                                ? const RefreshProgressIndicator()
                                : Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _isEditingText = false;
                                          });
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.only(right: 8.0),
                                          child: Icon(Icons.cancel_outlined,
                                              color: black),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          _updateValue(_controller.text);
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.only(right: 8.0),
                                          child:
                                              Icon(Icons.check, color: black),
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                          cursorColor: black,
                          onSubmitted: _updateValue,
                          enabled: !_isSubmitting,
                          /* onChanged: (String value) {
                          if (value.isEmpty) {
                            _deleteValue();
                          }
                        }, */
                          /*onSubmitted: (String newValue) {
                    updateName(newValue);
                  }, */
                          // maxLength: 15,
                          autofocus: true,
                          controller: _controller,
                        )))
                : Tooltip(
                    message: widget.defValue,
                    child: CardNameText(
                        currentText: currentText,
                        isGinkgoCard: SharedPreferencesHelper().isG1nkgoCard(),
                        onTap: () => SharedPreferencesHelper().isG1nkgoCard()
                            ? setState(() {
                                _isEditingText = true;
                              })
                            : null));
          });
    });
  }

  Future<void> _updateValue(String newValue) async {
    if (newValue.isEmpty) {
      return _deleteValue();
    }
    logger('updating with newValue: $newValue');
    try {
      setState(() {
        _isSubmitting = true;
      });
      if (_validate(newValue)) {
        await createOrUpdateCesiumPlusUser(newValue);
        setState(() {
          _previousValue = newValue;
          currentText = newValue;
        });
      } else {
        setState(() {
          _controller.text = _previousValue;
          currentText =
              _previousValue.isEmpty ? widget.defValue : _previousValue;
        });
      }
    } catch (e) {
      setState(() {
        _controller.text = _previousValue;
        currentText = _previousValue.isEmpty ? widget.defValue : _previousValue;
      });
    }
    setState(() {
      _isEditingText = false;
      _isSubmitting = false;
    });
    logger(
        'currentText: $currentText, newValue: $newValue,  _previousValue: $_previousValue');
  }

  Future<void> _deleteValue() async {
    try {
      setState(() {
        _isSubmitting = true;
      });
      await deleteCesiumPlusUser();
      SharedPreferencesHelper().setName(name: '');
      setState(() {
        _controller.text = '';
        currentText = widget.defValue;
      });
    } catch (e) {
      setState(() {
        _controller.text = _previousValue;
        currentText = _previousValue.isEmpty ? widget.defValue : _previousValue;
      });
    }
    setState(() {
      _isEditingText = false;
      _isSubmitting = false;
    });
    logger(
        'delete with currentText: $currentText,  _previousValue: $_previousValue');
  }

  bool _validate(String newValue) {
    if (newValue.isEmpty) {
      return false;
    }
    return true;
  }
}

class CardNameText extends StatelessWidget {
  const CardNameText(
      {super.key,
      required this.currentText,
      required this.onTap,
      required this.isGinkgoCard});

  final String currentText;
  final bool isGinkgoCard;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    // Dup above
    final String defValue = isGinkgoCard ? tr('your_name_here') : '';
    return InkWell(
      onTap: onTap,
      child: RichText(
        // softWrap: true,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: <TextSpan>[
            if (currentText == defValue)
              TextSpan(
                  text: currentText.toUpperCase(),
                  style: const TextStyle(
                      fontFamily: 'SourceCodePro', color: Colors.grey)),
            if (currentText.isNotEmpty && currentText != defValue)
              TextSpan(
                  text: currentText,
                  style: cardTextStyle(context, fontSize: 15)),
            if (currentText.isNotEmpty &&
                currentText != defValue &&
                isGinkgoCard)
              TextSpan(
                text: userNameSuffix,
                style: cardTextStyle(context, fontSize: 12),
              ),
          ],
        ),
      ),
    );
  }
}
