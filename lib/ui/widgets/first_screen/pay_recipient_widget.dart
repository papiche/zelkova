import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                avatar(state.contact!.avatar),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      if (state.contact!.title != null)
                        Text(
                          state.contact!.title,
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      if (state.contact!.subtitle != null)
                        Padding(
                            padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                            child: Text(
                              state.contact!.subtitle!,
                              style: const TextStyle(
                                fontSize: 16.0,
                              ),
                            )),
                    ],
                  ),
                ),
                // Is not is contact, allow to add to contacts
                // if (!contactsCubit.isContact(state.contact!.pubKey))
                BlocBuilder<ContactsCubit, ContactsState>(builder:
                    (BuildContext context, ContactsState contactState) {
                  return ContactFavIcon(
                      contact: state.contact!,
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
