import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

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
    _updatedContact = widget.contact;
  }

  @override
  Widget build(BuildContext context) {
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
              if (!widget.isNew) const SizedBox(height: 5),
              if (!widget.isNew)
                Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  Flexible(
                      child: TextFormField(
                    // maxLines: 2,
                    initialValue: humanizePubKey(_updatedContact.address),
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
                TextFormField(
                  validator: (String? value) {
                    if (value == null || value.isEmpty || !validateKey(value)) {
                      return tr('form_contact_name_validation_pub_key');
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: tr('form_contact_pub_or_address'),
                  ),
                  onChanged: (String? value) {
                    if (value != null) {
                      final bool isV2Address = isValidV2Address(value);
                      final String pubKey =
                          isV2Address ? v1pubkeyFromAddress(value) : value;
                      final String address =
                          isV2Address ? value : addressFromV1Pubkey(value);
                      _updatedContact = _updatedContact.copyWith(
                          pubKey: pubKey, address: address);
                    }
                  },
                ),
              if (!widget.isNew) const SizedBox(height: 5),
              TextFormField(
                initialValue: _updatedContact.name,
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
