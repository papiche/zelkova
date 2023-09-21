import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../data/models/transaction.dart';

class TransactionChart extends StatefulWidget {
  const TransactionChart({super.key, required this.transactions});

  final List<Transaction> transactions;

  @override
  State<StatefulWidget> createState() => TransactionChartState();
}

class TransactionChartState extends State<TransactionChart> {
  final double width = 7;

  static const Color leftBarColor = Colors.yellow;
  static const Color rightBarColor = Colors.red;
  static const Color avgColor = Colors.orange;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;

  String _selectedButton = 'DAY';

  List<BarChartGroupData> _getChartData(String buttonValue) {
    final Map<DateTime, List<Transaction>> groupedTransactions =
        <DateTime, List<Transaction>>{};

    for (final Transaction transaction in widget.transactions) {
      DateTime key;
      if (buttonValue == 'DAY') {
        key = DateTime(transaction.time.year, transaction.time.month,
            transaction.time.day);
      } else if (buttonValue == 'WEEK') {
        key = DateTime(transaction.time.year, transaction.time.month,
            transaction.time.day - transaction.time.weekday + 1);
      } else if (buttonValue == 'MONTH') {
        key = DateTime(transaction.time.year, transaction.time.month);
      } else if (buttonValue == 'YEAR') {
        key = DateTime(transaction.time.year);
      } else {
        throw ArgumentError('Invalid buttonValue: $buttonValue');
      }

      if (!groupedTransactions.containsKey(key)) {
        groupedTransactions[key] = <Transaction>[];
      }
      groupedTransactions[key]!.add(transaction);
    }

    final Map<DateTime, double> totals = <DateTime, double>{};
    for (final DateTime key in groupedTransactions.keys) {
      double total = 0;
      for (final Transaction transaction in groupedTransactions[key]!) {
        total += transaction.amount;
      }
      totals[key] = total;
    }

    final List<BarChartGroupData> chartData = <BarChartGroupData>[];
    final List<DateTime> sortedKeys = groupedTransactions.keys.toList()..sort();
    for (int i = 0; i < sortedKeys.length; i++) {
      final DateTime key = sortedKeys[i];
      final double total = totals[key]!;
      chartData.add(
        BarChartGroupData(
          x: i,
          barRods: <BarChartRodData>[
            BarChartRodData(
              toY: total,
              color: leftBarColor,
              width: width,
            ),
          ],
        ),
      );
    }

    return chartData;
  }

  Widget _buildButton(String buttonValue) {
    final bool isSelected = _selectedButton == buttonValue;
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedButton = buttonValue;
          showingBarGroups = _getChartData(buttonValue);
        });
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          isSelected ? Colors.blue : Colors.grey,
        ),
      ),
      child: Text(buttonValue),
    );
  }

  @override
  void initState() {
    super.initState();

    // En lugar de datos simulados, utilizamos las transacciones de verdad para generar los datos del gráfico.
    rawBarGroups = _getChartData(_selectedButton);
    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: BarChart(
                BarChartData(
                  maxY: 20,
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      tooltipBgColor: Colors.grey,
                      getTooltipItem: (BarChartGroupData a, int b,
                              BarChartRodData c, int d) =>
                          null,
                    ),
                    touchCallback:
                        (FlTouchEvent event, BarTouchResponse? response) {
                      if (response == null || response.spot == null) {
                        setState(() {
                          touchedGroupIndex = -1;
                          showingBarGroups =
                              List<BarChartGroupData>.of(rawBarGroups);
                        });
                        return;
                      }

                      touchedGroupIndex = response.spot!.touchedBarGroupIndex;

                      setState(() {
                        if (!event.isInterestedForInteractions) {
                          touchedGroupIndex = -1;
                          showingBarGroups =
                              List<BarChartGroupData>.of(rawBarGroups);
                          return;
                        }
                        showingBarGroups =
                            List<BarChartGroupData>.of(rawBarGroups);
                        if (touchedGroupIndex != -1) {
                          double sum = 0.0;
                          for (final BarChartRodData rod
                              in showingBarGroups[touchedGroupIndex].barRods) {
                            sum += rod.toY;
                          }
                          final double avg = sum /
                              showingBarGroups[touchedGroupIndex]
                                  .barRods
                                  .length;

                          showingBarGroups[touchedGroupIndex] =
                              showingBarGroups[touchedGroupIndex].copyWith(
                            barRods: showingBarGroups[touchedGroupIndex]
                                .barRods
                                .map((BarChartRodData rod) {
                              return rod.copyWith(toY: avg, color: avgColor);
                            }).toList(),
                          );
                        }
                      });
                    },
                  ),
                  titlesData: FlTitlesData(
                    rightTitles: const AxisTitles(),
                    topTitles: const AxisTitles(),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: bottomTitles,
                        reservedSize: 42,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        interval: 1,
                        getTitlesWidget: leftTitles,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  barGroups: showingBarGroups,
                  gridData: const FlGridData(show: false),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const TextStyle style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    if (value == 0) {
      text = '1K';
    } else if (value == 10) {
      text = '5K';
    } else if (value == 19) {
      text = '10K';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final List<String> titles = <String>[
      'Mn',
      'Te',
      'Wd',
      'Tu',
      'Fr',
      'St',
      'Su'
    ];

    if (value < 0 || value >= titles.length) {
      return Container();
    }

    final Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: <BarChartRodData>[
        BarChartRodData(
          toY: y1,
          color: leftBarColor,
          width: width,
        ),
        BarChartRodData(
          toY: y2,
          color: rightBarColor,
          width: width,
        ),
      ],
    );
  }

  Widget buildButtons(BuildContext context) {
    return AspectRatio(
        aspectRatio: 1,
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(
                    height: 38,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            // Cambiar la lógica aquí para actualizar el gráfico para mostrar datos diarios
                          });
                        },
                        child: const Text('Dia'),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            // Cambiar la lógica aquí para actualizar el gráfico para mostrar datos semanales
                          });
                        },
                        child: const Text('Semana'),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            // Cambiar la lógica aquí para actualizar el gráfico para mostrar datos mensuales
                          });
                        },
                        child: const Text('Mes'),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            // Cambiar la lógica aquí para actualizar el gráfico para mostrar datos anuales
                          });
                        },
                        child: const Text('Año'),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            _buildButton('Day'),
                            _buildButton('Week'),
                            _buildButton('Month'),
                            _buildButton('Year'),
                          ],
                        ),
                        const SizedBox(height: 16),
                        BarChart(
                          BarChartData(
                            maxY: 20,
                            barTouchData: BarTouchData(
                              touchTooltipData: BarTouchTooltipData(
                                tooltipBgColor: Colors.grey,
                                getTooltipItem: (BarChartGroupData a, int b,
                                        BarChartRodData c, int d) =>
                                    null,
                              ),
                              touchCallback: (FlTouchEvent event,
                                  BarTouchResponse? response) {
                                // ...
                              },
                            ),
                            titlesData: FlTitlesData(
                              rightTitles: const AxisTitles(),
                              topTitles: const AxisTitles(),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: bottomTitles,
                                  reservedSize: 42,
                                ),
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 28,
                                  interval: 1,
                                  getTitlesWidget: leftTitles,
                                ),
                              ),
                            ),
                            borderData: FlBorderData(
                              show: false,
                            ),
                            barGroups: showingBarGroups,
                            gridData: const FlGridData(show: false),
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  )
                ])));
  }
}
