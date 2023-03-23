import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/app_cubit.dart';
import '../../data/models/app_state.dart';
import '../../data/models/payment_cubit.dart';
import '../../data/models/payment_state.dart';
import '../widgets/bottom_widget.dart';
import '../widgets/card_drawer.dart';
import '../widgets/first_screen/credit_card.dart';
import '../widgets/first_screen/pay_contact_search_button.dart';
import 'pay_form.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<AppCubit, AppState>(
          builder: (BuildContext context, AppState state) {
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              if (!state.warningViewed) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(tr('demo_desc')),
                    action: SnackBarAction(
                      label: 'OK',
                      onPressed: () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        context.read<AppCubit>().warningViewed();
                      },
                    ),
                  ),
                );
              }
            });
            return BlocBuilder<PaymentCubit, PaymentState>(
                builder: (BuildContext context, PaymentState state) =>
                    Stack(children: <Widget>[
                      Scaffold(
                          appBar: AppBar(title: Text(tr('credit_card_title'))),
                          drawer: const CardDrawer(),
                          body: ListView(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16),
                              //physics: const AlwaysScrollableScrollPhysics(),
                              //controller: _controller,
                              // shrinkWrap: true,
                              children: <Widget>[
                                CreditCard(),
                                const SizedBox(height: 8),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24),
                                  child: Divider(
                                    color: Theme
                                        .of(context)
                                        .colorScheme
                                        .onBackground
                                        .withOpacity(.4),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const PayContactSearchButton(),
                                const SizedBox(height: 10),
                                const PayForm(),
                                const BottomWidget()
                              ])),
                      Visibility(
                        visible: state.status == PaymentStatus.sending,
                        child: Container(
                          color: Colors.black.withOpacity(0.5),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      )
                    ]));
          });
}
