import 'dart:io';
import 'package:expense_manager/constants.dart';
import 'package:expense_manager/models/category.dart';
import 'package:expense_manager/models/expense.dart';
import 'package:expense_manager/models/income.dart';
import 'package:expense_manager/models/tag.dart';
import 'package:expense_manager/repositories/base_repo.dart';
import 'package:expense_manager/repositories/category_repo.dart';
import 'package:expense_manager/repositories/expense_repo.dart';
import 'package:expense_manager/repositories/income_repo.dart';
import 'package:expense_manager/repositories/tag_repo.dart';
import 'package:expense_manager/services/base_service.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class RepoFactory {
  static Future<void> init({bool unitTest = false}) async {
    if (unitTest) {
      await Isar.initializeIsarCore(download: true);
    }

    final dir = unitTest
        ? Directory.systemTemp.createTempSync()
        : (await getApplicationDocumentsDirectory());
    final isar = await Isar.open(
      [
        ExpenseSchema,
        CategorySchema,
        IncomeSchema,
        TagSchema,
      ],
      directory: dir.path,
    );
    kIsar = isar;
    BaseRepo.setIsar = isar;
    BaseService.setIsar = isar;

    registerRepos();
  }

  static registerRepos() {
    getIt.registerLazySingleton(() => ExpenseRepo());
    getIt.registerLazySingleton(() => CategoryRepo());
    getIt.registerLazySingleton(() => IncomeRepo());
    getIt.registerLazySingleton(() => TagRepo());
  }
}
