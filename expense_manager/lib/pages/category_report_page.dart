import 'package:expense_manager/components/category_pie_chart.dart';
import 'package:expense_manager/components/month_filter_view.dart';
import 'package:expense_manager/controllers/category_expenses_controller.dart';
import 'package:expense_manager/controllers/category_report_controller.dart';
import 'package:expense_manager/misc/extensions.dart';
import 'package:expense_manager/misc/utils.dart';
import 'package:expense_manager/pages/expenses_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryReportPage extends StatelessWidget {
  const CategoryReportPage({super.key});

  CategoryReportController get _controller =>
      Get.find<CategoryReportController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryReportController>(
      init: CategoryReportController(),
      builder: (controller) {
        return CustomScrollView(
          slivers: [
            // date filter
            SliverToBoxAdapter(
              child: MonthFilterView(
                onDateSelected: (DateTime dt) => controller.filterByDate(dt),
              ),
            ),

            // pie chart
            SliverToBoxAdapter(
              child: CategoryPieChart(
                controller: _controller,
                onAreaTouched: (index) {
                  _controller.selectChartArea(index);
                },
              ),
            ),

            SliverToBoxAdapter(
              child: SizedBox(height: 16),
            ),

            // breakdown
            _buildCategoryBreakdown(),
          ],
        );
      },
    );
  }

  Widget _buildCategoryBreakdown() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: _controller.categories.length,
        (context, index) {
          final category = _controller.categories[index];
          return Column(
            children: [
              Divider(height: 0),
              ListTile(
                dense: true,
                onTap: () {
                  gotoPage(
                    context,
                    ExpensesPage(
                      controller: CategoryExpensesController(
                        category: category,
                        startDate: _controller.selectedDateTime?.startDate(),
                        endDate: _controller.selectedDateTime?.endDate(),
                      ),
                    ),
                  );
                },
                title: Row(
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                          color: hexToColor(category.colorCode ?? '#EEEEEE')),
                      child: SizedBox(width: 10, height: 30),
                    ),
                    SizedBox(width: 16),
                    Expanded(child: Text(category.name ?? '')),
                    Text(_controller.getValueAmount(category).toMoney()),
                  ],
                ),
                trailing: Text(_controller.getValuePercentage(category)),
              ),
            ],
          );
        },
      ),
    );
  }
}
