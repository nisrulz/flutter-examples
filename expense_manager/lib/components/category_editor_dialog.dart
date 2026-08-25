import 'package:expense_manager/controllers/category_editor_controller.dart';
import 'package:expense_manager/components/button/negative_button.dart';
import 'package:expense_manager/components/button/positive_button.dart';
import 'package:expense_manager/components/dialog/custom_dialog.dart';
import 'package:expense_manager/components/form/custom_text_field.dart';
import 'package:expense_manager/components/label_widget.dart';
import 'package:expense_manager/misc/utils.dart';
import 'package:expense_manager/models/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:get/get.dart';

class CategoryEditorDialog extends StatelessWidget {
  final Category? category;
  final VoidCallback onComplete;

  CategoryEditorDialog({
    super.key,
    this.category,
    required this.onComplete,
  }) {
    Get.replace(CategoryEditorController(category: category));
  }

  bool get updating => category != null;

  CategoryEditorController get _controller =>
      Get.find<CategoryEditorController>();

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${updating ? 'Update' : 'New'} Category",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 16),
            CustomTextField(
              label: 'Category',
              controller: _controller.nameController,
            ),
            SizedBox(height: 16),
            CustomTextField(
              label: 'Budget',
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              controller: _controller.budgetController,
            ),
            SizedBox(height: 16),
            GetBuilder<CategoryEditorController>(builder: (controller) {
              return LabelWidget(
                label: 'Color',
                widget: MaterialColorPicker(
                  selectedColor: controller.selectedColor,
                  onColorChange: (value) => controller.selectedColor = value,
                ),
              );
            }),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                NegativeButton(),
                PositiveButton(
                  title: updating ? 'Update' : 'Add',
                  onPressed: () => update(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> update(BuildContext context) async {
    await _controller.addOrUpdateCategory();
    onComplete.call();

    if (context.mounted) {
      goBack(context);
    }
  }
}
