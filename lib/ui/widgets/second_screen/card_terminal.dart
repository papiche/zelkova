import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

import '../../tutorial_keys.dart';
import '../../ui_helpers.dart';
import 'card_terminal_screen.dart';
import 'rubber_button.dart';

class CardTerminal extends StatefulWidget {
  const CardTerminal({super.key});

  @override
  State<CardTerminal> createState() => _CardTerminalState();
}

class _CardTerminalState extends State<CardTerminal> {
  String _currentValue = '';
  final List<String> _numbers = <String>[
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    'DEC',
    '0',
    '+',
  ];
  final int _cancelIndex = 12;
  final int _backspaceIndex = 13;
  final int _submitIndex = 14;

  late String _decimalSep;

  @override
  Widget build(BuildContext context) {
    _decimalSep = decimalSep(context);
    _numbers[9] = _decimalSep;
    return Expanded(
        child: ListView(children: <Widget>[
      Padding(
          padding: EdgeInsets.symmetric(
              horizontal: bigScreen(context) ? 50.0 : 50.0),
          child: Card(
            elevation: 8.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Container(
              width: 320.0,
              //height: 700,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    Colors.grey[800]!,
                    Colors.grey[500]!,
                  ],
                ),
              ),
              child: Column(children: <Widget>[
                CardTerminalScreen(amount: _currentValue),
                SizedBox(height: bigScreen(context) ? 8.0 : 2.0),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: GridView.count(
                        key: receiveAmountKey,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: bigScreen(context) ? 1.75 : 2.25,
                        padding: EdgeInsets.zero,
                        children: <Widget>[
                          for (int i = 0; i < _numbers.length + 3; i++)
                            _buildKeyboardButton(i)
                        ]))
              ]),
            ),
          ))
    ]));
  }

  Widget _buildKeyboardButton(int index) {
    if (index == _backspaceIndex) {
      return RubberButton(
          // Yellow, remove
          bgColor: const Color(0xFFF7E378),
          icon: Icons.backspace,
          onPressed: () {
            vibrateIfPossible();
            setState(() {
              _currentValue = _currentValue.isNotEmpty
                  ? _currentValue.substring(0, _currentValue.length - 1)
                  : '';
            });
          });
    } else if (index == _submitIndex) {
      return RubberButton(
          // Green, send
          bgColor: const Color(0xFF36B649),
          // icon: Icons.subdirectory_arrow_left,
          label: '=',
          onPressed: () {
            vibrateIfPossible();
            setState(() {
              _currentValue = formatAmountWithLocale(
                amount: calculate(
                    textInTerminal: _currentValue, decimalSep: _decimalSep),
                isG1: true,
                locale: currentLocale(context),
                useSymbol: false,
              );
            });
          });
    } else if (index == _cancelIndex) {
      return RubberButton(
          // Red, cancel
          bgColor: const Color(0xFFCD303D),
          icon: Icons.cancel,
          onPressed: () {
            vibrateIfPossible();
            setState(() {
              _currentValue = '';
            });
          });
    } else
      return RubberButton(
          key: index == 11 ? receiveSumKey : null,
          label: _numbers[index],
          onPressed: () {
            vibrateIfPossible();
            /* if (_numbers[index] == '+') {
              return;
            } */
            if (_numbers[index] == _decimalSep &&
                _currentValue.contains(_decimalSep)) {
              return;
            }
            setState(() {
              _currentValue += _numbers[index];
              if (_currentValue == _decimalSep) {
                _currentValue = '0$_currentValue';
              }
            });
          });
  }
}

Future<void> vibrateIfPossible() async {
  try {
    final bool? hasVibrator = await Vibration.hasVibrator();
    if (hasVibrator ?? false) {
      Vibration.vibrate(duration: 100);
    }
  } catch (e) {
    // ok we tried...
  }
}
