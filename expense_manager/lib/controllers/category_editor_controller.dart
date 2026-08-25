import 'package:expense_manager/misc/extensions.dart';
import 'package:expense_manager/misc/utils.dart';
import 'package:expense_manager/constants.dart';
import 'package:expense_manager/models/category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryEditorController extends GetxController {
  final Category? category;
  Color? selectedColor;

  final nameController = TextEditingController();
  final budgetController = TextEditingController();

  CategoryEditorController({this.category}) {
    nameController.text = category?.name ?? '';
    budgetController.text = category?.budgetCents.toString() ?? '';
    selectedColor =
        category?.colorCode != null ? hexToColor(category!.colorCode!) : null;
  }

  Future<void> addOrUpdateCategory() async {
    final updatedCategory = category ?? Category();
    updatedCategory.name = nameController.text;
    updatedCategory.budgetCents =
        int.parse(budgetController.text.isEmpty ? '0' : budgetController.text) *
            100;
    updatedCategory.colorCode = selectedColor?.toHex();
    await kCategoryRepo.save(updatedCategory);
  }
}
