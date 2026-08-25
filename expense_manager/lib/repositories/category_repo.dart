import 'package:expense_manager/models/category.dart';
import 'package:expense_manager/models/expense.dart';
import 'package:expense_manager/repositories/base_repo.dart';
import 'package:isar/isar.dart';

class CategoryRepo extends BaseRepo<Category> {
  @override
  Future<void> save(Category instance, {bool transaction = true}) async {
    func() async {
      await isar.categorys.put(instance);
    }

    if (transaction) {
      await isar.writeTxn(func);
    } else {
      await func.call();
    }
  }

  @override
  void saveSync(Category instance, {bool transaction = false}) {
    if (transaction) {
      isar.writeTxnSync(() {
        isar.categorys.putSync(instance);
      });
    }
  }

  @override
  Future<List<Category>> findAll() async {
    return await isar.categorys.where().findAll();
  }

  @override
  Future<Category?> find(int id) async {
    return await isar.categorys.get(id);
  }

  @override
  Category? findSync(int id) {
    return isar.categorys.getSync(id);
  }

  @override
  Future<bool> delete(Category instance) async {
    if (instance.id == null) return false;
    return await isar.writeTxn(() => isar.categorys.delete(instance.id!));
  }

  Future<List<Category>> findAllWithExpenses({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    var query = isar.categorys.filter().expensesIsNotEmpty();

    if (startDate != null && endDate != null) {
      query = query.expenses((q) => q.dateBetween(startDate, endDate));
    }
    return await query.findAll();
  }

  @override
  Future<void> deleteAll() async {
    await isar.writeTxn(() async {
      await isar.categorys.clear();
    });
  }
}
