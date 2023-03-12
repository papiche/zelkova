import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../g1/transaction.dart';

class BalanceChart extends StatefulWidget {
  const BalanceChart({super.key, required this.transactions});

  final List<Transaction> transactions;

  @override
  State<BalanceChart> createState() => _BalanceChartState();
}

class _BalanceChartState extends State<BalanceChart> {
  DateRangeType _dateRangeType = DateRangeType.MONTH;
  late List<Transaction> _transactions;

  //late List<LineChartBarData> _dataPoints;
  late LineChartData _data;

  @override
  void initState() {
    super.initState();
    _transactions = widget.transactions;
    _data = _getData();
  }

  List<Color> gradientColors = <Color>[
    Colors.blue,
    Colors.red,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildButton('Semana', DateRangeType.WEEK),
            const SizedBox(width: 10),
            _buildButton('Mes', DateRangeType.MONTH),
            const SizedBox(width: 10),
            _buildButton('Año', DateRangeType.YEAR),
            const SizedBox(width: 10),
            _buildButton('Todo', DateRangeType.ALL),
          ],
        ),
        Expanded(
          child: LineChart(
            _data
            /* minX: _dataPoints.first.x,
            maxX: _dataPoints.last.x,
            minY: 0,
            lineColor: Colors.blue,
            dotColor: Colors.blue,
            showCircles: true,
            circleRadius: 4,
            showLegends: false,
            graphPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8) */
            ,
          ),
        ),
      ],
    );
  }

  LineChartData _getData() {
    final DateTime now = DateTime.now();
    DateTime startDate;
    switch (_dateRangeType) {
      case DateRangeType.WEEK:
        startDate = now.subtract(const Duration(days: 7));
        break;
      case DateRangeType.MONTH:
        startDate = now.subtract(const Duration(days: 30));
        break;
      case DateRangeType.YEAR:
        startDate = now.subtract(const Duration(days: 365));
        break;
      case DateRangeType.ALL:
        startDate = _transactions.first.time;
        break;
    }

    DateTime currentDate =
        DateTime(startDate.year, startDate.month, startDate.day);
    final DateTime endDate = DateTime(now.year, now.month, now.day);

    Widget bottomTitleWidgets(double value, TitleMeta meta) {
      const TextStyle style = TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      );
      Widget text;
      switch (value.toInt()) {
        case 2:
          text = const Text('MAR', style: style);
          break;
        case 5:
          text = const Text('JUN', style: style);
          break;
        case 8:
          text = const Text('SEP', style: style);
          break;
        default:
          text = const Text('', style: style);
          break;
      }

      return SideTitleWidget(
        axisSide: meta.axisSide,
        child: text,
      );
    }

    Widget leftTitleWidgets(double value, TitleMeta meta) {
      const TextStyle style = TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 15,
      );
      String text;
      switch (value.toInt()) {
        case 1:
          text = '10K';
          break;
        case 3:
          text = '30k';
          break;
        case 5:
          text = '50k';
          break;
        default:
          return Container();
      }

      return Text(text, style: style, textAlign: TextAlign.left);
    }

    final LineChartData data = LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingVerticalLine: (double value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (double value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
            interval: 1,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: <LineChartBarData>[
        LineChartBarData(
          spots: const <FlSpot>[
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: <Color>[
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
            ],
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: <Color>[
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
              ],
            ),
          ),
        ),
      ],
    );

    final List<DataPoint> dataPoints = <DataPoint>[];
    double balance = 0;
    while (currentDate.isBefore(endDate)) {
      double dayBalance = 0;
      for (final Transaction t in _transactions) {
        if (t.time.year == currentDate.year &&
            t.time.month == currentDate.month &&
            t.time.day == currentDate.day) {
          dayBalance += t.amount;
        }
      }
      balance += dayBalance;
      dataPoints.add(DataPoint(_getXValue(currentDate), balance));
      currentDate = _getNextDate(currentDate);
    }

    double dayBalance = 0;
    for (final Transaction t in _transactions) {
      if (t.time.year == endDate.year &&
          t.time.month == endDate.month &&
          t.time.day == endDate.day) {
        dayBalance += t.amount;
      }
    }
    balance += dayBalance;
    dataPoints.add(DataPoint(_getXValue(endDate), balance));

    return data;
  }

  double _getXValue(DateTime date) {
    switch (_dateRangeType) {
      case DateRangeType.WEEK:
        return date.weekday.toDouble();
      case DateRangeType.MONTH:
        return date.day.toDouble();
      case DateRangeType.YEAR:
        return date.month.toDouble();
      case DateRangeType.ALL:
        return date.millisecondsSinceEpoch.toDouble();
    }
  }

  DateTime _getNextDate(DateTime date) {
    switch (_dateRangeType) {
      case DateRangeType.WEEK:
        return date.add(const Duration(days: 1));

      case DateRangeType.MONTH:
        final int daysInMonth = DateTime(date.year, date.month + 1, 0).day;
        if (date.day == daysInMonth) {
          // Last day of the month
          return DateTime(date.year, date.month + 1);
        } else {
          return DateTime(date.year, date.month, date.day + 1);
        }
      case DateRangeType.YEAR:
        if (date.month == 12) {
          // Last month of the year
          return DateTime(date.year + 1);
        } else {
          return DateTime(date.year, date.month + 1);
        }
      case DateRangeType.ALL:
        throw Exception('Invalid DateRangeType');
    }
  }

  Widget _buildButton(String label, DateRangeType type) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _dateRangeType = type;
          _data = _getData();
        });
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: _dateRangeType == type ? Colors.white : null,
        backgroundColor: _dateRangeType == type ? Colors.blue : null,
      ),
      child: Text(label),
    );
  }
}

enum DateRangeType {
  WEEK,
  MONTH,
  YEAR,
  ALL,
}

class DataPoint {
  DataPoint(this.x, this.y);

  final double x;
  final double y;
}
