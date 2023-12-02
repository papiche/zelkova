import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/contact.dart';
import '../../../data/models/contact_cubit.dart';
import '../../../data/models/contact_state.dart';
import '../../../data/models/payment_cubit.dart';
import '../../../data/models/payment_state.dart';
import '../../ui_helpers.dart';
import 'contact_fav_icon.dart';

class PayRecipientWidget extends StatelessWidget {
  const PayRecipientWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentCubit, PaymentState>(
        builder: (BuildContext context, PaymentState state) {
      final bool isMulti = state.isMultiple();
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
                    child: Text('${state.contacts.length}'),
                  )
                else
                  avatar(state.contacts[0].avatar),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      if (isMulti)
                        Text(
                          state.contacts
                              .map((Contact contact) =>
                                  humanizeContact('', contact, true, true))
                              .join(', '),
                          style: const TextStyle(
                            fontSize: 16.0,
                          ),
                        )
                      else if (state.contacts[0].title != null)
                        Text(
                          state.contacts[0].title,
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      if (!isMulti && state.contacts[0].subtitle != null)
                        Padding(
                            padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                            child: Text(
                              state.contacts[0].subtitle!,
                              style: const TextStyle(
                                fontSize: 16.0,
                              ),
                            )),
                    ],
                  ),
                ),
                if (!isMulti)
                  BlocBuilder<ContactsCubit, ContactsState>(builder:
                      (BuildContext context, ContactsState contactState) {
                    return ContactFavIcon(
                        contact: state.contacts[0],
                        contactsCubit: context.read<ContactsCubit>(),
                        paymentCubit: context.watch<PaymentCubit>());
                  }),
                IconButton(
                  icon: const Icon(Icons.cancel),
                  onPressed: () {
                    context.read<PaymentCubit>().clearRecipient();
                  },
                ),
              ],
            ),
          ));
    });
  }
}
