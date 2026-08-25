import 'package:expense_manager/components/expense_float_button.dart';
import 'package:expense_manager/components/transaction_group_item.dart';
import 'package:expense_manager/controllers/expenses_controller.dart';
import 'package:expense_manager/misc/extensions.dart';
import 'package:expense_manager/components/misc/bottom_bar_container.dart';
import 'package:expense_manager/components/misc/custom_scaffold.dart';
import 'package:expense_manager/components/misc/placeholder_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpensesPage extends StatelessWidget {
  final String pageTitle;
  final ExpensesController controller;
  final bool showExpenseFloatButton;

  const ExpensesPage({
    super.key,
    required this.controller,
    this.pageTitle = 'Expenses',
    this.showExpenseFloatButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: pageTitle,
      floatingActionButton:
          showExpenseFloatButton ? ExpenseFloatButton() : null,
      bottomNavigationBar: _buildBottomContainer(context),
      body: GetBuilder<ExpensesController>(
        init: controller,
        builder: (controller) {
          return PlaceholderView(
            title: 'No Expenses Yet',
            description: "Looks like you don't have any expenses yet",
            show: controller.transactions.isEmpty && controller.dataLoaded,
            loading: controller.loading,
            child: ListView.builder(
              itemCount: controller.transactions.keys.length,
              itemBuilder: (context, index) {
                final expenses = controller.transactions.values.toList()[index];
                final groupName = controller.transactions.keys.toList()[index];

                return TransactionGroupItem(
                  transactions: expenses,
                  groupName: groupName,
                  initiallyExpanded: index == 0,
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildBottomContainer(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (controller) {
        return BottomBarContainer(
          padding: EdgeInsets.zero,
          borderRadius: BorderRadius.circular(32),
          color: Colors.white,
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              title: Row(
                children: [
                  Icon(Icons.info, color: Colors.orange),
                  SizedBox(width: 10),
                  Text(
                    'Summary',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Divider(),
                ),
                ListTile(
                  visualDensity: VisualDensity.compact,
                  contentPadding: EdgeInsets.symmetric(horizontal: 24),
                  title: Text(
                    'No. of Transactions',
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                  trailing: Text(
                    controller.totalCount.toString(),
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                ListTile(
                  visualDensity: VisualDensity.compact,
                  contentPadding: EdgeInsets.symmetric(horizontal: 24),
                  title: Text(
                    'Total (\$)',
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                  trailing: Text(
                    controller.totalSum.toMoney(),
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
