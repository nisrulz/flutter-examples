import 'package:isar/isar.dart';

class BaseService {
  static late Isar _isar;

  static set setIsar(Isar instance) {
    _isar = instance;
  }

  Isar get isar => _isar;
}
