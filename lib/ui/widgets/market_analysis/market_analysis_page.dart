import 'dart:io';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../data/models/app_cubit.dart';
import '../../../data/models/contact.dart';
import '../../../data/models/payment_cubit.dart';
import '../../../data/models/payment_state.dart';
import '../../../g1/currency.dart';
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
  final bool _showDetails = true;
  int _processedContacts = 0;

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

  @override
  void initState() {
    appCubit = context.read<AppCubit>();
    super.initState();
  }

  Future<void> _generatePdfReport(BuildContext context) async {
    final pw.Document pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: <pw.Widget>[
            pw.Text(tr('market_analysis_report'),
                style: const pw.TextStyle(fontSize: 24)),
            pw.SizedBox(height: 20),
            pw.Text('${tr('total_received')}: $totalReceivedAllContacts'),
            pw.Text('${tr('total_sent')}: $totalSentAllContacts'),
            if (_report.isNotEmpty) pw.Text(_report),
          ],
        ),
      ),
    );

    final Directory directory = await getApplicationDocumentsDirectory();
    if (directory == null) {
      debugPrint('App files directory not found');
      return;
    }
    const String fileName = 'market_analysis_report.pdf';
    final File file = File(join(directory.path, fileName));
    await file.writeAsBytes(await pdf.save());
    if (!context.mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(tr('pdf_generated'))),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isG1 = appCubit.currency == Currency.G1;
    final double currentUd = appCubit.currentUd;
    final String currentSymbol = currentCurrencyTrimmed(isG1);
    final NumberFormat currentNumber = currentNumberFormat(
        useSymbol: true, isG1: isG1, locale: currentLocale(context));
    final bool isCurrencyBefore =
        isSymbolPlacementBefore(currentNumber.symbols.CURRENCY_PATTERN);
    return BlocBuilder<PaymentCubit, PaymentState>(
        builder: (BuildContext context, PaymentState state) {
      return Scaffold(
          appBar: AppBar(title: Text(tr('market_analysis')), actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                setState(() {
                  contactWidgets.clear();
                  totalReceivedAllContacts = 0.0;
                  totalSentAllContacts = 0.0;
                  _selectedDates = <DateTime?>[null, null];
                  _isAnalyzing = false;
                  _report = '';
                  _analysisComplete = false;
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
                  if (!_isAnalyzing) const SizedBox(height: 20),
                  if (!_isAnalyzing)
                    Center(
                      child: ElevatedButton(
                        onPressed: (_isAnalyzing == false &&
                                _selectedDates[0] != null &&
                                _selectedDates[1] != null &&
                                state.contacts.isNotEmpty)
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
                                });

                                void processContacts(List<Contact> contacts,
                                    [bool collectOtherContacts = false]) {
                                  for (final Contact contact in contacts) {
                                    contactWidgets.add(
                                      Card(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 15),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Row(children: <Widget>[
                                                GestureDetector(
                                                  onTap: () async {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return ContactPage(
                                                            contact: contact);
                                                      },
                                                    );
                                                  },
                                                  child: Text(
                                                    contact.title,
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                )
                                              ]),
                                              SimpleTransactionsPanel(
                                                from: _selectedDates[0]!
                                                        .millisecondsSinceEpoch ~/
                                                    1000,
                                                to: _selectedDates[1]!
                                                        .millisecondsSinceEpoch ~/
                                                    1000,
                                                contact: contact,
                                                pageSize: 40,
                                                isCurrencyBefore:
                                                    isCurrencyBefore,
                                                isG1: isG1,
                                                currentSymbol: currentSymbol,
                                                currentUd: currentUd,
                                                initiallyExpanded: _showDetails,
                                                collectOtherContacts:
                                                    collectOtherContacts,
                                                onResult: (double totalReceived,
                                                    double totalSent,
                                                    int totalReceivedNumber,
                                                    int totalSentNumber,
                                                    Set<Contact> newContacts,
                                                    String markdown) {
                                                  setState(() {
                                                    totalReceivedAllContacts +=
                                                        totalReceived;
                                                    totalSentAllContacts +=
                                                        totalSent;
                                                    totalReceivedAllContactsNumber +=
                                                        totalReceivedNumber;
                                                    totalSentAllContactsNumber +=
                                                        totalSentNumber;
                                                    _report += '\n$markdown';
                                                    _processedContacts++;
                                                    if (_processedContacts ==
                                                        state.contacts.length) {
                                                      _analysisComplete = true;
                                                      contactWidgets.add(Card(
                                                          margin: const EdgeInsets
                                                              .symmetric(
                                                              vertical: 10,
                                                              horizontal: 15),
                                                          child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              child: Text(
                                                                  tr(
                                                                      'other_contacts_involved'),
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          24)))));
                                                    }

                                                    if (newContacts
                                                        .isNotEmpty) {
                                                      processContacts(
                                                          newContacts.toList());
                                                    }
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                }

                                // Disabled right now
                                processContacts(state.contacts, false);
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
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child:
                                    Text.rich(TextSpan(children: <InlineSpan>[
                                  TextSpan(
                                    text: tr('total_received',
                                        namedArgs: <String, String>{
                                          'number':
                                              totalReceivedAllContactsNumber
                                                  .toString()
                                        }),
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.green),
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child:
                                    Text.rich(TextSpan(children: <InlineSpan>[
                                  TextSpan(
                                    text: tr('total_sent',
                                        namedArgs: <String, String>{
                                          'number': totalSentAllContactsNumber
                                              .toString()
                                        }),
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.red),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 10),
                        Center(
                          child: ElevatedButton.icon(
                            onPressed: () => _generatePdfReport(context),
                            icon: const Icon(Icons.download),
                            label: Text(tr('download_pdf')),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ...contactWidgets,
                ],
              ),
            ),
          ));
    });
  }
}
