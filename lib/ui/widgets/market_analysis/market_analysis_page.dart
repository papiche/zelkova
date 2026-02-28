import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../../data/models/app_cubit.dart';
import '../../../data/models/contact.dart';
import '../../../data/models/payment_cubit.dart';
import '../../../data/models/payment_state.dart';
import '../../../g1/currency.dart';
import '../../contacts_helper.dart';
import '../../currency_helper.dart';
import '../../in_dev_helper.dart';
import '../../locale_helper.dart';
import '../../logger.dart';
import '../../ui_helpers.dart';
import '../contact_page.dart';
import '../first_screen/contact_search_page.dart';
import '../first_screen/pay_contact_search_button.dart';
import 'simple_txs_panel.dart';

class MarketAnalysisPage extends StatefulWidget {
  const MarketAnalysisPage({super.key});

  @override
  State<MarketAnalysisPage> createState() => _MarketAnalysisPageState();
}

class _MarketAnalysisPageState extends State<MarketAnalysisPage> {
  List<DateTime?> _selectedDates = <DateTime?>[null, null];
  final int _maxDaysDifference = 365;
  bool _isAnalyzing = false;
  bool _analysisComplete = false;
  String _report = '';
  List<Widget> contactWidgets = <Widget>[];
  double totalReceivedAllContacts = 0.0;
  int totalReceivedAllContactsNumber = 0;
  double totalSentAllContacts = 0.0;
  int totalSentAllContactsNumber = 0;
  final bool _showDetails = false;
  int _processedContacts = 0;
  Set<Contact> displayedContacts = <Contact>{};
  final Set<Contact> allNewContacts = <Contact>{};

  Future<void> _openDatePicker() async {
    final List<DateTime?>? results = await showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(
        calendarType: CalendarDatePicker2Type.range,
        firstDate: DateTime(2022),
        lastDate: DateTime.now(),
      ),
      dialogSize: const Size(325, 400),
      value: _selectedDates,
    );

