import 'package:expense_manager/constants.dart';
import 'package:expense_manager/misc/extensions.dart';
import 'package:expense_manager/services/shared_pref_service.dart';
import 'package:expense_manager/models/category.dart';
import 'package:expense_manager/models/expense.dart';
import 'package:expense_manager/podo/home_banner_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';

class HomeController extends GetxController {
  final bannerController = PageController();
  final categories = <Category>[].obs;
  final bannerItems = <HomeBannerItem>[].obs;
  final bannerPageIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    loadCategories();
    loadBannerData();
  }

  void onPageChanged(int index) {
    loadCategories();
    bannerPageIndex.value = index;
  }

  Future<void> loadCategories() async {
    final value = await kCategoryRepo.findAll();
    categories.assignAll(value);

    final now = DateTime.now();
    final date = now.copyWith(month: now.month - bannerPageIndex.value);
    for (var cat in categories) {
      final result = await cat.expenses
          .filter()
          .dateBetween(date.startDate(), date.endDate())
          .findAll();
      cat.amount = result.fold(0, (total, e) => total + e.amountCents);
    }

    categories.refresh();
  }

  Future<void> loadBannerData() async {
    final now = DateTime.now().startDate();
    final numOfMonth =
        await SharedPrefService().getInt(prefHomeMonthCount) ?? 3;
    final tasks = <Future<HomeBannerItem>>[];
    for (var i = 0; i < numOfMonth; i++) {
      tasks.add(
        kTransactionService.getMonthlyData(month: now.month - i),
      );
    }
    final results = await Future.wait(tasks);
    bannerItems.assignAll(results);
  }
}
