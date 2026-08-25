import 'package:expense_manager/components/expense_float_button.dart';
import 'package:expense_manager/components/transaction_group_item.dart';
import 'package:expense_manager/controllers/transactions_controller.dart';
import 'package:expense_manager/components/misc/custom_scaffold.dart';
import 'package:expense_manager/components/misc/placeholder_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionsPage extends StatelessWidget {
  TransactionsPage({super.key}) {
    Get.lazyReplace(() => TransactionsController());
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Transactions',
      floatingActionButton: ExpenseFloatButton(showIncome: true),
      body: GetBuilder<TransactionsController>(
        builder: (controller) {
          return PlaceholderView(
            show: controller.showPlaceholder,
            loading: controller.loading,
            title: 'No Expenses Yet',
            description:
                "Looks like you haven't added any expenses yet. Tap the \"+\" button below to add one.",
            child: ListView.builder(
              padding: EdgeInsets.only(bottom: 50),
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
}