    if (results != null) {
      final DateTime? startDate = results[0];
      DateTime? endDate = results[1];

      if (startDate != null && endDate != null) {
        final int difference = endDate.difference(startDate).inDays;

        if (difference > _maxDaysDifference) {
          _showInvalidRangeDialog();
        } else {
          if (endDate.isAtSameMomentAs(DateTime.now().toLocal().startOfDay())) {
            endDate = DateTime.now();
          }
          setState(() {
            _selectedDates = results;
          });
        }
      } else {
        setState(() {
          _selectedDates = results;
        });
      }
    }
  }

  void _showInvalidRangeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(tr('invalid_date_range')),
          content: Text(tr('date_range_exceed', namedArgs: <String, String>{
            'number': _maxDaysDifference.toString()
          })),
          actions: <Widget>[
            TextButton(
              child: Text(tr('ok')),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  late AppCubit appCubit;
  late bool isG1;
  late double currentUd;
  late String currentSymbol;
  late NumberFormat currentNumber;
  late bool isCurrencyBefore;
  final Duration _delay = const Duration(milliseconds: 300);

  @override
  void initState() {
    appCubit = context.read<AppCubit>();
    super.initState();
  }

  // PDF report generation disabled (pdf package commented out for WASM compat)
  // Future<void> _generatePdfReport(BuildContext context) async { ... }

  @override
  Widget build(BuildContext context) {
    isG1 = appCubit.currency == Currency.G1;
    currentUd = appCubit.currentUd;
    currentSymbol = currentCurrencyTrimmed(isG1);
    currentNumber = currentNumberFormat(
        useSymbol: true, isG1: isG1, locale: currentLocale(context), amount: 1);
    isCurrencyBefore =
        isSymbolPlacementBefore(currentNumber.symbols.CURRENCY_PATTERN);
    return BlocBuilder<PaymentCubit, PaymentState>(
        builder: (BuildContext context, PaymentState state) {
      return FutureBuilder<List<Contact>>(
          future: enrichContacts(context, state.contacts),
          builder: (BuildContext context,
                  AsyncSnapshot<List<Contact>> snapshot) =>
              Scaffold(
                  appBar: AppBar(
                      title: Text(tr('market_analysis')),
                      actions: <Widget>[
                        IconButton(
                          icon: const Icon(Icons.refresh),
                          onPressed: () {
                            setState(() {
                              contactWidgets.clear();
                              totalReceivedAllContacts = 0.0;
                              totalSentAllContacts = 0.0;
                              totalSentAllContactsNumber = 0;
                              totalReceivedAllContactsNumber = 0;
                              _selectedDates = <DateTime?>[null, null];
                              _isAnalyzing = false;
                              _report = '';
                              _analysisComplete = false;
                              displayedContacts.clear();
                              allNewContacts.clear();
                            });
                          },
                        ),
                      ]),
                  body: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: PayContactSearchButton(
                                btnText: tr('select_people_to_analyze'),
                                searchUse: SearchUse.marketAnalysis),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: _openDatePicker,
                            child: Text(
                              _selectedDates[0] == null
                                  ? tr('select_date_range')
                                  : '${tr('dates')}: ${DateFormat.yMMMd(currentLocale(context)).format(_selectedDates[0]!)} - ${DateFormat.yMMMd(currentLocale(context)).format(_selectedDates[1]!)}',
                            ),
                          ),
                          const SizedBox(height: 20),
                          if (_isAnalyzing && !_analysisComplete)
                            const CircularProgressIndicator(),
                          if (!_isAnalyzing)
                            Center(
                              child: ElevatedButton(
                                onPressed: (_isAnalyzing == false &&
                                        _selectedDates[0] != null &&
                                        _selectedDates[1] != null &&
                                        snapshot.data != null)
                                    ? () {
                                        setState(() {
                                          _isAnalyzing = true;
                                          contactWidgets.clear();
                                          totalReceivedAllContacts = 0.0;
                                          totalSentAllContacts = 0.0;
                                          totalSentAllContactsNumber = 0;
                                          totalReceivedAllContactsNumber = 0;
                                          _processedContacts = 0;
                                          _report = '';
                                          displayedContacts.clear();
                                          allNewContacts.clear();
                                        });
                                        processContacts(snapshot.data!, true,
                                            snapshot.data!.length);
                                      }
                                    : null,
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 50, vertical: 20),
                                ),
                                child: Text(tr('analyze'),
                                    style: const TextStyle(fontSize: 24)),
                              ),
                            ),
                          const SizedBox(height: 10),
                          if (contactWidgets.isNotEmpty)
                            Card(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      tr('total_received_sent'),
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 10),
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4.0),
                                        child: Text.rich(
                                            TextSpan(children: <InlineSpan>[
                                          TextSpan(
                                            text: tr('total_received',
                                                namedArgs: <String, String>{
                                                  'number':
                                                      totalReceivedAllContactsNumber
                                                          .toString()
                                                }),
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.green),
                                          ),
                                          separatorSpan(),
                                          humanizeAmount(
                                              isCurrencyBefore,
                                              context,
                                              isG1,
                                              true,
                                              currentSymbol,
                                              16,
                                              totalReceivedAllContacts,
                                              currentUd,
                                              Colors.green)
                                        ]))),
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4.0),
                                        child: Text.rich(
                                            TextSpan(children: <InlineSpan>[
                                          TextSpan(
                                            text: tr('total_sent',
                                                namedArgs: <String, String>{
                                                  'number':
                                                      totalSentAllContactsNumber
                                                          .toString()
                                                }),
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.red),
                                          ),
                                          separatorSpan(),
                                          humanizeAmount(
                                              isCurrencyBefore,
                                              context,
                                              isG1,
                                              true,
                                              currentSymbol,
                                              16,
                                              totalSentAllContacts,
                                              currentUd,
                                              Colors.red)
                                        ])))
                                  ],
                                ),
                              ),
                            ),
                          if (_analysisComplete)
                            if (inDevelopment) const SizedBox(height: 10),
                          // PDF download button disabled (pdf package
                          // commented out for WASM compatibility)
                          ...contactWidgets,
                        ],
                      ),
                    ),
                  )));
    });
  }

  Future<void> processContacts(List<Contact> contacts,
      bool collectOtherContacts, int initialContactLength) async {
    for (final Contact contact in contacts) {
      if (displayedContacts.any((Contact c) => c.keyEqual(contact))) {
        continue;
      }
      setState(() {
        contactWidgets.add(createAccountSummary(
            context, contact, collectOtherContacts, initialContactLength));
      });
      displayedContacts.add(contact);

      await Future<void>.delayed(_delay);
    }
  }

  Card createAccountSummary(BuildContext context, Contact contact,
      bool collectOtherContacts, int initialContactsLength) {
    return Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(children: <Widget>[
                    GestureDetector(
                        onTap: () async {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return ContactPage(contact: contact);
                            },
                          );
                        },
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width *
                              0.8, // Adjust the width as needed
                          child: TextScroll(
                            '${contact.title}      ',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ))
                  ]),
                  SimpleTransactionsPanel(
                    key: ValueKey<String>('simple-txs-panel-${contact.pubKey}'),
                    from: _selectedDates[0]!.millisecondsSinceEpoch ~/ 1000,
                    to: _selectedDates[1]!.millisecondsSinceEpoch ~/ 1000,
                    contact: contact,
                    pageSize: 40,
                    isCurrencyBefore: isCurrencyBefore,
                    isG1: isG1,
                    currentSymbol: currentSymbol,
                    currentUd: currentUd,
                    initiallyExpanded: _showDetails,
                    collectOtherContacts: collectOtherContacts,
                    onResult: (double totalReceived,
                        double totalSent,
                        int totalReceivedNumber,
                        int totalSentNumber,
                        Set<Contact> newContacts,
                        String markdown) async {
                      setState(() {
                        totalReceivedAllContacts += totalReceived;
                        totalSentAllContacts += totalSent;
                        totalReceivedAllContactsNumber += totalReceivedNumber;
                        totalSentAllContactsNumber += totalSentNumber;
                        _report += '\n$markdown';
                        _processedContacts++;
                      });
                      if (collectOtherContacts) {
                        newContacts.removeWhere((Contact contact) =>
                            displayedContacts.contains(contact));
                        final List<Contact> enrichedContacts =
                            await enrichContacts(context, newContacts.toList());
                        allNewContacts.addAll(enrichedContacts);
                      }

                      setState(() {
                        if (collectOtherContacts &&
                            _processedContacts == initialContactsLength) {
                          if (allNewContacts.isNotEmpty) {
                            contactWidgets.add(Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(tr('other_contacts_involved'),
                                    style: const TextStyle(fontSize: 24))));
                            processContacts(allNewContacts.toList(), false, 0);
                          }
                          _analysisComplete = true;
                        }
                      });
                    },
                  )
                ])));
  }
}
