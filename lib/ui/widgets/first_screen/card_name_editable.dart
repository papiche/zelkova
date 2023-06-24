import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../g1/api.dart';
import '../../../shared_prefs.dart';
import '../../logger.dart';
import '../../ui_helpers.dart';
import 'card_text_style.dart';

class CardNameEditable extends StatefulWidget {
  const CardNameEditable({super.key});

  @override
  State<CardNameEditable> createState() => _CardNameEditableState();
}

class _CardNameEditableState extends State<CardNameEditable> {
  bool _isEditingText = false;
  final TextEditingController _editingController = TextEditingController();
  late String currentText;
  late String defValue;

  // late FocusNode myFocusNode;
  final String pubKey = SharedPreferencesHelper().getPubKey();
  String _previousValue = '';

  @override
  void initState() {
    super.initState();
    defValue = tr('your_name_here');
    currentText = defValue;
    //  myFocusNode = FocusNode();
    _initValue();
  }

  Future<void> _initValue() async {
    final String localUsername = SharedPreferencesHelper().getName();

    try {
      final String? name = await getCesiumPlusUser(pubKey);
      logger(
          'currentText: $currentText, localUsername: $localUsername, _previousValue: $_previousValue, retrieved_name: $name');
      if (name != null) {
        _editingController.text = name;
        currentText = name;
        SharedPreferencesHelper().setName(name: name);
      } else {
        _editingController.text = '';
        currentText = defValue;
        SharedPreferencesHelper().setName(name: '');
      }
    } catch (e) {
      logger(e);
      _editingController.text = localUsername;
      currentText = localUsername;
    }
    _previousValue = _editingController.text;
    logger(
        'currentText: $currentText, localUsername: $localUsername,  _previousValue: $_previousValue');
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isSet = currentText.isNotEmpty && currentText != defValue;
    return _isEditingText
        ? SizedBox(
            width: 150.0,
            child: SizedBox(
                height: 40.0,
                child: TextField(
                  // focusNode: myFocusNode,
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
                    suffixIcon: Row(
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
                            child: Icon(Icons.cancel_outlined),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _updateValue(_editingController.text);
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Icon(Icons.check),
                          ),
                        ),
                      ],
                    ),
                  ),
                  cursorColor: Colors.black,
                  onSubmitted: _updateValue,
                  onChanged: (String value) {
                    if (value.isEmpty) {
                      _deleteValue();
                    }
                  },
                  /*onSubmitted: (String newValue) {
                    updateName(newValue);
                  }, */
                  // maxLength: 15,
                  autofocus: true,
                  controller: _editingController,
                )))
        : Tooltip(
            message: tr('your_name_here'),
            child: InkWell(
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
                    if (isSet)
                      TextSpan(
                          text: currentText, style: cardTextStyle(context, 15)),
                    /*  TextSpan(
              text: ' Lorem ipsum dolor sit amet, consectetur adipiscing elit',
              style: cardTextStyle(context, 15),
            ), */
                    if (isSet)
                      TextSpan(
                        text: userNameSuffix,
                        style: cardTextStyle(context, 12),
                      ),
                  ],
                ),
              ),
              onTap: () {
                setState(() {
                  try {
                    /* _editingController.selection = TextSelection(
                        baseOffset: 0, extentOffset: currentText.length);*/
                  } catch (e) {
                    logger(e);
                  }
                  _isEditingText = true;
                });
              },
            ));
  }

/*
  void updateName(String newValue) {
    setState(() {
      if (newValue.isEmpty) {
        // FIXME delete old name
        SharedPreferencesHelper().setName(name: '');
        currentText = _currentTextOrDef();
      } else if (newValue == defValue) {
        currentText = newValue;
      } else {
        try {
          // await createOrUpdateCesiumPlusUser(newValue);
          SharedPreferencesHelper().setName(name: newValue);
          currentText = newValue;
        } catch (e) {
          logger(e);
          // FIXME show message
        }
      }
      _isEditingText = false;
    });
  }*/

  Future<void> _updateValue(String newValue) async {
    logger('updating with newValue: $newValue');
    try {
      if (_validate(newValue)) {
        await createOrUpdateCesiumPlusUser(newValue);
        setState(() {
          _previousValue = newValue;
        });
      } else {
        setState(() {
          _editingController.text = _previousValue;
          currentText = _previousValue.isEmpty ? defValue : _previousValue;
        });
      }
    } catch (e) {
      setState(() {
        _editingController.text = _previousValue;
        currentText = _previousValue.isEmpty ? defValue : _previousValue;
      });
    }
    setState(() {
      _isEditingText = false;
    });
    logger(
        'currentText: $currentText, newValue: $newValue,  _previousValue: $_previousValue');
  }

  Future<void> _deleteValue() async {
    try {
      await deleteCesiumPlusUser();
      SharedPreferencesHelper().setName(name: '');
      setState(() {
        _editingController.text = '';
        currentText = defValue;
      });
    } catch (e) {
      setState(() {
        _editingController.text = _previousValue;
        currentText = _previousValue.isEmpty ? defValue : _previousValue;
      });
    }
    setState(() {
      _isEditingText = false;
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
