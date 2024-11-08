import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/contact.dart';
import '../../../data/models/contact_cubit.dart';
import '../../../data/models/contact_state.dart';
import '../../../data/models/payment_cubit.dart';
import '../../../data/models/payment_state.dart';
import '../../ui_helpers.dart';
import 'contact_fav_icon.dart';
import 'contact_search_page.dart';

class PayRecipientWidget extends StatefulWidget {
  const PayRecipientWidget({super.key, required this.searchUse});

  final SearchUse searchUse;

  @override
  State<PayRecipientWidget> createState() => _PayRecipientWidgetState();
}

class _PayRecipientWidgetState extends State<PayRecipientWidget> {
  bool isExpanded = false;
  final int maxVisibleContacts = 10;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentCubit, PaymentState>(
        builder: (BuildContext context, PaymentState state) {
      final bool isMulti = state.isMultiple();
      return FutureBuilder<List<Contact>>(
          future: enrichContacts(context, state.contacts),
          builder:
              (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
            final List<Contact> currentContacts =
                snapshot.data ?? state.contacts;

            return Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          if (isMulti)
                            CircleAvatar(
                              child: Text('${currentContacts.length}'),
                            )
                          else
                            avatar(currentContacts[0]),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                if (isMulti)
                                  _buildContactsText(currentContacts)
                                else if (currentContacts[0].title != null)
                                  Text(
                                    currentContacts[0].title,
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                if (!isMulti &&
                                    currentContacts[0].subtitle != null)
                                  Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 2, 0, 0),
                                      child: Text(
                                        currentContacts[0].subtitle!,
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                        ),
                                      )),
                              ],
                            ),
                          ),
                          if (!isMulti)
                            BlocBuilder<ContactsCubit, ContactsState>(builder:
                                (BuildContext context,
                                    ContactsState contactState) {
                              return ContactFavIcon(
                                  contact: currentContacts[0],
                                  contactsCubit: context.read<ContactsCubit>(),
                                  paymentCubit: context.watch<PaymentCubit>());
                            }),
                          Column(
                            children: <Widget>[
                              IconButton(
                                icon: const Icon(Icons.cancel),
                                onPressed: () {
                                  context.read<PaymentCubit>().clearRecipient();
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  _onEdit(context, isMulti);
                                },
                              ),
                            ],
                          ),
                        ])));
          });
    });
  }

  Widget _buildContactsText(List<Contact> contacts) {
    final List<String> contactNames = contacts
        .map((Contact contact) => humanizeContact('', contact, true, true))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          isExpanded || contactNames.length <= maxVisibleContacts
              ? contactNames.join(', ')
              : '${contactNames.take(maxVisibleContacts).join(', ')}...',
          style: const TextStyle(fontSize: 16.0),
        ),
        if (contactNames.length > maxVisibleContacts)
          Center(
              child: TextButton(
            onPressed: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Text(
                tr(isExpanded ? 'contacts_show_less' : 'contacts_show_more')),
          )),
      ],
    );
  }

  void _onEdit(BuildContext context, bool isMulti) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ContactSearchPage(
            startInMultiSelect: isMulti,
            searchUse: widget.searchUse,
            isEdit: true);
      },
    );
  }
}
