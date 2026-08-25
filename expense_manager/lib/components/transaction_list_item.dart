import 'package:expense_manager/misc/extensions.dart';
import 'package:expense_manager/misc/utils.dart';
import 'package:expense_manager/models/expense.dart';
import 'package:expense_manager/models/income.dart';
import 'package:expense_manager/models/transaction.dart';
import 'package:expense_manager/pages/add_expense_page.dart';
import 'package:expense_manager/pages/add_income_page.dart';
import 'package:flutter/material.dart';

class TransactionListItem extends StatelessWidget {
  final Transaction transaction;
  final bool hideAmount;

  const TransactionListItem({
    super.key,
    required this.transaction,
    this.hideAmount = false,
  });

  bool get isExpense => transaction is Expense;
  bool get isIncome => transaction is Income;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => _gotoPage(context),
      minVerticalPadding: 8,
      leading: SizedBox.square(
        dimension: 39,
        child: isExpense
            ? DecoratedBox(
                decoration: BoxDecoration(
                  color: _categoryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    transaction.note.isEmpty
                        ? ""
                        : transaction.note.substring(0, 1).toUpperCase(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            : Icon(Icons.attach_money),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(transaction.note),
          Text(
            friendlyDate(transaction.date),
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
      trailing: Text(
        obfuscateText(transaction.amountCents.toMoney(), obfuscate: hideAmount),
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Color get _categoryColor {
    return hexToColor(
        (transaction as Expense).category.value?.colorCode ?? '#FF9800');
  }

  void _gotoPage(BuildContext context) {
    if (isExpense) {
      gotoPage(context, AddExpensePage(expense: transaction as Expense));
    } else {
      gotoPage(context, AddIncomePage(income: transaction as Income));
    }
  }
}
