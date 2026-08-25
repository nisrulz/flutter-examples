import 'package:expense_manager/models/expense.dart';
import 'package:expense_manager/repositories/base_repo.dart';
import 'package:isar/isar.dart';

class ExpenseRepo extends BaseRepo<Expense> {
  @override
  Future<void> save(Expense instance, {bool transaction = true}) async {
    func() async {
      await isar.expenses.put(instance);
      await instance.category.save();
      await instance.tags.save();
    }

    if (transaction) {
      await isar.writeTxn(func);
    } else {
      await func.call();
    }
  }

  @override
  void saveSync(Expense instance, {bool transaction = false}) {
    func() {
      isar.expenses.putSync(instance);
      instance.category.saveSync();
      instance.tags.saveSync();
    }

    if (transaction) {
      isar.writeTxnSync(func);
    } else {
      func.call();
    }
  }

  @override
  Future<List<Expense>> findAll() async {
    return await isar.expenses.where().sortByDateDesc().findAll();
  }

  @override
  Future<Expense?> find(int id) async {
    return await isar.expenses.get(id);
  }

  @override
  Expense? findSync(int id) {
    return isar.expenses.getSync(id);
  }

  @override
  Future<bool> delete(Expense instance) async {
    if (instance.id == null) return false;
    return await isar.writeTxn(() => isar.expenses.delete(instance.id!));
  }

  Future<List<Expense>> findByDateRange(
    DateTime? startDate,
    DateTime? endDate, {
    bool sortByDate = true,
    bool excludeAdHoc = true,
  }) async {
    if (startDate == null || endDate == null) return [];
    var query = isar.expenses
        .filter()
        .dateBetween(startDate, endDate)
        .and()
        .isAdHocEqualTo(!excludeAdHoc);
    if (sortByDate) {
      return await query.sortByDate().findAll();
    }
    return await query.findAll();
  }

  @override
  Future<void> deleteAll() async {
    await isar.writeTxn(() async {
      await isar.expenses.clear();
    });
  }

  Future<List<Expense>> findByAccountId(int accountId) async {
    return await isar.expenses
        .where()
        .filter()
        .accountIdEqualTo(accountId)
        .sortByDateDesc()
        .findAll();
  }
}
