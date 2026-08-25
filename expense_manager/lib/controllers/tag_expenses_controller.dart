import 'package:expense_manager/controllers/expenses_controller.dart';
import 'package:expense_manager/constants.dart';
import 'package:expense_manager/models/expense.dart';
import 'package:expense_manager/models/tag.dart';
import 'package:isar/isar.dart';

class TagExpensesController extends ExpensesController {
  final int tagId;
  late Tag tag;

  TagExpensesController({required this.tagId}) {
    tag = kTagRepo.findSync(tagId)!;
  }

  @override
  Future<List<Expense>> getExpenses() async {
    await tag.expenses.load();
    return await tag.expenses.filter().sortByDateDesc().findAll();
  }
}
