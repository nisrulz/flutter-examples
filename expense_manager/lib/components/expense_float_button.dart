import 'package:expense_manager/misc/colors.dart';
import 'package:expense_manager/misc/utils.dart';
import 'package:expense_manager/pages/add_expense_page.dart';
import 'package:expense_manager/pages/add_income_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class ExpenseFloatButton extends StatelessWidget {
  final bool showIncome;

  const ExpenseFloatButton({
    super.key,
    this.showIncome = true,
  });

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      backgroundColor: Colors.blue.shade700,
      children: [
        SpeedDialChild(
          backgroundColor: Colors.red.shade700,
          label: 'Add Expense',
          shape: CircleBorder(),
          onTap: () => gotoPage(context, AddExpensePage()),
          child: Icon(Icons.remove, color: Colors.white),
        ),
        if (showIncome)
          SpeedDialChild(
            backgroundColor: CustomColors.primary,
            label: 'Add Income',
            shape: CircleBorder(),
            onTap: () => gotoPage(context, AddIncomePage()),
            child: Icon(Icons.attach_money, color: Colors.white),
          ),
      ],
      child: Icon(Icons.add, color: Colors.white),
    );
  }
}
