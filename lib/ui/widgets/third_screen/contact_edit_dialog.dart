import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../data/models/contact.dart';
import '../../../g1/g1_helper.dart';
import '../../ui_helpers.dart';

class ContactEditDialog extends StatefulWidget {
  const ContactEditDialog(
      {super.key, required this.contact, required this.onSave});

  final Contact contact;
  final Function(Contact) onSave;

  @override
  State<ContactEditDialog> createState() => _ContactEditDialogState();
}

class _ContactEditDialogState extends State<ContactEditDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Contact _updatedContact;

  @override
  void initState() {
    super.initState();
    _updatedContact = widget.contact;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(tr('form_contact_title')),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Flexible(
                  child: TextFormField(
                // maxLines: 2,
                initialValue: humanizePubKey(_updatedContact.pubKey),
                decoration: InputDecoration(
                  labelText: tr('form_contact_pub_key'),
                ),
                enabled: false,
              )),
              GestureDetector(
                onTap: () {
                  showQrDialog(
                      context: context,
                      publicKey: getFullPubKey(_updatedContact.pubKey),
                      noTitle: true,
                      feedbackText: 'some_key_copied_to_clipboard');
                },
                child: const Icon(Icons.qr_code, size: 50),
              ),
            ]),
            TextFormField(
              initialValue: _updatedContact.name,
              decoration: const InputDecoration(labelText: 'Name'),
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
              decoration: InputDecoration(labelText: tr('form_contact_notes')),
              onChanged: (String? value) {
                _updatedContact = _updatedContact.copyWith(notes: value);
              },
            ),
          ],
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
