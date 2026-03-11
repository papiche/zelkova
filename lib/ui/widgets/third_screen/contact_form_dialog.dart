import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/app_cubit.dart';
import '../../../data/models/contact.dart';
import '../../../g1/g1_helper.dart';
import '../../../g1/g1_v2_helper.dart';
import '../../qr_helper.dart';

class ContactFormDialog extends StatefulWidget {
  const ContactFormDialog({
    super.key,
    required this.contact,
    required this.onSave,
    this.isNew = false,
  });

  final Contact contact;
  final Function(Contact) onSave;
  final bool isNew;

  @override
  State<ContactFormDialog> createState() => _ContactFormDialogState();
}

class _ContactFormDialogState extends State<ContactFormDialog> {
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: 'contactFormDialog');
  late Contact _updatedContact;
  String? _detectedKeyType; // 'v1' or 'v2' or null
  final TextStyle keyStyle = const TextStyle(color: Colors.black45);
  final InputDecoration keyDecoration = const InputDecoration(
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey), // width: 1.0),
    ),
    disabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey), // , width: 1.0),
    ),
    labelStyle: TextStyle(
      color: Colors.black87,
    ),
    // filled: true,
    // fillColor: Colors.transparent,
  );

  @override
  void initState() {
    super.initState();
    // Pre-fill name with what the user sees in the contact title
    // nick comes from the blockchain profile, name is the user's custom name
    // Priority: keep existing name, otherwise use nick from profile
    final String? defaultName = widget.contact.name ?? widget.contact.nick;
    _updatedContact = widget.contact.name == null && defaultName != null
        ? widget.contact.copyWith(name: defaultName)
        : widget.contact;
  }

  bool _validateKeyOrAddress(String value) {
    // Validate both v1 pubkey and v2 address formats
    return validateKey(value) || isValidV2Address(value);
  }

  void _onKeyChanged(String value) {
    if (value.isEmpty) {
      setState(() {
        _detectedKeyType = null;
      });
      return;
    }

    final bool isV2Address = isValidV2Address(value);
    final bool isV1PubKey = validateKey(value);

    if (isV2Address) {
      setState(() {
        _detectedKeyType = 'v2';
      });
      final String pubKey = v1pubkeyFromAddress(value);
      _updatedContact =
          _updatedContact.copyWith(pubKey: pubKey, address: value);
    } else if (isV1PubKey) {
      setState(() {
        _detectedKeyType = 'v1';
      });
      final String address = addressFromV1Pubkey(value);
      _updatedContact =
          _updatedContact.copyWith(pubKey: value, address: address);
    } else {
      setState(() {
        _detectedKeyType = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isV2Mode = context.read<AppCubit>().state.v2mode;

    return AlertDialog(
      title: Text(
          tr(widget.isNew ? 'form_contact_title_add' : 'form_contact_title')),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (!widget.isNew)
                Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  Flexible(
                      child: TextFormField(
                    // maxLines: 2,
                    initialValue: humanizePubKey(_updatedContact.pubKey),
                    style: keyStyle,
                    decoration: keyDecoration.copyWith(
                      labelText: tr('form_contact_pub_key'),
                    ),
                    enabled: false,
                  )),
                  GestureDetector(
                    onTap: () {
                      showQrDialog(
                          context: context,
                          pubKeyOrAddress: _updatedContact.pubKey,
                          isV2: false,
                          noTitle: true,
                          feedbackText: 'some_key_copied_to_clipboard');
                    },
                    child: const Icon(Icons.qr_code, size: 50),
                  ),
                ]),
              if (!widget.isNew && isV2Mode) const SizedBox(height: 5),
              if (!widget.isNew && isV2Mode)
                Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  Flexible(
                      child: TextFormField(
                    // maxLines: 2,
                    initialValue: humanizeAddress(_updatedContact.address),
                    decoration: keyDecoration.copyWith(
                      labelText: tr('form_contact_address_v2'),
                    ),
                    style: keyStyle,
                    enabled: false,
                  )),
                  GestureDetector(
                      onTap: () {
                        showQrDialog(
                            context: context,
                            isV2: true,
                            pubKeyOrAddress: _updatedContact.address,
                            noTitle: true,
                            feedbackText: 'some_key_copied_to_clipboard');
                      },
                      child: const Badge(
                        label: Text('v2'),
                        child: Icon(Icons.qr_code, size: 50),
                      )),
                ]),
              if (widget.isNew)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return tr('form_contact_name_validation_pub_key');
                        }
                        if (!_validateKeyOrAddress(value)) {
                          return tr('form_contact_name_validation_pub_key');
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: tr('form_contact_pub_or_address'),
                        hintText: 'v1 pubkey or v2 address',
                        suffixIcon: _detectedKeyType != null
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Chip(
                                  label: Text(
                                    _detectedKeyType == 'v2'
                                        ? 'v2 address'
                                        : 'v1 pubkey',
                                    style: const TextStyle(fontSize: 11),
                                  ),
                                  backgroundColor: _detectedKeyType == 'v2'
                                      ? Colors.blue.shade100
                                      : Colors.green.shade100,
                                  visualDensity: VisualDensity.compact,
                                ),
                              )
                            : null,
                      ),
                      onChanged: _onKeyChanged,
                    ),
                    if (_detectedKeyType != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, left: 12.0),
                        child: Text(
                          '✓ ${tr('form_contact_detected')}',
                          style: TextStyle(
                            fontSize: 12,
                            color: _detectedKeyType == 'v2'
                                ? Colors.blue.shade700
                                : Colors.green.shade700,
                          ),
                        ),
                      ),
                  ],
                ),
              if (!widget.isNew) const SizedBox(height: 5),
              TextFormField(
                initialValue: _updatedContact.name ?? _updatedContact.nick,
                decoration: InputDecoration(labelText: tr('form_contact_name')),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return tr('form_contact_name_validation');
                  }
                  return null;
                },
                onChanged: (String? value) {
                  _updatedContact = _updatedContact.copyWith(name: value);
                },
              ),
              TextFormField(
                initialValue: _updatedContact.notes,
                decoration:
                    InputDecoration(labelText: tr('form_contact_notes')),
                onChanged: (String? value) {
                  _updatedContact = _updatedContact.copyWith(notes: value);
                },
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(tr('cancel')),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              widget.onSave(_updatedContact);
              Navigator.of(context).pop();
            }
          },
          child: Text(tr('form_save')),
        ),
      ],
    );
  }
}
