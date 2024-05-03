import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:web_browser_detect/web_browser_detect.dart';

import '../../data/models/app_cubit.dart';
import '../../data/models/app_state.dart';
import '../../data/models/bottom_nav_cubit.dart';
import '../../data/models/multi_wallet_transaction_cubit.dart';
import '../../data/models/payment_cubit.dart';
import '../../data/models/payment_state.dart';
import '../../g1/api.dart';
import '../../shared_prefs_helper.dart';
import '../tutorial.dart';
import '../tutorial_keys.dart';
import '../widgets/bottom_widget.dart';
import '../widgets/card_drawer.dart';
import '../widgets/first_screen/credit_card.dart';
import '../widgets/first_screen/first_tutorial.dart';
import '../widgets/first_screen/pay_contact_search_button.dart';
import '../widgets/first_screen/pay_form.dart';
import '../widgets/first_screen/pay_qr_button.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  late Tutorial tutorial;

  @override
  void initState() {
    tutorial = FirstTutorial(
        context, context.read<AppCubit>().wasTutorialShown('first_screen'));
    super.initState();
    if (context.read<BottomNavCubit>().state == 0 &&
        context.read<MultiWalletTransactionCubit>().balance() == 0) {
      Future<void>.delayed(Duration.zero, () => tutorial.showTutorial());
    }
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<AppCubit, AppState>(
          builder: (BuildContext context, AppState state) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          fetchNodesIfNotReady();
          /* if (!state.warningViewed) {
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
          } */
          if (kIsWeb) {
            final Browser? browser = Browser.detectOrNull();
            if (!state.warningBrowserViewed) {
              if (browser == null ||
                  (browser.browserAgent != BrowserAgent.Chrome &&
                      browser.browserAgent != BrowserAgent.Firefox)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(tr('browser_warning')),
                    action: SnackBarAction(
                      label: 'OK',
                      onPressed: () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        context.read<AppCubit>().warningBrowserViewed();
                      },
                    ),
                  ),
                );
              }
            }
          }
        });
        final PaymentStatus paymentStatus =
            context.read<PaymentCubit>().state.status;
        if (paymentStatus == PaymentStatus.sending ||
            paymentStatus == PaymentStatus.isSent) {
          context.read<PaymentCubit>().reset();
        }
        return Consumer<SharedPreferencesHelper>(builder: (BuildContext context,
            SharedPreferencesHelper prefsHelper, Widget? child) {
          return BlocBuilder<PaymentCubit, PaymentState>(
              builder: (BuildContext context, PaymentState state) =>
                  Stack(children: <Widget>[
                    Scaffold(
                        appBar: AppBar(
                          title: Text(tr('credit_card_title')),
                          actions: <Widget>[
                            IconButton(
                              icon: const Icon(Icons.info_outline),
                              onPressed: () {
                                tutorial.showTutorial(showAlways: true);
                              },
                            ),
                          ],
                        ),
                        drawer: const CardDrawer(),
                        body: ListView(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            //physics: const AlwaysScrollableScrollPhysics(),
                            //controller: _controller,
                            // shrinkWrap: true,
                            children: <Widget>[
                              CreditCard(
                                  key: creditCardKey,
                                  publicKey: prefsHelper.getPubKey(),
                                  cardName: prefsHelper.getName(),
                                  isG1nkgoCard: prefsHelper.isG1nkgoCard()),
                              const SizedBox(height: 8),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                child: Divider(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground
                                      .withOpacity(.4),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(children: <Widget>[
                                Flexible(
                                    child: PayContactSearchButton(
                                        key: paySearchUserKey)),
                                const SizedBox(width: 10),
                                const PayQrButton()
                              ]),
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
      });
}
