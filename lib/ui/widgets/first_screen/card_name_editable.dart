import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../data/models/stored_account.dart';
import '../../../g1/api.dart';
import '../../../shared_prefs_helper.dart';
import '../../logger.dart';
import '../contacts_actions.dart';
import 'card_text_style.dart';

/// Displays the card name following this priority:
///
///   1. Identity nick → read-only (but tappable to open contact page)
///   2. Cesium+ name  → editable
///   3. defValue hint → editable (prompts user to set a C+ name)
///
/// All display state comes from the parent widget via props.
/// There is no internal buffering of the fetched name; the parent
/// (a Consumer<SharedPreferencesHelper>) is responsible for rebuilding
/// this widget when the contact data changes.
class CardNameEditable extends StatefulWidget {
  const CardNameEditable({
    super.key,
    required this.account,
    required this.defValue,
  });

  final StoredAccount account;

  /// Hint shown when neither nick nor C+ name is available.
  final String defValue;

  @override
  State<CardNameEditable> createState() => _CardNameEditableState();
}

class _CardNameEditableState extends State<CardNameEditable> {
  bool _isEditingText = false;
  bool _isSubmitting = false;
  final TextEditingController _controller = TextEditingController();

  // Derived from widget.account.contact — never stored separately.
  String? get _nick => (widget.account.contact.nick?.isNotEmpty ?? false)
      ? widget.account.contact.nick
      : null;
  String? get _cPlusName => (widget.account.contact.name?.isNotEmpty ?? false)
      ? widget.account.contact.name
      : null;

  // isMember != false covers both (true = member) and (null = still loading).
  // When null we default to non-editable to avoid a brief editable flash.
  bool get _hasIdentity =>
      _nick != null || widget.account.contact.isMember != false;
  bool get _isEditable => !_hasIdentity;

  /// The text currently shown on the card (not editing mode).
  String get _displayText => _nick ?? _cPlusName ?? widget.defValue;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildEditingField() {
    // Pre-fill with existing C+ name if available, otherwise empty.
    _controller.text = _cPlusName ?? '';
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
    final bool isPlaceholder = _displayText == widget.defValue;

    return InkWell(
      onTap: () {
        if (_hasIdentity) {
          // Tapping the identity nick opens the contact page.
          showMyContactPage(context);
        } else if (_isEditable) {
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
            if (isPlaceholder)
              TextSpan(
                text: _displayText.toUpperCase(),
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
              )
            else
              TextSpan(
                text: _displayText,
                style: cardTextStyle(context, fontSize: 15),
              ),
            // Show edit icon only when editable AND no name is set yet (placeholder).
            if (_isEditable && isPlaceholder)
              const WidgetSpan(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(3, 0, 0, 0),
                  child: Icon(Icons.edit, size: 14.0, color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    loggerDev(
        'CardNameEditable build: nick=$_nick cPlus=$_cPlusName editable=$_isEditable');
    return GestureDetector(
      onTap: () {
        if (_hasIdentity) {
          showMyContactPage(context);
        } else if (_isEditable && !_isEditingText) {
          setState(() {
            _isEditingText = true;
          });
        }
      },
      child: _isEditingText ? _buildEditingField() : _buildDisplayField(),
    );
  }

  Future<void> _updateValue(String newValue) async {
    if (newValue.isEmpty) {
      return _deleteValue();
    }
    setState(() {
      _isSubmitting = true;
    });
    try {
      final bool result = await createOrUpdateProfile(newValue);
      if (!result) {
        if (!mounted) {
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(tr('card_name_changed_failed'))),
        );
        // Do NOT update local state — keep old value.
      } else {
        // Update SharedPreferences so the parent rebuilds with the new name.
        SharedPreferencesHelper().setName(name: newValue);
        if (!mounted) {
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(tr('card_name_changed'))),
        );
      }
    } catch (e) {
      loggerDev('CardNameEditable._updateValue error: $e');
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tr('card_name_changed_failed'))),
      );
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
      final bool result = await deleteProfile();
      if (result) {
        SharedPreferencesHelper().setName(name: '');
      } else {
        if (!mounted) {
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(tr('card_name_changed_failed'))),
        );
      }
    } catch (e) {
      logger('CardNameEditable._deleteValue error: $e');
    }
    setState(() {
      _isEditingText = false;
      _isSubmitting = false;
    });
  }
}
