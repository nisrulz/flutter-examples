import 'package:expense_manager/components/month_filter_view.dart';
import 'package:expense_manager/components/misc/custom_scaffold.dart';
import 'package:expense_manager/misc/colors.dart';
import 'package:expense_manager/pages/category_report_page.dart';
import 'package:expense_manager/pages/monthly_report_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportsPage extends StatelessWidget {
  final reportType = ReportType.category.obs;

  ReportsPage({super.key}) {
    Get.put(MonthFilterController());
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        title: 'Reports',
        body: Obx(
          () => Column(
            children: [
              SizedBox(height: 16),
              CupertinoSlidingSegmentedControl<ReportType>(
                backgroundColor: CustomColors.primaryLight,
                groupValue: reportType.value,
                onValueChanged: (value) => reportType.value = value!,
                children: {
                  ReportType.category: Text(
                    'Category',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _getThumbColor(ReportType.category)),
                  ),
                  ReportType.monthly: Text(
                    'Monthly',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _getThumbColor(ReportType.monthly)),
                  ),
                },
              ),

              SizedBox(height: 8),

              // content
              Expanded(child: _buildPage(reportType.value)),
            ],
          ),
        ));
  }

  Widget _buildPage(ReportType reportType) {
    switch (reportType) {
      case ReportType.monthly:
        return MonthlyReportPage();
      case ReportType.category:
      default:
        return CategoryReportPage();
    }
  }

  Color? _getThumbColor(ReportType value) {
    return reportType.value == value ? null : Colors.black54;
  }
}

enum ReportType { category, monthly }
