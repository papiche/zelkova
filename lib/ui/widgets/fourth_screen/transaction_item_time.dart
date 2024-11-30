import 'package:flutter/material.dart';

import '../../ui_helpers.dart';

class TransactionItemTime extends StatefulWidget {
  const TransactionItemTime({
    super.key,
    required this.transactionTime,
    required this.locale,
  });

  final DateTime transactionTime;
  final String locale;

  @override
  State<TransactionItemTime> createState() => _TransactionItemTimeState();
}

class _TransactionItemTimeState extends State<TransactionItemTime> {
  bool _isFullText = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isFullText = !_isFullText;
        });
      },
      child: Text(
        _isFullText
            ? humanizeTimeFull(
                locale: widget.locale, utcDateTime: widget.transactionTime)
            : humanizeTime(widget.transactionTime, widget.locale) ?? '',
        style: const TextStyle(
          fontSize: 12.0,
          color: Colors.grey,
        ),
      ),
    );
  }
}
