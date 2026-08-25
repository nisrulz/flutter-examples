import 'package:expense_manager/components/expense_float_button.dart';
import 'package:expense_manager/controllers/category_expenses_controller.dart';
import 'package:expense_manager/controllers/home_controller.dart';
import 'package:expense_manager/misc/extensions.dart';
import 'package:expense_manager/components/misc/custom_card.dart';
import 'package:expense_manager/components/misc/custom_scaffold.dart';
import 'package:expense_manager/misc/utils.dart';
import 'package:expense_manager/models/category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'expenses_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key}) {
    Get.lazyReplace(() => HomeController());
  }

  HomeController get _controller => Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Home',
      floatingActionButton: ExpenseFloatButton(showIncome: true),
      body: GetX<HomeController>(
        builder: (controller) {
          return SingleChildScrollView(
            child: Column(
              children: [
                // total income & expense of a month
                SizedBox(
                  height: 200,
                  child: PageView(
                    controller: controller.bannerController,
                    onPageChanged: (index) => controller.onPageChanged(index),
                    children: controller.bannerItems.map((e) {
                      return buildBannerWidget(
                        month: e.month.toUpperCase(),
                        totalEarnings: e.totalEarnings,
                        totalIncome: e.totalIncome,
                        totalExpense: e.totalExpense,
                      );
                    }).toList(),
                  ),
                ),

                // pager indicator
                if (controller.bannerItems.isNotEmpty)
                  PageViewDotIndicator(
                    currentItem: controller.bannerPageIndex.value,
                    count: controller.bannerItems.length,
                    unselectedColor: Colors.orange.shade100,
                    selectedColor: Colors.orange,
                    size: Size(10, 10),
                    unselectedSize: Size(10, 10),
                  ),

                SizedBox(height: 16),

                // categories
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: CustomCard(
                      color: Colors.white,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                'Categories',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            ...controller.categories.map((category) {
                              return _buildCategoryItem(context, category);
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildBannerWidget({
    required String month,
    required int totalEarnings,
    required int totalIncome,
    required int totalExpense,
  }) {
    return Column(
      children: [
        SizedBox(height: 16),
        buildBannerItem(
          title: month,
          amount: totalEarnings,
          valueColor: Colors.green,
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildBannerItem(title: 'INCOME', amount: totalIncome),
            buildBannerItem(title: 'EXPENSE', amount: totalExpense),
          ],
        ),
      ],
    );
  }

  Widget buildBannerItem({
    required String title,
    required int amount,
    Color? valueColor,
    Widget? rightIcon,
  }) {
    final child = Column(
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          amount.toMoney(),
          style: TextStyle(
            color: valueColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ],
    );

    return Padding(
      padding: EdgeInsets.all(8),
      child: rightIcon != null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [child, rightIcon],
            )
          : child,
    );
  }

  Widget _buildCategoryItem(BuildContext context, Category category) {
    final now = DateTime.now();
    final date =
        now.copyWith(month: now.month - _controller.bannerPageIndex.value);
    final totalSpending = category.amount;
    final progress = (totalSpending / 100) /
        (category.budgetCents == 0 ? 1 : category.budget);
    // final totalSpending = category.expenseAmountsIn(date.year, date.month);

    return InkWell(
      onTap: () => gotoPage(
          context,
          ExpensesPage(
            controller: CategoryExpensesController(
              category: category,
              startDate: date.startDate(),
              endDate: date.endDate(),
            ),
          )),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: Text(category.name ?? '')),
                Row(
                  children: [
                    Text(totalSpending.toMoney()),
                    Text(' / '),
                    Text(
                      category.budgetCents.toMoney(),
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: LinearProgressIndicator(
                value: progress,
                color: hexToColor(category.colorCode ?? '#000000'),
                minHeight: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
