import 'package:expense_manager/components/category_editor_dialog.dart';
import 'package:expense_manager/components/category_square_box.dart';
import 'package:expense_manager/controllers/categories_controller.dart';
import 'package:expense_manager/components/custom_divider.dart';
import 'package:expense_manager/components/misc/custom_scaffold.dart';
import 'package:expense_manager/components/misc/placeholder_view.dart';
import 'package:expense_manager/misc/colors.dart';
import 'package:expense_manager/misc/utils.dart';
import 'package:expense_manager/models/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  CategoriesController get _controller => Get.find<CategoriesController>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Categories',
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        foregroundColor: Colors.white,
        backgroundColor: CustomColors.primary,
        onPress: () => _showCategoryDialog(context),
      ),
      body: GetBuilder<CategoriesController>(
          init: CategoriesController(),
          builder: (controller) {
            return PlaceholderView(
              show: controller.categories.isEmpty && controller.dataLoaded,
              loading: controller.loading,
              title: "No Categories",
              description:
                  "Looks like you don't have any category yet. Click the \"+\" button below to add one.",
              child: ListView.separated(
                padding: EdgeInsets.only(top: 8, bottom: 100),
                itemCount: controller.categories.length,
                separatorBuilder: (context, index) => CustomDivider(),
                itemBuilder: (context, index) {
                  final category = controller.categories[index];
                  return ListTile(
                    leading: CategorySquareBox(colorCode: category.colorCode),
                    title: Text(category.name ?? ''),
                    trailing: InkWell(
                      onTap: () => _showDeletionDialog(context, category),
                      child: Icon(Icons.delete),
                    ),
                    onTap: () =>
                        _showCategoryDialog(context, category: category),
                  );
                },
              ),
            );
          }),
    );
  }

  _showCategoryDialog(BuildContext context, {Category? category}) {
    showDialog(
      context: context,
      builder: (context) => CategoryEditorDialog(
        category: category,
        onComplete: () => _controller.loadCategories(),
      ),
    );
  }

  _showDeletionDialog(BuildContext context, Category category) {
    showDecisionDialog(
      context,
      title: "Delete \"${category.name}\"?",
      onPositivePressed: () => _controller.deleteCategory(category),
    );
  }
}
