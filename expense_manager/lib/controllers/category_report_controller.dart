import 'package:expense_manager/misc/extensions.dart';
import 'package:expense_manager/constants.dart';
import 'package:expense_manager/models/category.dart';
import 'package:expense_manager/models/expense.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';

class CategoryReportController extends GetxController {
  final List<Category> categories = [];
  final Map<int, _ChartData> categoryValueMap = {};
  Category? selectedCategory;
  double total = 0;
  DateTime? selectedDateTime;

  int get selectedCategoryAmountCents {
    return categoryValueMap[selectedCategory?.id]?.amount ?? 0;
  }

  @override
  void onInit() {
    super.onInit();
    final now = DateTime.now();
    selectedDateTime = now;
    loadChartData(
      startDate: now.startDate(),
      endDate: now.endDate(),
    );
  }

  Future<void> loadChartData({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    total = 0;
    categories.assignAll(await kCategoryRepo.findAllWithExpenses(
      startDate: startDate,
      endDate: endDate,
    ));

    for (var category in categories) {
      var amount = 0;
      if (startDate != null && endDate != null) {
        final query = category.expenses
            .filter()
            .dateBetween(startDate, endDate)
            .findAll();
        amount = (await query).sumAmounts();
      } else {
        amount = category.expenses.toList().sumAmounts();
      }

      total += amount;
      categoryValueMap[category.id!] = _ChartData(
        amount: amount,
        percentage: (amount / total) * 100,
      );
    }

    update();
  }

  void selectChartArea(int index) {
    selectedCategory = categories[index];
    update();
  }

  bool isCategorySelected(Category category) {
    return category.id == selectedCategory?.id;
  }

  String getValuePercentage(Category category) {
    final value = categoryValueMap[category.id]?.amount.toDouble() ?? 0;
    return "${((value / total) * 100).toStringAsFixed(0)}%";
  }

  int getValueAmount(Category category) {
    final value = categoryValueMap[category.id]?.amount ?? 0;
    return value;
  }

  void filterByDate(DateTime dt) {
    selectedDateTime = dt;
    loadChartData(
      startDate: dt.startDate(),
      endDate: dt.endDate(),
    );
  }
}

class _ChartData {
  final int amount;
  final double percentage;

  _ChartData({
    required this.amount,
    required this.percentage,
  });
}
