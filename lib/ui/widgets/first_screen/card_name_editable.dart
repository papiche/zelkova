import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

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
  late TextEditingController _editingController;
  late String currentText;
  late String defValue;
  late String name;

  @override
  void initState() {
    super.initState();
    defValue = tr('your_name_here');
    name = SharedPreferencesHelper().getName();
    currentText = _currentTextOrDef();
    _editingController = TextEditingController(text: currentText);
  }

  String _currentTextOrDef() =>
      (name == tr('g1_wallet') || name.isEmpty) ? defValue : name;

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isSetted = currentText.isNotEmpty && currentText != defValue;
    return _isEditingText
        ? SizedBox(
            width: 150.0,
            child: SizedBox(
                height: 40.0,
                child: TextField(
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
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.check),
                      onPressed: () {
                        updateName(_editingController.text);
                      },
                    ),
                  ),
                  cursorColor: Colors.black,
                  onSubmitted: (String newValue) {
                    updateName(newValue);
                  },
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
                    if (isSetted)
                      TextSpan(
                          text: currentText, style: cardTextStyle(context, 15)),
                    /*  TextSpan(
              text: ' Lorem ipsum dolor sit amet, consectetur adipiscing elit',
              style: cardTextStyle(context, 15),
            ), */
                    if (isSetted)
                      TextSpan(
                        text: userNameSuffix,
                        style: cardTextStyle(context, 10),
                      ),
                  ],
                ),
              ),
              onTap: () {
                setState(() {
                  try {
                    _editingController.selection = TextSelection(
                        baseOffset: 0, extentOffset: currentText.length);
                  } catch (e) {
                    logger(e);
                  }
                  _isEditingText = true;
                });
              },
            ));
  }

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
  }
}
