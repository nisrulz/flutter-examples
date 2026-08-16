import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

// Widget that will build the graph
Widget buildGraph(
    BuildContext context, List<Map<String, dynamic>> datesAndValues) {
  // Convert the dates and values into chart points.
  final spots = <FlSpot>[];
  for (var i = 0; i < datesAndValues.length; i++) {
    final value = double.parse(datesAndValues[i]['value'].toString());
    spots.add(FlSpot(i.toDouble(), value));
  }

  return Center(
    child: Container(
      decoration: BoxDecoration(
        color: Colors.red,
      ),
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LineChart(
          LineChartData(
            gridData: FlGridData(show: true),
            titlesData: FlTitlesData(show: true),
            borderData: FlBorderData(show: true),
            lineBarsData: [
              LineChartBarData(
                spots: spots,
                isCurved: true,
                color: Colors.white,
                belowBarData: BarAreaData(show: false),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
