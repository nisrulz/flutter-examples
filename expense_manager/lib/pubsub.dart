import 'package:expense_manager/controllers/transactions_controller.dart';
import 'package:expense_manager/controllers/home_controller.dart';
import 'package:expense_manager/models/expense.dart';
import 'package:expense_manager/models/income.dart';
import 'package:get/get.dart';
import 'controllers/expenses_controller.dart';

class PubSub {
  static S? _find<S>() {
    try {
      return Get.find<S>();
    } catch (e) {
      print(e);
    }
    return null;
  }

  static void onExpenseUpdated(Expense expense) {
    _find<TransactionsController>()?.loadData();
    _find<HomeController>()?.loadData();
    _find<ExpensesController>()?.loadExpenses();
  }

  static void onIncomeUpdated(Income income) {
    _find<TransactionsController>()?.loadData();
    _find<HomeController>()?.loadData();
  }
}
