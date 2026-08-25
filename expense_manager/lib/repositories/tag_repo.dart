import 'package:expense_manager/models/tag.dart';
import 'package:expense_manager/repositories/base_repo.dart';
import 'package:isar/isar.dart';

class TagRepo extends BaseRepo<Tag> {
  @override
  Future<void> save(Tag instance, {bool transaction = true}) async {
    func() async {
      await isar.tags.put(instance);
      await instance.expenses.save();
    }

    if (transaction) {
      await isar.writeTxn(func);
    } else {
      await func();
    }
  }

  @override
  void saveSync(Tag instance, {bool transaction = false}) {
    if (transaction) {
      isar.writeTxnSync(() {
        isar.tags.putSync(instance);
        instance.expenses.saveSync();
      });
    }
  }

  @override
  Future<List<Tag>> findAll() async {
    return await isar.tags.where().sortByName().findAll();
  }

  @override
  Future<Tag?> find(int id) async {
    return await isar.tags.get(id);
  }

  @override
  Future<bool> delete(Tag instance) async {
    if (instance.id == null) return false;
    return await isar.writeTxn(() => isar.tags.delete(instance.id!));
  }

  @override
  Tag? findSync(int id) {
    return isar.tags.getSync(id);
  }

  Future<List<Tag>> search(String pattern) async {
    if (pattern.length < 2) return [];
    return await isar.tags
        .filter()
        .nameMatches("*$pattern*", caseSensitive: false)
        .sortByName()
        .findAll();
  }

  Future<Tag?> findByName(String name, {bool caseSensitive = true}) async {
    return await isar.tags
        .filter()
        .nameEqualTo(name, caseSensitive: caseSensitive)
        .findFirst();
  }

  @override
  Future<void> deleteAll() async {
    await isar.writeTxn(() async {
      await isar.tags.clear();
    });
  }
}
