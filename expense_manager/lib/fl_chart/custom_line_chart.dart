import 'package:expense_manager/misc/extensions.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'index.dart';

class CustomLineChart extends StatelessWidget {
  final List<LineChartBarData> data;
  final double? height;
  final double? width;
  final GetTitleWidgetFunction? getBottomTitlesWidget;
  final AxisTitles? leftTitles;
  final AxisTitles? topTitles;
  final AxisTitles? rightTitles;
  final AxisTitles? bottomTitles;
  final Color? backgroundColor;
  final FlGridData? gridData;
  final double? minY;
  final double? maxY;
  final double? minX;
  final double? maxX;
  final LineTouchData? lineTouchData;
  final double? leftTitlesInterval;

  const CustomLineChart({
    super.key,
    required this.data,
    this.width,
    this.height = 200,
    this.getBottomTitlesWidget,
    this.leftTitles,
    this.topTitles,
    this.rightTitles,
    this.bottomTitles,
    this.backgroundColor,
    this.gridData,
    this.minX,
    this.minY,
    this.maxY,
    this.maxX,
    this.lineTouchData,
    this.leftTitlesInterval,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width,
      height: height,
      child: LineChart(
        LineChartData(
          lineBarsData: data,
          backgroundColor: backgroundColor ?? Color(0xFF222222),
          clipData: FlClipData.all(),
          minX: minX,
          maxX: maxX,
          minY: minY ?? _getMin(),
          maxY: maxY,
          gridData: gridData ??
              FlGridData(
                drawVerticalLine: false,
              ),
          titlesData: FlTitlesData(
            bottomTitles: bottomTitles ??
                AxisTitles(
                  sideTitles: SideTitles(
                    interval: 1,
                    showTitles: true,
                    reservedSize: 30,
                    getTitlesWidget: getBottomTitlesWidget ??
                        (value, meta) {
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            space: 3,
                            child: Text(value.toString()),
                          );
                        },
                  ),
                ),
            topTitles: topTitles ??
                AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
            leftTitles: leftTitles ??
                AxisTitles(
                  sideTitles: SideTitles(
                    reservedSize: 33,
                    interval: leftTitlesInterval,
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        fitInside: SideTitleFitInsideData.disable(),
                        child: Text(
                          value.shortForm(),
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      );
                    },
                  ),
                ),
            rightTitles: rightTitles ??
                AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false,
                    reservedSize: 30,
                  ),
                ),
          ),
          borderData: FlBorderData(show: false),
          lineTouchData: lineTouchData ??
              LineTouchData(
                touchCallback: (event, response) {},
                touchTooltipData: LineTouchTooltipData(
                  tooltipBgColor: Color(0xEEFFFFFF),
                ),
              ),
        ),
      ),
    );
  }

  double _getMin() {
    final values = data
        .map((e) => e.spots.map((e) => e.y))
        .expand((element) => element)
        .toList();
    if (values.isEmpty) return 0;
    return values.reduce(math.min) / 1.2;
  }
}
