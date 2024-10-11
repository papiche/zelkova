import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/payment_cubit.dart';
import '../../../data/models/payment_state.dart';
import '../../ui_helpers.dart';
import '../first_screen/contact_search_page.dart';
import '../first_screen/pay_contact_search_button.dart';

class DatePickerExample extends StatefulWidget {
  const DatePickerExample({super.key});

  @override
  State<DatePickerExample> createState() => _DatePickerExampleState();
}

class _DatePickerExampleState extends State<DatePickerExample> {
  List<DateTime?> _selectedDates = <DateTime?>[null, null];
  final int _maxDaysDifference = 30;

  final bool _isAnalyzing = false;
  final bool _analysisComplete = false;
  final String _report = '';
  final GlobalKey searchUserForAnalyzeKey =
      GlobalKey(debugLabel: 'searchUserForAnalyzeKey');

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
      final DateTime? endDate = results[1];

      if (startDate != null && endDate != null) {
        final int difference = endDate.difference(startDate).inDays;

        if (difference > _maxDaysDifference) {
          _showInvalidRangeDialog();
        } else {
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
          title: const Text('Rango de Fechas No Válido'),
          content: Text(
              'El rango de fechas no puede exceder los $_maxDaysDifference días.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentCubit, PaymentState>(
        builder: (BuildContext context, PaymentState state) {
      return Scaffold(
        appBar: AppBar(title: Text(tr('market_analysis'))),
        body: Center(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: PayContactSearchButton(
                    key: searchUserForAnalyzeKey,
                    btnText: 'Select people to analyze',
                    searchUse: SearchUse.marketAnalysis),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _openDatePicker,
                child: Text(
                  _selectedDates[0] == null
                      ? 'Selecciona Rango de Fechas'
                      : 'Fechas: ${DateFormat.yMMMd(currentLocale(context)).format(_selectedDates[0]!)} - ${DateFormat.yMMMd(currentLocale(context)).format(_selectedDates[1]!)}',
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: (_selectedDates[0] != null &&
                          _selectedDates[0] != null &&
                          state.contacts.isNotEmpty)
                      ? () {} // _startAnalysis
                      : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                  ),
                  child: const Text(
                    'Analyze',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (_isAnalyzing)
                const Center(child: CircularProgressIndicator()),
              if (_analysisComplete)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Report:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    Text(_report),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: () {}, // _downloadPDF,
                        icon: const Icon(Icons.download),
                        label: const Text('Download PDF'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      );
    });
  }
}
