import 'package:expense_manager/constants.dart';
import 'package:expense_manager/misc/extensions.dart';
import 'package:expense_manager/misc/utils.dart';
import 'package:expense_manager/models/expense.dart';
import 'package:expense_manager/models/income.dart';
import 'package:expense_manager/models/tag.dart';
import 'package:expense_manager/podo/home_banner_item.dart';
import 'package:expense_manager/services/base_service.dart';
import 'package:isar/isar.dart';

class TransactionService extends BaseService {
  Future<HomeBannerItem> getMonthlyData({required int month}) async {
    final start = DateTime.now().copyWith(month: month, day: 1).startDate();
    final end = start.endDate();
    final expenses =
        await kExpenseRepo.findByDateRange(start, end, sortByDate: false);
    final incomes =
        await kIncomeRepo.findByDateRange(start, end, sortByDate: false);

    final totalIncome = incomes.fold(0, (total, e) => total + e.amountCents);
    final totalExpense = expenses.fold(0, (total, e) => total + e.amountCents);
    return HomeBannerItem(
      month: friendlyDate(start, dateFormat: 'MMMM'),
      totalEarnings: totalIncome - totalExpense,
      totalIncome: totalIncome,
      totalExpense: totalExpense,
    );
  }

  Future<List<Tag>> findTagsByExpenseDates(DateTime start, DateTime end,
      {String searchText = '',
      bool sortAlphabetically = true,
      bool desc = false,
      las}) async {
    final tags = await isar.tags
        .filter()
        .nameMatches("*$searchText*", caseSensitive: false)
        .expenses((e) => e.dateBetween(start.startDate(), end.endDate()))
        .findAll();
    return tags;
  }

  Future<void> removeTagFromExpense(Tag tag, Expense expense) async {
    if (tag.id != null) {
      expense.tags.remove(tag);
      await kExpenseRepo.save(expense);

      tag.expenses.remove(expense);
      await kTagRepo.save(tag);
    }
  }

  Future<void> saveExpense({
    required Expense expense,
    List<Tag>? newTags,
    List<Tag>? removedTags,
  }) async {
    await isar.writeTxn(() async {
      // save expense if it's a new one
      if (expense.isNew) {
        await kExpenseRepo.save(expense, transaction: false);
      }

      // save tags
      for (var tag in newTags ?? []) {
        tag.expenses.add(expense);
        await kTagRepo.save(tag, transaction: false);
      }

      // remove deleted tags
      final tagsToRemove =
          (removedTags ?? []).where((e) => e.id != null).toList();
      for (var tag in tagsToRemove) {
        tag.expenses.remove(expense);
        await kTagRepo.save(tag, transaction: false);
      }

      await expense.saveTags(tagsToRemove, newTags ?? [], transaction: false);
    });
  }

  Future<void> saveIncome({
    required Income income,
  }) async {
    await kIncomeRepo.save(income);
  }
}
