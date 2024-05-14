import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../g1/api.dart';
import '../../../shared_prefs_helper.dart';
import '../../logger.dart';
import '../../ui_helpers.dart';
import '../connectivity_widget_wrapper_wrapper.dart';
import 'card_text_style.dart';

class CardNameEditable extends StatefulWidget {
  const CardNameEditable(
      {super.key,
      required this.defValue,
      required this.publicKey,
      required this.cardName,
      required this.isG1nkgoCard});

  final String defValue;
  final String publicKey;
  final String cardName;
  final bool isG1nkgoCard;

  @override
  State<CardNameEditable> createState() => _CardNameEditableState();
}

class _CardNameEditableState extends State<CardNameEditable> {
  bool _isEditingText = false;
  bool _isSubmitting = false;
  final TextEditingController _controller = TextEditingController();
  late String currentText;

  @override
  void initState() {
    super.initState();
    _initValue();
  }

  Future<void> _initValue() async {
    final String localUsername = widget.cardName;
    if (localUsername.isEmpty) {
      setState(() {
        currentText = widget.defValue;
        _controller.text = currentText;
      });
    } else {
      setState(() {
        currentText = localUsername;
        _controller.text = currentText;
      });
    }
    await _fetchAndSetUsername();
  }

  @override
  void didUpdateWidget(CardNameEditable oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.cardName != oldWidget.cardName) {
      final String localUsername = widget.cardName;
      if (localUsername.isEmpty) {
        setState(() {
          currentText = widget.defValue;
          _controller.text = currentText;
        });
      } else {
        setState(() {
          currentText = localUsername;
          _controller.text = currentText;
        });
      }
      // Optionally
      // _fetchAndSetUsername();
    }
  }

  Future<void> _fetchAndSetUsername() async {
    final bool isConnected = await ConnectivityWidgetWrapperWrapper.isConnected;
    if (isConnected) {
      try {
        String? name = await getCesiumPlusUser(widget.publicKey);
        if (name != null && name.isNotEmpty) {
          name = name.replaceAll(g1nkgoUserNameSuffix, '');
          setState(() {
            _controller.text = name!;
            currentText = name;
          });
          SharedPreferencesHelper().setName(name: name, notify: false);
        } else {
          setState(() {
            _controller.text = '';
            currentText = widget.defValue;
          });
          SharedPreferencesHelper().setName(name: '', notify: false);
        }
      } catch (e) {
        logger('Error: $e');
      }
    }
  }

  Widget _buildEditingField() {
    if (currentText == widget.defValue) {
      _controller.text = '';
    } else {
      _controller.text = currentText;
    }
    return SizedBox(
      width: 150.0,
      child: SizedBox(
        height: 40.0,
        child: TextField(
          style: const TextStyle(color: Colors.black87),
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 7.0),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 2.0),
            ),
            suffix: const Text('$g1nkgoUserNameSuffix  '),
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
                              color: Colors.black87),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _updateValue(_controller.text);
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Icon(Icons.check, color: Colors.black87),
                        ),
                      ),
                    ],
                  ),
          ),
          cursorColor: Colors.black87,
          onSubmitted: _updateValue,
          enabled: !_isSubmitting,
          autofocus: true,
          controller: _controller,
        ),
      ),
    );
  }

  Widget _buildDisplayField() {
    return InkWell(
      onTap: () {
        if (widget.isG1nkgoCard) {
          setState(() {
            _isEditingText = true;
          });
        }
      },
      child: RichText(
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: <InlineSpan>[
            if (currentText == widget.defValue)
              TextSpan(
                text: currentText.toUpperCase(),
                style: const TextStyle(
                  fontFamily: 'SourceCodePro',
                  color: Colors.grey,
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(1.0, 1.0),
                      blurRadius: 3.0,
                      color: Colors.black45,
                    ),
                  ],
                ),
              ),
            if (currentText == widget.defValue)
              const WidgetSpan(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(3, 0, 0, 0),
                    child: Icon(Icons.edit, size: 14.0, color: Colors.white)),
              ),
            if (currentText.isNotEmpty && currentText != widget.defValue)
              TextSpan(
                text: currentText,
                style: cardTextStyle(context, fontSize: 15),
              ),
            // Suffix
            if (currentText.isNotEmpty && currentText != widget.defValue)
              TextSpan(
                text: widget.isG1nkgoCard
                    ? g1nkgoUserNameSuffix
                    : protectedUserNameSuffix,
                style: cardTextStyle(context, fontSize: 12),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    loggerDev(
        "Building CardNameEditable for ${widget.publicKey} '${widget.cardName}'");
    return GestureDetector(
      onTap: () {
        if (widget.isG1nkgoCard) {
          setState(() {
            _isEditingText = true;
          });
        }
      },
      child: _isEditingText ? _buildEditingField() : _buildDisplayField(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _updateValue(String newValue) async {
    if (newValue.isEmpty) {
      return _deleteValue();
    }
    setState(() {
      _isSubmitting = true;
    });
    try {
      if (_validate(newValue)) {
        await createOrUpdateCesiumPlusUser(newValue);
        SharedPreferencesHelper().setName(name: newValue, notify: false);
        setState(() {
          currentText = newValue;
        });
        if (!mounted) {
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(tr('card_name_changed')),
          ),
        );
      }
    } catch (e) {
      loggerDev(e.toString());
    }
    setState(() {
      _isEditingText = false;
      _isSubmitting = false;
    });
  }

  Future<void> _deleteValue() async {
    setState(() {
      _isSubmitting = true;
    });
    try {
      await deleteCesiumPlusUser();
      SharedPreferencesHelper().setName(name: '');
      setState(() {
        _controller.text = '';
        currentText = widget.defValue;
      });
    } catch (e) {
      logger('Error: $e');
    }
    setState(() {
      _isEditingText = false;
      _isSubmitting = false;
    });
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
            if (currentText.isNotEmpty && currentText != defValue)
              TextSpan(
                text: isGinkgoCard
                    ? g1nkgoUserNameSuffix
                    : protectedUserNameSuffix,
                style: cardTextStyle(context, fontSize: 12),
              ),
          ],
        ),
      ),
    );
  }
}
