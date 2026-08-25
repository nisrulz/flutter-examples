import 'package:isar/isar.dart';

abstract class BaseRepo<T> {
  static late Isar _isar;

  static set setIsar(Isar instance) {
    _isar = instance;
  }

  Isar get isar => _isar;

  Future<void> save(T instance, {bool transaction = true});
  void saveSync(T instance, {bool transaction = false});
  Future<List<T>> findAll();
  Future<T?> find(int id);
  T? findSync(int id);
  Future<bool> delete(T instance);
  Future<void> deleteAll();
}
