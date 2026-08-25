import 'package:expense_manager/models/income.dart';
import 'package:expense_manager/repositories/base_repo.dart';
import 'package:isar/isar.dart';

class IncomeRepo extends BaseRepo<Income> {
  @override
  Future<void> save(Income instance, {bool transaction = true}) async {
    func() async {
      await isar.incomes.put(instance);
    }

    if (transaction) {
      await isar.writeTxn(func);
    } else {
      await func.call();
    }
  }

  @override
  void saveSync(Income instance, {bool transaction = false}) {
    if (transaction) {
      isar.writeTxnSync(() {
        isar.incomes.putSync(instance);
      });
    }
  }

  @override
  Future<List<Income>> findAll() async {
    return await isar.incomes.where().sortByDateDesc().findAll();
  }

  @override
  Future<Income?> find(int id) async {
    return await isar.incomes.get(id);
  }

  @override
  Future<bool> delete(Income instance) async {
    if (instance.id == null) return false;
    return await isar.writeTxn(() => isar.incomes.delete(instance.id!));
  }

  @override
  Income? findSync(int id) {
    return isar.incomes.getSync(id);
  }

  Future<List<Income>> findByDateRange(
    DateTime? startDate,
    DateTime? endDate, {
    bool sortByDate = true,
    bool excludeAdHoc = true,
  }) async {
    if (startDate == null || endDate == null) return [];
    var query = isar.incomes
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
      await isar.incomes.clear();
    });
  }

  Future<List<Income>> findByAccountId(int accountId) async {
    return await isar.incomes
        .where()
        .filter()
        .accountIdEqualTo(accountId)
        .sortByDateDesc()
        .findAll();
  }
}
