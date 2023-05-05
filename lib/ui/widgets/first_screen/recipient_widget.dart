import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/contact_cubit.dart';
import '../../../data/models/contact_state.dart';
import '../../../data/models/payment_cubit.dart';
import '../../ui_helpers.dart';
import 'contact_fav_icon.dart';

class RecipientWidget extends StatelessWidget {
  const RecipientWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final PaymentCubit paymentCubit = BlocProvider.of<PaymentCubit>(context);
    final ContactsCubit contactsCubit = BlocProvider.of<ContactsCubit>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          avatar(paymentCubit.state.contact!.avatar),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (paymentCubit.state.contact!.title != null)
                  Text(
                    paymentCubit.state.contact!.title,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                if (paymentCubit.state.contact!.subtitle != null)
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                      child: Text(
                        paymentCubit.state.contact!.subtitle!,
                        style: const TextStyle(
                          fontSize: 16.0,
                        ),
                      )),
              ],
            ),
          ),
          // Is not is contact, allow to add to contacts
          if (!contactsCubit.isContact(paymentCubit.state.contact!.pubKey))
            BlocBuilder<ContactsCubit, ContactsState>(
                builder: (BuildContext context, ContactsState state) {
              return ContactFavIcon(
                  contact: paymentCubit.state.contact!,
                  contactsCubit: context.read<ContactsCubit>());
            }),
          IconButton(
            icon: const Icon(Icons.cancel),
            onPressed: () {
              context.read<PaymentCubit>().clearRecipient();
            },
          ),
        ],
      ),
    );
  }
}
