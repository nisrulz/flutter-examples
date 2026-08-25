import 'package:expense_manager/controllers/category_report_controller.dart';
import 'package:expense_manager/misc/extensions.dart';
import 'package:expense_manager/misc/utils.dart';
import 'package:expense_manager/fl_chart/custom_pie_chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CategoryPieChart extends StatelessWidget {
  final CategoryReportController controller;
  final Function(int index)? onAreaTouched;

  const CategoryPieChart({
    super.key,
    required this.controller,
    this.onAreaTouched,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPieChart(
          height: 300,
          centerSpaceRadius: 70,
          sectionsSpace: 0,
          overrideColor: true,
          sections: controller.categories.map((category) {
            final value =
                controller.categoryValueMap[category.id]?.amount.toDouble() ??
                    0;
            return PieChartSectionData(
              value: value,
              title: controller.getValuePercentage(category),
              radius: controller.isCategorySelected(category) ? 60 : 50,
              color: hexToColor(category.colorCode ?? '#AAAAAA'),
            );
          }).toList(),
          onAreaTouched: onAreaTouched,
        ),
        Column(
          children: [
            Text(controller.selectedCategory?.name ?? ''),
            Text(controller.selectedCategoryAmountCents.toMoney()),
          ],
        ),
      ],
    );
  }
}
