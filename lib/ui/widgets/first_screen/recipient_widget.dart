import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/payment_cubit.dart';
import '../../../data/models/payment_state.dart';
import '../../ui_helpers.dart';

class RecipientWidget extends StatelessWidget {
  const RecipientWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentCubit, PaymentState>(
        builder: (BuildContext context, PaymentState state) => Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    avatar(state.avatar != null, state.avatar),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            state.nick,
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            humanizePubKey(state.publicKey),
                            style: const TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.cancel),
                      onPressed: () {
                        context.read<PaymentCubit>().clearRecipient();
                      },
                    ),
                  ],
                ),
              ),
            ));
  }
}
