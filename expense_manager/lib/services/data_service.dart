import 'dart:math';
import 'package:expense_manager/constants.dart';
import 'package:expense_manager/misc/extensions.dart';
import 'package:expense_manager/models/category.dart';
import 'package:expense_manager/models/expense.dart';
import 'package:expense_manager/models/income.dart';
import 'package:expense_manager/models/tag.dart';
import 'package:expense_manager/services/base_service.dart';
import 'package:faker/faker.dart';

class DataService extends BaseService {
  Future<void> initialiseAppValues() async {
    final initialised = await kSharedPrefService.getBoolean(prefAppInit);
    if (initialised) return;

    final categories = [
      Category(
          name: 'Food & Drinks', budgetCents: 1000 * 100, colorCode: '#FDD835'),
      Category(
          name: 'Entertainment', budgetCents: 500 * 100, colorCode: '#E53935'),
      Category(
          name: 'Transportation', budgetCents: 300 * 100, colorCode: '#8D6E63'),
      Category(name: 'Education', budgetCents: 300 * 100, colorCode: '#FF9800'),
      Category(name: 'Health', budgetCents: 300 * 100, colorCode: '#43A047'),
      Category(name: 'Travel', budgetCents: 2000 * 100, colorCode: '#1E88E5'),
    ];
    for (var element in categories) {
      await kCategoryRepo.save(element);
    }
    await kSharedPrefService.setBoolean(prefAppInit, true);
  }

  Future<void> loadTestingData() async {
    // clear everything first
    await kCategoryRepo.deleteAll();
    await kTagRepo.deleteAll();
    await kExpenseRepo.deleteAll();
    await kIncomeRepo.deleteAll();

    final faker = Faker();

    // categories
    final categories = [
      Category(
          name: 'Entertainment', budgetCents: 500 * 100, colorCode: '#E53935'),
      Category(
          name: 'Food & Drinks', budgetCents: 1000 * 100, colorCode: '#FDD835'),
      Category(
          name: 'Transportation', budgetCents: 300 * 100, colorCode: '#8D6E63'),
      Category(name: 'Education', budgetCents: 300 * 100, colorCode: '#FF9800'),
      Category(name: 'Health', budgetCents: 300 * 100, colorCode: '#43A047'),
      Category(name: 'Travel', budgetCents: 2000 * 100, colorCode: '#1E88E5'),
    ];
    for (var element in categories) {
      await kCategoryRepo.save(element);
    }

    // tags
    final tags = [
      Tag.create(name: 'food', colorCode: '#E53935'),
      Tag.create(name: 'love', colorCode: '#FDD835'),
      Tag.create(name: 'speed', colorCode: '#8D6E63'),
      Tag.create(name: 'lorem', colorCode: '#FF9800'),
      Tag.create(name: 'ipsum', colorCode: '#43A047'),
      Tag.create(name: 'okay', colorCode: '#1E88E5'),
    ];
    for (var element in tags) {
      await kTagRepo.save(element);
    }

    // expenses TTM
    final now = DateTime.now();
    for (var i = 0; i < 12; i++) {
      var dt = now.lastMonth(numOfMonth: i);
      for (var i = 0; i < 50; i++) {
        final date = dt.copyWith(
          year: dt.year,
          month: dt.month,
          day: Random().nextInt(dt.day + 1),
        );
        final expense = Expense(
          amountCents: random.integer(100 * 100, min: 10 * 100),
          note: faker.lorem.word(),
        )
          ..date = date
          ..category.value =
              categories[random.integer(categories.length - 1, min: 0)];

        final tag = tags[random.integer(tags.length - 1)];
        tag.expenses.add(expense);
        expense.tags.add(tag);
        await kExpenseRepo.save(expense);
        await kTagRepo.save(tag);
      }
    }

    // incomes TTM
    for (var i = 0; i < 12; i++) {
      var date = now.lastMonth(numOfMonth: i);
      final income = Income(
        amountCents: random.integer(15000 * 100, min: 10000 * 100),
        note: faker.lorem.word(),
      )..date = date;
      await kIncomeRepo.save(income);
    }
  }

  // for development purposes only
  Future<void> clearAll() async {
    await kCategoryRepo.deleteAll();
    await kExpenseRepo.deleteAll();
    await kIncomeRepo.deleteAll();
    await kTagRepo.deleteAll();
  }
}
