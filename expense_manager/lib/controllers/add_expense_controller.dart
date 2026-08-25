import 'package:expense_manager/components/amount_dialog.dart';
import 'package:expense_manager/constants.dart';
import 'package:expense_manager/controllers/base_controller.dart';
import 'package:expense_manager/misc/utils.dart';
import 'package:expense_manager/misc/extensions.dart';
import 'package:expense_manager/models/category.dart';
import 'package:expense_manager/models/expense.dart';
import 'package:expense_manager/models/tag.dart';
import 'package:expense_manager/pubsub.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddExpenseController extends BaseController {
  final List<Category> categories = [];
  final List<Tag> tags = [];
  final List<Tag> removeTags = [];
  late Expense expense;

  final noteController = TextEditingController();

  bool get isEdit => expense.id != null;
  bool get isNew => expense.id == null;

  AddExpenseController(Expense e) {
    expense = e.clone() as Expense;
    tags.assignAll(expense.tags);
  }

  get dateLabel => formatDate(expense.date, 'dd/MM/yyyy');

  @override
  void onInit() {
    super.onInit();
    noteController.text = expense.note;
    loadCategories();
  }

  @override
  void onReady() {
    super.onReady();

    if (isNew) {
      Get.dialog(AmountDialog(
        amount: expense.amountCents,
        onAmountChanged: (amount) => updateAmount(amount),
      ));
    }
  }

  void loadCategories() {
    kCategoryRepo.findAll().then((value) {
      categories.clear();
      categories.addAll(value);
      update();
    });
  }

  Future<void> saveExpense() async {
    expense.note = noteController.text;

    // check existing tags
    for (var tag in tags) {
      if (!tag.isFromRemark) continue;
      final existingTag =
          await kTagRepo.findByName(tag.name, caseSensitive: false);
      if (existingTag != null) {
        tag.id = existingTag.id;
      }
    }

    await kTransactionService.saveExpense(
      expense: expense,
      newTags: tags,
      removedTags: removeTags,
    );

    PubSub.onExpenseUpdated(expense);
  }

  void updateAmount(int amount) {
    expense.amountCents = amount;
    update();
  }

  void updateDate(DateTime date) {
    expense.date = date;
    update();
  }

  void excludeCalculation(bool excluded) {
    expense.isAdHoc = excluded;
    update();
  }

  Future<void> setCategory(int categoryId) async {
    final category = await kCategoryRepo.find(categoryId);
    expense.category.value = category;
    update();
  }

  Future<void> deleteExpense() async {
    await kExpenseRepo.delete(expense);
    PubSub.onExpenseUpdated(expense);
  }

  void updateTags(List<Tag> tags) {
    removeTags.assignAll(this.tags.toSet().difference(tags.toSet()));
    this.tags.assignAll(tags);
    update();
  }

  Future<void> removeTagFromExpense(Tag tag) async {
    tags.remove(tag);
    removeTags.addIf(!removeTags.contains(tag), tag);
    update();
  }
}
