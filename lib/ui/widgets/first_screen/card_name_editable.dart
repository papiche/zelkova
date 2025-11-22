import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../data/models/stored_account.dart';
import '../../../g1/api.dart';
import '../../../shared_prefs_helper.dart';
import '../../logger.dart';
import '../connectivity_widget_wrapper_wrapper.dart';
import 'card_text_style.dart';

class CardNameEditable extends StatefulWidget {
  const CardNameEditable(
      {super.key,
      required this.defValue,
      required this.account,
      required this.cardName,
      required this.isEditable,
      required this.isPassProtected});

  final String defValue;
  final StoredAccount account;
  final String cardName;
  final bool isEditable;
  final bool isPassProtected;

  @override
  State<CardNameEditable> createState() => _CardNameEditableState();
}

class _CardNameEditableState extends State<CardNameEditable> {
  bool _isEditingText = false;
  bool _isSubmitting = false;
  final TextEditingController _controller = TextEditingController();
  late String currentText;
  Future<bool>? _usernameFetchFuture;

  @override
  void initState() {
    super.initState();
    _initValue();
    _usernameFetchFuture = _fetchAndSetUsername(context);
  }

  void _initValue() {
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
    }
  }

  Future<bool> _fetchAndSetUsername(BuildContext context) async {
    final bool isConnected = await ConnectivityWidgetWrapperWrapper.isConnected;
    if (!context.mounted) {
      return false;
    }

    if (isConnected) {
      //
      // In V2 this is done directly in the SharedPreferencesHelper
      try {
        final String? name = await getProfileUserName(widget.account.pubKey);
        loggerDev(
            'CardNameEditable: fetched remote name for ${widget.account.pubKey}: "${name ?? 'null'}"');
        // Only overwrite the displayed name when the remote value is non-empty.
        // If the remote name is null/empty we should NOT clear a previously
        // available local name (this was causing the behavior where the name
        // briefly appears and then disappears).
        if (name != null && name.isNotEmpty) {
          final String cleanName =
              name; // .replaceAll(g1nkgoUserNameSuffix, '');
          loggerDev('CardNameEditable: updating display name to "$cleanName"');
          setState(() {
            _controller.text = cleanName;
            currentText = cleanName;
          });
          SharedPreferencesHelper().setName(name: cleanName, notify: false);
        } else {
          loggerDev(
              'CardNameEditable: remote name empty for ${widget.account.pubKey}, hadLocal=${widget.cardName.isNotEmpty}');
          // Remote returned empty. Only set the default value if there was no
          // local cardName provided (i.e. widget.cardName was empty) and the
          // currentText is empty/defValue. Otherwise keep whatever local value
          // we already had.
          final bool hadLocal = widget.cardName.isNotEmpty;
          if (!hadLocal) {
            loggerDev('CardNameEditable: no local name, setting defValue');
            setState(() {
              _controller.text = widget.defValue;
              currentText = widget.defValue;
            });
            // Do not write an empty name into SharedPreferences; leave it as-is.
          } else {
            loggerDev(
                'CardNameEditable: keeping existing local name "$currentText"');
            // keep existing currentText (don't overwrite with empty)
          }
        }
      } catch (e) {
        logger('Error: $e');
      }
    }
    return true;
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
            // suffix: const Text('$g1nkgoUserNameSuffix  '),
            suffixIcon: _isSubmitting
                ? const SizedBox(
                    width: 24, height: 24, child: RefreshProgressIndicator())
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
        if (widget.isEditable) {
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
            if (widget.isEditable && currentText == widget.defValue)
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
            /* if (widget.isPassProtected ||
                currentText.isNotEmpty && currentText != widget.defValue)
               TextSpan(
                // Show a nothing if the card name is not editable (before a lock)
                text: widget.isEditable
                    ? ''
                    : protectedUserNameSuffix,
                style: cardTextStyle(context, fontSize: 12),
              ), */
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    loggerDev(
        "Building CardNameEditable for ${widget.account.pubKey} '${widget.cardName}'");
    return FutureBuilder<bool>(
        future: _usernameFetchFuture,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          return GestureDetector(
            onTap: () {
              if (widget.isEditable) {
                setState(() {
                  _isEditingText = true;
                });
              }
            },
            child: _isEditingText ? _buildEditingField() : _buildDisplayField(),
          );
        });
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
        final bool result = await createOrUpdateProfile(newValue);
        if (!result) {
          if (!mounted) {
            return;
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(tr('card_name_changed_failed')),
            ),
          );
        } else {
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
      await deleteProfile();
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
