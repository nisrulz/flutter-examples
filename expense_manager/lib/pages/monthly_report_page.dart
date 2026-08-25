import 'package:expense_manager/components/date_range_filter_view.dart';
import 'package:expense_manager/controllers/monthly_report_controller.dart';
import 'package:expense_manager/misc/extensions.dart';
import 'package:expense_manager/components/misc/rounded_container.dart';
import 'package:expense_manager/fl_chart/custom_line_chart.dart';
import 'package:expense_manager/models/transaction.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MonthlyReportPage extends StatelessWidget {
  const MonthlyReportPage({super.key});

  MonthlyReportController get _controller =>
      Get.find<MonthlyReportController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MonthlyReportController>(
      init: MonthlyReportController(),
      builder: (controller) {
        return SingleChildScrollView(
          child: GetBuilder<MonthlyReportController>(
              init: MonthlyReportController(),
              builder: (controller) {
                return Padding(
                  padding: EdgeInsets.all(8).copyWith(left: 0, right: 0),
                  child: Column(
                    children: [
                      // date filter
                      DateRangeFilterView(
                        onDateSelected: (String range) {
                          controller.loadChartData(range);
                        },
                      ),

                      _buildChart(context),

                      SizedBox(height: 16),

                      _buildChartDetails(),
                    ],
                  ),
                );
              }),
        );
      },
    );
  }

  Widget _buildChart(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: Color(0xFF222222)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16).copyWith(top: 16),
        child: CustomLineChart(
          minY: 0,
          minX: 0,
          maxY: _controller.upperBound,
          data: [
            if (_controller.expenseData.isNotEmpty)
              _buildLineChartBarData(
                _controller.expenseData,
                color: Color(0xAAFF0000),
                fillColor: Color(0x33FF0000),
                show: _controller.shouldDisplayInChart(1),
              ),
            if (_controller.incomeData.isNotEmpty)
              _buildLineChartBarData(
                _controller.incomeData,
                color: Color(0xAA00FF00),
                fillColor: Color(0x2200FF00),
                show: _controller.shouldDisplayInChart(2),
              ),
            if (_controller.earningsData.isNotEmpty)
              _buildLineChartBarData(
                _controller.earningsData,
                color: Color(0xFF42A5F5),
                fillColor: Color(0x3342A5F5),
                show: _controller.shouldDisplayInChart(3),
              ),
          ],
          leftTitlesInterval: _controller.yAxisInterval,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              interval: _controller.xAxisInterval.roundToDouble(),
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                if (value >= _controller.largerTransactionData.length)
                  return Text('');
                if (value == _controller.largerTransactionData.length - 1 &&
                    _controller.isLargeDataSet) return Text('');

                final transaction = _controller.expenseData[value.toInt()];
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Text(
                    _controller.isLargeDataSet
                        ? transaction.friendlyMonthYear
                        : transaction.friendlyMonth,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 13,
                          color: Colors.white,
                        ),
                  ),
                );
              },
            ),
          ),
          lineTouchData: LineTouchData(
            touchCallback: (event, res) {
              final spots = res?.lineBarSpots ?? [];
              if (spots.isEmpty) return;
              _controller.onChartTouched(spots[0].spotIndex);
            },
            touchTooltipData: LineTouchTooltipData(
              tooltipBgColor: Color(0xEEFFFFFF),
              maxContentWidth: 300,
              getTooltipItems: (spots) {
                final index = spots[0].spotIndex;
                return [
                  LineTooltipItem(
                    _controller.earningsData[index].friendlyMonthYear,
                    TextStyle(),
                  ),
                  LineTooltipItem(
                    "Expenses: ${_controller.expenseData[index].totalAmountCents.toMoney()}",
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                  LineTooltipItem(
                    "Income: ${_controller.incomeData[index].totalAmountCents.toMoney()}",
                    TextStyle(
                        color: Colors.green.shade700,
                        fontWeight: FontWeight.bold),
                  ),
                ];
              },
            ),
          ),
        ),
      ),
    );
  }

  LineChartBarData _buildLineChartBarData(
    List<MonthlySpotData<Transaction>> data, {
    Color? color,
    Color? fillColor,
    bool show = true,
  }) {
    return LineChartBarData(
      isCurved: true,
      show: show,
      color: color,
      dotData: FlDotData(
        show: false,
        getDotPainter: (spot, percentage, bar, index) {
          return FlDotCirclePainter(radius: 1);
        },
      ),
      belowBarData: BarAreaData(
        show: true,
        color: fillColor,
      ),
      spots: data.map((e) {
        final spot = FlSpot(e.id.toDouble(), e.totalAmountCents / 100);
        return spot;
      }).toList(),
    );
  }

  Widget _buildChartDetails() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: RoundedContainer(
        color: Colors.grey.shade200,
        child: Column(
          children: [
            SizedBox(height: 16),
            Text(
              _controller.touchDataDate.format('MMM yyyy'),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            _buildSpotDetailItem(
              id: 1,
              title: 'Expense',
              value: _controller.touchedData?.expense.toMoney() ?? '',
            ),
            _buildSpotDetailItem(
              id: 2,
              title: 'Income',
              value: _controller.touchedData?.income.toMoney() ?? '',
            ),
            _buildSpotDetailItem(
              id: 3,
              title: 'Earnings',
              value: _controller.touchedData?.earnings.toMoney() ?? '',
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildSpotDetailItem({
    required int id,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
            ),
          ),
          SizedBox(width: 16),
          Checkbox(
            visualDensity: VisualDensity.compact,
            value: _controller.shouldDisplayInChart(id),
            onChanged: (value) {
              _controller.updateChartDisplay(id, value == true);
            },
          ),
        ],
      ),
    );
  }
}
