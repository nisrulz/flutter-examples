import 'package:expense_manager/controllers/expenses_controller.dart';
import 'package:expense_manager/models/category.dart';
import 'package:expense_manager/models/expense.dart';
import 'package:isar/isar.dart';

class CategoryExpensesController extends ExpensesController {
  final Category category;
  final DateTime? startDate;
  final DateTime? endDate;

  CategoryExpensesController({
    required this.category,
    this.startDate,
    this.endDate,
  });

  @override
  Future<List<Expense>> getExpenses() async {
    await category.expenses.load();
    List<Expense> result;
    if (startDate != null && endDate != null) {
      result = await category.expenses
          .filter()
          .dateBetween(startDate!, endDate!)
          .sortByDateDesc()
          .findAll();
    } else {
      result = await category.expenses.filter().sortByDateDesc().findAll();
    }
    return await Future.value(result);
  }
}
