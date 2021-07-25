import 'package:flutter/material.dart';
import 'package:bezier_chart/bezier_chart.dart';

// Widget that will build the graph
Widget buildGraph(
    BuildContext context, List<Map<String, dynamic>> datesAndValues) {
  // Data is avalaible from a particular date and we are getting that here
  final fromDate = datesAndValues[0]['date'];

  // Data is avalaible until a particular date and we are getting that here
  final toDate = datesAndValues.last['date'];

  // Add dates and values corresponding to those dates
  // in a list
  List<DataPoint<DateTime>> dataPoints = [];
  for (final dateAndValue in datesAndValues) {
    dataPoints.add(DataPoint<DateTime>(
        value: double.parse(dateAndValue['value'].toString()),
        xAxis: dateAndValue['date']));
  }

  return Center(
    child: Container(
      decoration: BoxDecoration(
        color: Colors.red,
      ),
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width,
      child: BezierChart(
        fromDate: fromDate,
        bezierChartScale: BezierChartScale.WEEKLY,
        toDate: toDate,
        selectedDate: toDate,
        series: [
          BezierLine(
            data: dataPoints,
          ),
        ],
        config: BezierChartConfig(
          physics: BouncingScrollPhysics(),
          verticalIndicatorStrokeWidth: 3.0,
          verticalIndicatorColor: Colors.black26,
          showVerticalIndicator: true,
          verticalIndicatorFixedPosition: false,
          backgroundColor: Colors.transparent,
          footerHeight: 30.0,
        ),
      ),
    ),
  );
}
