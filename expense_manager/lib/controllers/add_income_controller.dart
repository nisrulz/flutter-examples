import 'package:expense_manager/misc/extensions.dart';
import 'package:expense_manager/constants.dart';
import 'package:expense_manager/models/income.dart';
import 'package:expense_manager/pubsub.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddIncomeController extends GetxController {
  late Income income;

  final noteController = TextEditingController();

  AddIncomeController(Income i) {
    income = i.clone() as Income;
  }

  @override
  void onInit() {
    super.onInit();
    noteController.text = income.note;
  }

  void updateAmount(int amount) {
    income.amountCents = amount;
    update();
  }

  void updateDate(DateTime date) {
    income.date = date;
    update();
  }

  Future<void> save() async {
    income.note = noteController.text;

    await kTransactionService.saveIncome(income: income);
    PubSub.onIncomeUpdated(income);
  }

  Future<void> deleteIncome() async {
    await kIncomeRepo.delete(income);
    PubSub.onIncomeUpdated(income);
  }
}
